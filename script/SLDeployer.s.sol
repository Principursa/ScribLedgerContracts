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
        SLERC20 brandone = slminteroracle.createBrand("DELTA MILES", "DLT MLS", 1000, msg.sender);
        console.log("delta miles deployed at:",address(brandone));
        console.log("delta miles balance:",brandone.balanceOf(msg.sender));
        console.log("slMinterOracle deployed at:",address(slminteroracle));
        vm.stopBroadcast();
    }
}
