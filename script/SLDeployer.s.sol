// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {SLMinterOracle} from "../src/SLMinterOracle.sol";
import {IUniRouter} from "../src/interfaces/IUniRouter.sol";
import {SLERC20} from "../src/SLERC20.sol";
import {IUniswapFactory} from "../src/interfaces/IUniFactory.sol";

contract SLScript is Script {
    IUniRouter uniRouter;
    IUniswapFactory factory;
    address mainAddress;
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
        factory = IUniswapFactory(0x7E0987E5b3a30e3f2828572Bb659A548460a3003);
        mainAddress = 0xB54271D82813D21F8508FFffc005EdeDf72E1Bf9;
    }

    function createPairs() public {
        for (uint i = 0; i < tokens.length; i++) {
            uint tokenA = i;
            uint tokenB = i + 1;
            if (i == tokens.length -1) {
                tokenB = 0;
            }
            address pair = factory.createPair(address(tokens[tokenA]),address(tokens[tokenB]));
            console.log("pair created for",tokens[tokenA].name());
            console.log(tokens[tokenB].name());
            console.log("address for pair",pair);
        }
    }

    function addLiquidities() public {}

    function approveAll() public {
        for (uint i = 0; i < tokens.length; i++) {
            tokens[i].approve(address(uniRouter), liqAmounts[i] * 10 ** 18);
        }
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        SLMinterOracle slminteroracle = new SLMinterOracle(uniRouter);

        tokens.push(
            slminteroracle.createBrand(
                "Delta Miles",
                "MILES",
                mintAmt,
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Starbucks Points",
                "POINTS",
                mintAmt,
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Walmart Points",
                "POINTS",
                mintAmt,
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Shell Gallons",
                "GALLONS",
                mintAmt,
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Regal Cinema Points",
                "POINTS",
                mintAmt,
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "McDonalds Points",
                "POINTS",
                mintAmt,
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Amazon Points",
                "POINTS",
                mintAmt,
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Sephora Points",
                "POINTS",
                mintAmt,
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Walgreen Points",
                "POINTS",
                100000,
                mainAddress
            )
        );
        tokens.push(
            slminteroracle.createBrand(
                "Lyft Points",
                "POINTS",
                mintAmt,
                mainAddress
            )
        );
        /*      address pairone = factory.createPair(
            address(deltamiles),
            address(starbucks)
        );
        address pairtwo = factory.createPair(
            address(starbucks),
            address(walmart)
        ); */
        //address pairthree = factory.createPair(address(walmart), address(shell));
        /*  
        address pairfour = factory.createPair(address(shell),address(regal));
        address pairfive = factory.createPair(address(regal),address(mcdonalds));
        address pairsix = factory.createPair(address(mcdonalds),address(amazon));
        address pairseven = factory.createPair(address(amazon),address(sephora));
        address paireight = factory.createPair(address(sephora),address(walgreens));
        address pairnine = factory.createPair(address(walgreens),address(lyft));
        address pairten = factory.createPair(address(lyft),address(deltamiles));*/
        /*     tokens[0].approve(address(uniRouter), 52000 * 10 ** 18);
        tokens[1].approve(address(uniRouter), 2440 * 10 ** 18);
        tokens[2].approve(address(uniRouter), 2300 * 10 ** 18); */
        createPairs();
        approveAll();
        //shell.approve(address(uniRouter), 744 * 10 ** 18);
        /*     uniRouter.addLiquidity(
            address(deltamiles),
            address(starbucks),
            21000 * 10 ** 18,
            1220 * 10 ** 18,
            0,
            0,
            mainAddress,
            1812835479
        );
        uniRouter.addLiquidity(
            address(starbucks),
            address(walmart),
            1220 * 10 ** 18,
            1150 * 10 ** 18,
            0,
            0,
            mainAddress,
            1812835479
        ); */
        //uniRouter.addLiquidity(address(deltamiles), address(starbucks), 26000 * 10 ** 18, 1220 * 10 ** 18, 0, 0, msg.sender, 1812835479);
        //uniRouter.addLiquidity(address(deltamiles), address(starbucks),100,100, 1, 1, msg.sender, 1912835479);
        //uniRouter.addLiquidity(address(starbucks), address(walmart), 1220, 1150, 0, 0, msg.sender, 1812835479);
        /*    uniRouter.addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, to, deadline);
        uniRouter.addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, to, deadline);
        uniRouter.addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, to, deadline);
        uniRouter.addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, to, deadline);
        uniRouter.addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, to, deadline);
        uniRouter.addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, to, deadline);
        uniRouter.addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, to, deadline);
        uniRouter.addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, to, deadline);  */

        console.log("delta miles deployed at:", address(tokens[0]));
        console.log("starbucks deployed at:", address(tokens[1]));
        console.log("walmart deployed at:", address(tokens[2]));
        //console.log("shell deployed at:", address(shell));

        console.log(
            "delta miles card deployed at:",
            address(slminteroracle.returnCard(address(tokens[0])))
        );
        /*   console.log(
            "starbucks card deployed at:",
            address(slminteroracle.returnCard(address(starbucks)))
        );
        console.log(
            "walmart card deployed at:",
            address(slminteroracle.returnCard(address(walmart)))
        );
        console.log(
            "shell card deployed at:",
            address(slminteroracle.returnCard(address(shell)))
        ); */
        /*     console.log(
            "pairone deployed at:",
            pairone
        ); */
        /*  console.log(
            "pairtwo deployed at:",
            pairtwo
        ); */
        console.log("slMinterOracle deployed at:", address(slminteroracle));
        vm.stopBroadcast();
    }
}
