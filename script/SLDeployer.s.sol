// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {SLMinterOracle} from "../src/SLMinterOracle.sol";
import {IUniRouter} from "../src/interfaces/IUniRouter.sol";
import {SLERC20} from "../src/SLERC20.sol";
import {IUniswapFactory} from "../src/interfaces/IUniFactory.sol";

contract SLScript is Script{
    IUniRouter uniswapRouterAddress;
    IUniswapFactory factory;
    function setUp() public {
        uniswapRouterAddress = IUniRouter(0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008);
        factory = IUniswapFactory(0x7E0987E5b3a30e3f2828572Bb659A548460a3003);

    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        SLMinterOracle slminteroracle = new SLMinterOracle(uniswapRouterAddress);
        SLERC20 deltamiles = slminteroracle.createBrand("Delta Miles", "MILES", 100000, msg.sender);
        SLERC20 starbucks = slminteroracle.createBrand("Starbucks Points", "POINTS", 100000, msg.sender);
        SLERC20 walmart = slminteroracle.createBrand("Walmart Points", "POINTS", 100000, msg.sender);
        SLERC20 shell = slminteroracle.createBrand("Shell Gallons", "GALLONS", 100000, msg.sender);
        SLERC20 regal = slminteroracle.createBrand("Regal Cinema Points", "POINTS", 100000, msg.sender);
        SLERC20 mcdonalds = slminteroracle.createBrand("McDonalds Points", "POINTS", 100000, msg.sender);
        SLERC20 amazon = slminteroracle.createBrand("Amazon Points", "POINTS", 100000, msg.sender);
        SLERC20 sephora = slminteroracle.createBrand("Sephora Points", "POINTS", 100000, msg.sender);
        SLERC20 walgreens = slminteroracle.createBrand("Walgreen Points", "POINTS", 100000, msg.sender);
        SLERC20 lyft = slminteroracle.createBrand("Lyft Points", "POINTS", 100000, msg.sender);
        factory.createPair(address(deltamiles),address(starbucks));
        factory.createPair(address(starbucks),address(walmart));
        factory.createPair(address(walmart),address(shell));
        factory.createPair(address(shell),address(regal));
        factory.createPair(address(regal),address(mcdonalds));
        factory.createPair(address(mcdonalds),address(amazon));
        factory.createPair(address(amazon),address(sephora));
        factory.createPair(address(sephora),address(walgreens));
        factory.createPair(address(walgreens),address(lyft));
        factory.createPair(address(lyft),address(deltamiles));





        console.log("delta miles deployed at:",address(deltamiles));
        console.log("delta miles balance:",deltamiles.balanceOf(msg.sender));
        console.log("slMinterOracle deployed at:",address(slminteroracle));
        vm.stopBroadcast();
    }
}
