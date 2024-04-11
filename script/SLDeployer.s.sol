// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {SLMinterOracle} from "../src/SLMinterOracle.sol";
import {IUniRouter} from "../src/interfaces/IUniRouter.sol";
import {SLERC20} from "../src/SLERC20.sol";

contract SLScript is Script{
    IUniRouter uniswapRouterAddress;
    function setUp() public {
        uniswapRouterAddress = IUniRouter(0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008);
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        SLMinterOracle slminteroracle = new SLMinterOracle(uniswapRouterAddress);
        SLERC20 deltamiles = slminteroracle.createBrand("Delta Miles", "MILES", 52000, msg.sender);
        SLERC20 starbucks = slminteroracle.createBrand("Starbucks Points", "POINTS", 2439, msg.sender);
        SLERC20 walmart = slminteroracle.createBrand("Walmart Points", "POINTS", 2299, msg.sender);
        SLERC20 shell = slminteroracle.createBrand("Shell Gallons", "GALLONS", 744, msg.sender);
        SLERC20 regal = slminteroracle.createBrand("Regal Cinema Points", "POINTS", 3077, msg.sender);
        SLERC20 mcdonalds = slminteroracle.createBrand("McDonalds Points", "POINTS", 2667, msg.sender);
        SLERC20 amazon = slminteroracle.createBrand("Amazon Points", "POINTS", 2273, msg.sender);
        SLERC20 sephora = slminteroracle.createBrand("Sephora Points", "POINTS", 2500, msg.sender);
        SLERC20 walgreens = slminteroracle.createBrand("Walgreen Points", "POINTS", 3077, msg.sender);
        SLERC20 lyft = slminteroracle.createBrand("Lyft Points", "POINTS", 2469, msg.sender);


        console.log("delta miles deployed at:",address(deltamiles));
        console.log("delta miles balance:",deltamiles.balanceOf(msg.sender));
        console.log("slMinterOracle deployed at:",address(slminteroracle));
        vm.stopBroadcast();
    }
}
