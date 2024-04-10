// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SLMinterOracle} from "../src/SLMinterOracle.sol";
import {SLRouter} from "../src/SLRouter.sol";
import {IUniRouter} from "../src/interfaces/IUniRouter.sol";
import {IUniswapFactory} from "../src/interfaces/IUniFactory.sol";
import {SLERC20} from "../src/SLERC20.sol";

//@NOTE: Test from forked chain (arbitrum)
//unofficial uniswap address on arbitrum sepolia is 0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008

contract SLMinterOracleTest is Test {

    SLRouter slrouter;
    SLMinterOracle slmintorac;
    IUniRouter uniRouter;
    IUniswapFactory factory;
    address alice = address(0xabe);
    address bob = address(0xbeef);

    function setUp() public {
        uniRouter = IUniRouter(0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008);
        //factory = IUniswapFactory();
        //slrouter = new SLRouter();
        slmintorac = new SLMinterOracle(uniRouter);
        slmintorac.setSLRouter(address(slrouter));
        
    }

    function testMint() public {
        startHoax(alice);
        uint mintAmt = 1000;
        SLERC20 mintedAsset = slmintorac.createBrand(
            "American Airlines Miles",
            "AAMILES",
            mintAmt,
            alice
        );
        assertEq(mintAmt * 10 ** 18, mintedAsset.balanceOf(alice));

    }

    function testCreateMarket() public {
        startHoax(alice);
        uint mintAmt = 1000;
        SLERC20 brandone = slmintorac.createBrand(
            "American Airlines Miles",
            "AAMILES",
            mintAmt,
            alice
        );
        SLERC20 brandtwo = slmintorac.createBrand(
            "StarBucks Points",
            "STRPNTS",
            mintAmt,
            alice
        );

    }

    function testAddLiquidity() public {}

    function testSwap() public {}

    function testGetPrice() public {}
}

// BRANDS

// Starbucks points
// American Airlines Miles
