// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Fungus.sol";

contract CounterTest is Test {
    Fungus public fungus;
    address bob = address(0x1);

    function setUp() public {
        fungus = new Fungus();
    }

    function testMint() public {
        // Act as bob
        vm.startPrank(bob);
        fungus.mint(bob, 1);

        assertEq(fungus.balanceOf(bob), 1);

        fungus.tokenURI(1);
        console.logString(string(fungus.tokenURI(1)));
        vm.stopPrank();
    }
}
