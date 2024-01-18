// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFTMarketplace} from "../src/NFTMarketplace.sol";
import {MyToken} from "../src/MyToken.sol";
import {MyNFT} from "../src/MyNFT.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFTMarketplaceTest is Test {
    using Strings for uint256;
    NFTMarketplace public nftMarket;
    address admin = makeAddr("admin");
    address tokenAddress = makeAddr("token");
    address nftAddress = makeAddr("nft");
    address sellerAddress = makeAddr("seller");
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
            token = new MyToken(admin);
            //给买家铸造token
            token.mint(buyerAddress, 10000);
            //token.approve()
            nft = new MyNFT(admin);
            //铸造了nft
            //nft.safeMint(admin,'json');
            //nft.safeMint(admin,'jsonjson');

            nftMarket = new NFTMarketplace(admin, address(token), address(nft));
            //授权nft给nftMarket合约
            //nft.approve(address(nftMarket), 0);
            //nft.approve(address(nftMarket), 1);
        }
        vm.stopPrank();
        //切换buyer身份，授权erc20 token给nftMarket合约
        vm.startPrank(buyerAddress);
        {
            token.approve(address(nftMarket), 1000000000);
        }
        vm.stopPrank();
        //测试fuzz前先，mint 1000个和approve1000 nft
        mintMuchNFT(sellerAddress,1000);
        approveMuchNFT(sellerAddress,address(nftMarket),1000);
    }

    

    function mintMuchNFT(address who, uint256 amount) private {
        //管理员身份先部署以及铸造基本
        vm.startPrank(admin);
        {
            for (uint256 i = 0; i < amount; i++) {
                //铸造了nft
                nft.safeMint(who, i.toString());
            }
        }
        vm.stopPrank();
    }

    function approveMuchNFT(address from,address to, uint256 amount) private {
        //管理员身份先部署以及铸造基本
        vm.startPrank(from);
        {
            for (uint256 i = 0; i < amount; i++) {
                //approve nft
                //nft.safeMint(who, i.toString());
                nft.approve(address(to), i);
            }
        }
        vm.stopPrank();
    }    

    function list(uint256 tokenId, uint256 amount) private {
        //拥有者list上架
        vm.startPrank(sellerAddress);
        {
            nftMarket.listNFT(tokenId, amount);
            //nftMarket.getListByTokenID(0);
        }
        vm.stopPrank();
        //assertTrue(nftMarket.getListByTokenID(1) == 1, "expect tokenId = 0.");
    }

    function test_listNFT() private {
        list(1, 100);
    }
    
      function testFuzz_listNFT(uint256 amount) public {
        
        vm.assume(amount<1000);
        
        list(amount, amount);

        /*
    vm.assume(amount > 0);
    mintMuchNFT(sellerAddress,amount);
    approveMuchNFT(sellerAddress,address(nftMarket),amount);
    list(amount, 100);
        */
    // snip
}

    function test_BuyNFT() public {
        //拥有者list上架
        //vm.startPrank(admin);
        //{
        //nftMarket.listNFT(0,100);
        //nftMarket.getListByTokenID(0);
        //}
        list(1, 100);

        //buyer身份
        vm.startPrank(buyerAddress);
        {
            nftMarket.buyNFT(1, 100);
            console.log("token.balanceOf(admin)==", token.balanceOf(admin));
            console.log(
                "token.balanceOf(buyerAddress)==",
                token.balanceOf(buyerAddress)
            );

            //nftMarket.getListByTokenID(0);
        }
        vm.stopPrank();
        assertTrue(token.balanceOf(admin) == 100, "expect balance =100");
        assertTrue(
            token.balanceOf(buyerAddress) == 9900,
            "expect balance =9900"
        );
    }


    function testFuzz_BuyNFT(uint256 amount) public {
        
        vm.assume(amount<1000);
        
        list(amount, amount);

        uint256 sellerBalance= token.balanceOf(sellerAddress);
        uint256 buyerBalance= token.balanceOf(buyerAddress);
        //buyer身份
        vm.startPrank(buyerAddress);
        {
            

            nftMarket.buyNFT(amount, amount);
            console.log("token.balanceOf(admin)==", token.balanceOf(admin));
            console.log(
                "token.balanceOf(buyerAddress)==",
                token.balanceOf(buyerAddress)
            );

            //nftMarket.getListByTokenID(0);
        }
        vm.stopPrank();
        assertTrue(token.balanceOf(sellerAddress) == (sellerBalance+amount), "expect balance =+");
        assertTrue(
            token.balanceOf(buyerAddress) ==buyerBalance -amount,
            "expect balance=-"
        );
    }    

    function test_tokensReceived() public {
        vm.startPrank(admin);
        {
            //拥有者list上架
            nftMarket.listNFT(1, 100);
            //nftMarket.getListByTokenID(0);
        }
        vm.stopPrank();
        //buyer身份
        vm.startPrank(buyerAddress);
        {
            console.log(
                "abi decode==",
                abi.decode(abi.encode(uint256(1)), (uint256))
            );
            token.transferWithCallbackBuyNFT(
                address(nftMarket),
                100,
                abi.encode(uint256(1))
            );
        }
        vm.stopPrank();

        assertTrue(token.balanceOf(admin) == 100, "expect balance =100");
        assertTrue(
            token.balanceOf(buyerAddress) == 9900,
            "expect balance =9900"
        );
    }
}
