// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFTMarketplace} from "../src/NFTMarketplace.sol";
import {MyToken} from "../src/MyToken.sol";
import {MyNFT} from "../src/MyNFT.sol";

contract NFTMarketplaceTest is Test {
    NFTMarketplace public nftMarket;
    address admin = makeAddr("admin");
    address tokenAddress = makeAddr("token");
    address nftAddress = makeAddr("nft");
    address buyerAddress = makeAddr("buyer");
    MyToken public token;
    MyNFT public nft;
struct Listing {
        uint256 tokenId; //id
        address seller; //拥有者
        uint256 price; // 以wei为单位
        bool active; //是否活跃
    }
    mapping(uint256 => Listing) public lists;
    function setUp() public {

        //管理员身份先部署以及铸造基本
        vm.startPrank(admin);
        {
            token =new MyToken(admin);
            //给买家铸造token
            token.mint(buyerAddress,10000);
            //token.approve()
            nft = new MyNFT(admin);
            nft.safeMint(admin,'json');
            nft.safeMint(admin,'jsonjson');

        nftMarket = new NFTMarketplace(admin, address(token), address(nft));
            nft.approve(address(nftMarket), 0);
            nft.approve(address(nftMarket), 1);
        }
        vm.stopPrank();
        //切换buyer身份授权 erc20 token给buyer
        vm.startPrank(buyerAddress);
        {
        token.approve(address(nftMarket),10000);       
        }
        vm.stopPrank();



    }

    function test_listNFT() public {  
        //拥有者list上架
        vm.startPrank(admin);
        {
        nftMarket.listNFT(1,100);   
        //nftMarket.getListByTokenID(0);     
        }
        vm.stopPrank();
        assertTrue(nftMarket.getListByTokenID(1)== 1, "expect tokenId = 0.");  
    }
    function test_BuyNFT() public {  
         //拥有者list上架
        vm.startPrank(admin);
        {
        nftMarket.listNFT(0,100);   
        //nftMarket.getListByTokenID(0);     
        }

        //buyer身份
        vm.startPrank(buyerAddress);
        {
        nftMarket.buyNFT(0, 100);
        console.log("token.balanceOf(admin)==",token.balanceOf(admin));
        console.log("token.balanceOf(buyerAddress)==",token.balanceOf(buyerAddress));
        
        //nftMarket.getListByTokenID(0);     
        }
        vm.stopPrank();
        assertTrue(token.balanceOf(admin)== 100, "expect balance =100");  
        assertTrue(token.balanceOf(buyerAddress)== 9900, "expect balance =9900"); 
    }

    function test_tokensReceived() public{
        //拥有者list上架
        vm.startPrank(admin);
        {
        nftMarket.listNFT(1,100);   
        //nftMarket.getListByTokenID(0);     
        }
        vm.stopPrank();
        //buyer身份
        vm.startPrank(buyerAddress);
        {
        console.log("abi decode==",abi.decode(abi.encode(uint256(1)),(uint256)));
        token.transferWithCallbackBuyNFT(address(nftMarket),100,abi.encode(uint256(1)));
        }
        vm.stopPrank();

        assertTrue(token.balanceOf(admin)== 100, "expect balance =100");  
        assertTrue(token.balanceOf(buyerAddress)== 9900, "expect balance =9900"); 

    }
}
