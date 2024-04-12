// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {SLMinterOracle} from "../src/SLMinterOracle.sol";
import {IUniRouter} from "../src/interfaces/IUniRouter.sol";
import {SLERC20} from "../src/SLERC20.sol";
import {IUniswapFactory} from "../src/interfaces/IUniFactory.sol";

contract SLScript is Script {
    IUniRouter uniRouter;
    IUniswapFactory factory;
    address mainAddress;
    SLMinterOracle slminteroracle;
    uint mintAmt = 10000000;
    SLERC20[] tokens;
    uint[10] liqAmounts = [
        52000,
        2440,
        2300,
        744,
        3078,
        2667,
        2280,
        2500,
        3080,
        2500
    ];

    function setUp() public {
        uniRouter = IUniRouter(0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008);
        factory = IUniswapFactory(uniRouter.factory());
        mainAddress = 0xAe443A7dbB2252Ee2AF1b4c9eEE755a1b2417ab4;
        slminteroracle = new SLMinterOracle(uniRouter);
    }

    function createPairs() public {
        for (uint i = 0; i < tokens.length; i++) {
            uint tokenA = i;
            uint tokenB = i + 1;
            if (i == tokens.length - 1) {
                tokenB = 0;
            }
            address pair = factory.createPair(
                address(tokens[tokenA]),
                address(tokens[tokenB])
            );
            console.log("pair created for", tokens[tokenA].name());
            console.log(tokens[tokenB].name());
            console.log("address for pair", pair);
        }
    }

    function addLiquidities() public {
        for (uint i = 0; i < tokens.length; i++) {
            uint tokenA = i;
            uint tokenB = i + 1;
            if (i == tokens.length - 1) {
                tokenB = 0;
            }
            uniRouter.addLiquidity(
                address(tokens[tokenA]),
                address(tokens[tokenB]),
                (liqAmounts[tokenA] / 2) * 10 ** 18, //divide by 2
                (liqAmounts[tokenB] / 2) * 10 ** 18,
                0,
                0,
                mainAddress,
                1812835479
            );
        }
    }

    function approveAll() public {
        for (uint i = 0; i < tokens.length; i++) {
            console.log("approving token", address(tokens[i]));
            tokens[i].approve(address(uniRouter), liqAmounts[i] * 10 ** 18);
        }
    }

    function logTokenDeployments() public {
        for (uint i = 0; i < tokens.length; i++) {
            console.log("token:", tokens[i].name());
            console.log("deployed at:", address(tokens[i]));
            console.log(
                "card deployed at:",
                address(slminteroracle.returnCard(address(tokens[i])))
            );
        }
    }

    function getChainId() public view returns (uint256) {
        uint256 chainId;
        assembly {
            chainId := chainid()
        }
        return chainId;
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Deployer address: ", deployerAddress);
        console.log("Deployer balance: ", deployerAddress.balance);
        console.log("BlockNumber: ", block.number);
        console.log("ChainId: ", getChainId());
        console.log("Deploying");

        vm.startBroadcast(deployerPrivateKey);

        console.log("slMinterOracle deployed at:", address(slminteroracle));

        tokens.push(
            slminteroracle.createBrand(
                "Delta",
                "Miles",
                liqAmounts[0] + 2000,
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Starbucks",
                "Points",
                liqAmounts[1] + 36,
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Walmart",
                "Points",
                liqAmounts[2],
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Shell",
                "Gallons",
                liqAmounts[3],
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Regal Cinema",
                "Points",
                liqAmounts[4],
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "McDonalds",
                "Points",
                liqAmounts[5],
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Amazon",
                "Points",
                liqAmounts[6],
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Sephora",
                "Points",
                liqAmounts[7],
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Walgreens",
                "Points",
                liqAmounts[8],
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Lyft",
                "Points",
                liqAmounts[9],
                mainAddress
            )
        );

        logTokenDeployments();
        createPairs();
        approveAll();
        addLiquidities();

        vm.stopBroadcast();
    }
}
