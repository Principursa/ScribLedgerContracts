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
        factory = IUniswapFactory(0x7E0987E5b3a30e3f2828572Bb659A548460a3003);
        slrouter = new SLRouter(address(factory), address(uniRouter));
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
        address pair = factory.createPair(address(brandone), address(brandtwo));
        assertEq(factory.getPair(address(brandone), address(brandtwo)), pair);
    }

    function testAddLiquidity() public {
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
        address pair = factory.createPair(address(brandone), address(brandtwo));
        uint liqAmt = 100 * 10 ** 18;
        brandone.approve(address(uniRouter), liqAmt);
        brandtwo.approve(address(uniRouter), liqAmt);
        uniRouter.addLiquidity(
            address(brandone),
            address(brandtwo),
            liqAmt,
            liqAmt,
            0,
            0,
            alice,
            1812835479
        );
        assertGt(SLERC20(pair).balanceOf(alice), 0);
        //assertEq(factory.getPair(address(brandone), address(brandtwo)),pair);
    }

    function testSwap() public {
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
        address pair = factory.createPair(address(brandone), address(brandtwo));
        uint liqAmt = 100 * 10 ** 18;
        brandone.approve(address(uniRouter), liqAmt);
        brandtwo.approve(address(uniRouter), liqAmt);
        uniRouter.addLiquidity(
            address(brandone),
            address(brandtwo),
            liqAmt,
            liqAmt,
            0,
            0,
            alice,
            1812835479
        );
        brandone.approve(address(uniRouter), 1000);
        address[] memory t  = new address[](2);
        t[0] = address(brandone);
        t[1] = address(brandtwo);
        uint prevTokenAmt = brandone.balanceOf(alice);
        uniRouter.swapExactTokensForTokens(1000, 0, t, alice, 1812835479);
        uint newTokenAmt = brandone.balanceOf(alice);
        assertGt(prevTokenAmt, newTokenAmt);
        //assertGt(SLERC20(pair).balanceOf(alice),0);
    }

    function testQRTransfer() public {
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
        brandone.transfer(address(slmintorac),1000);
        slmintorac.transferBrand(brandone, 1000, bob);
        uint bobAmt = brandone.balanceOf(bob);
        assertGt(bobAmt,0);
    }

    function testGetPrice() public {
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
        address pair = factory.createPair(address(brandone), address(brandtwo));
        uint liqAmt = 100 * 10 ** 18;
        brandone.approve(address(uniRouter), liqAmt);
        brandtwo.approve(address(uniRouter), liqAmt);
        uniRouter.addLiquidity(
            address(brandone),
            address(brandtwo),
            liqAmt,
            liqAmt,
            0,
            0,
            alice,
            1812835479
        );


    }
}

// BRANDS

// Starbucks points
// American Airlines Miles
