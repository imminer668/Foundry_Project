// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {BigBank} from "../src/BigBank.sol";
import {MyToken} from "../src/MyToken.sol";

contract BigBankTest is Test {
    BigBank bank;

    address admin = makeAddr("admin");
    address alice = makeAddr("alice");

    function setUp() public {
        deal(alice, 100000 ether);

        vm.startPrank(admin);
        {
            bank = new BigBank(admin);
        }
        vm.stopPrank();
    }

    function test_Owner() public {
        assertEq(bank.owner(), admin, "expect owner is admin");
    }

    function test_Deposit() public {
        vm.startPrank(alice);
        {
            uint256 amount = 1 ether;
            (bool success, ) = address(bank).call{value: amount}("");
            assertTrue(success, "expect transfer ok!");
        }
        vm.stopPrank();
    }

    /// forge-config: default.fuzz.runs = 1000
    function testFuzz_Deposit(uint256 amount) public {
        vm.startPrank(alice);
        {
            vm.assume(amount > 0.001 ether);
            vm.assume(amount < 1 ether);
            uint256 banlaceBefore = bank.TotalBalances();
            (bool success, ) = address(bank).call{value: amount}("");
            assertTrue(success, "expect deposit ok!");
            assertEq(
                bank.TotalBalances(),
                banlaceBefore + amount,
                "expect balance += amount"
            );
        }
        vm.stopPrank();
    }

    /// forge-config: default.fuzz.runs = 1000
    function testFuzz_withDrawNoOwner(uint256 amount) public {
        vm.startPrank(alice);
        {
            bank.withdraw(payable(alice),1);
            //bytes memory wantErr=abi.encodeWithSelector(bank.ownableUnauthorizedAccount.selector,alice); 
            //console.logBytes(wantErr);
            //vm.expectRevert(wantErr);
            vm.expectRevert("is not owner");


        }
        vm.stopPrank();
    }

    function testFuzz_withDraw(uint256 amount) public {
        vm.assume(amount > 0.001 ether);
        vm.assume(amount < 1 ether);
        (bool success, ) = address(bank).call{value: amount}("");
         assertTrue(success, "expect transfer ok!");
        vm.startPrank(admin);
        {
            bank.withdraw(payable(admin),address(bank).balance);
            //bytes memory wantErr=abi.encodeWithSelector(bank.ownableUnauthorizedAccount.selector,alice); 
            //console.logBytes(wantErr);
            //vm.expectRevert(wantErr);
            //vm.expectRevert("is not owner");
            assertEq(address(bank).balance,0,"clear");


        }
        vm.stopPrank();
    }

}
