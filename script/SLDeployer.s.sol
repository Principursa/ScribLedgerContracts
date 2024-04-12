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
        uniRouter = IUniRouter(0x444519c512Ec3528e8c3D8D44FF9A5e5e867Ae2d);
        factory = IUniswapFactory(uniRouter.factory());
        mainAddress = 0xB54271D82813D21F8508FFffc005EdeDf72E1Bf9;
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
            uint tokenB = i +1;
            if (i == tokens.length - 1){
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
            console.log("approving token",address(tokens[i]));
            tokens[i].approve(address(uniRouter), liqAmounts[i] * 10 ** 18);
        }
    }
    function logTokenDeployments() public {
        for (uint i = 0; i < tokens.length; i++){
            console.log("token:",tokens[i].name());
            console.log("deployed at:",address(tokens[i]));
            console.log("card deployed at:",address(slminteroracle.returnCard(address(tokens[i]))));
        }

    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

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
    
        console.log("slMinterOracle deployed at:", address(slminteroracle));
        vm.stopBroadcast();
    }
}
