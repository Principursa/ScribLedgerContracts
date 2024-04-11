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
    //SLERC20[] tokens;

    function setUp() public {
        uniRouter = IUniRouter(0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008);
        factory = IUniswapFactory(0x7E0987E5b3a30e3f2828572Bb659A548460a3003);
        mainAddress = 0xB54271D82813D21F8508FFffc005EdeDf72E1Bf9;
    }

    function createPairs() public {

    }
    function addLiquidities() public {

    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        SLMinterOracle slminteroracle = new SLMinterOracle(uniRouter);
        SLERC20 deltamiles = slminteroracle.createBrand(
            "Delta Miles",
            "MILES",
            100000,
            mainAddress
        );
        SLERC20 starbucks = slminteroracle.createBrand(
            "Starbucks Points",
            "POINTS",
            100000,
            mainAddress
        );
        SLERC20 walmart = slminteroracle.createBrand(
            "Walmart Points",
            "POINTS",
            100000,
            mainAddress
        );
   /*      SLERC20 shell = slminteroracle.createBrand(
            "Shell Gallons",
            "GALLONS",
            100000,
            mainAddress
        );
        SLERC20 regal = slminteroracle.createBrand(
            "Regal Cinema Points",
            "POINTS",
            100000,
            mainAddress
        );
        SLERC20 mcdonalds = slminteroracle.createBrand(
            "McDonalds Points",
            "POINTS",
            100000,
            mainAddress
        );
        SLERC20 amazon = slminteroracle.createBrand(
            "Amazon Points",
            "POINTS",
            100000,
            mainAddress
        );
        SLERC20 sephora = slminteroracle.createBrand(
            "Sephora Points",
            "POINTS",
            100000,
            mainAddress
        );
        SLERC20 walgreens = slminteroracle.createBrand(
            "Walgreen Points",
            "POINTS",
            100000,
            mainAddress
        );
        SLERC20 lyft = slminteroracle.createBrand(
            "Lyft Points",
            "POINTS",
            100000,
            mainAddress
        ); */
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
        deltamiles.approve(address(uniRouter), 52000 * 10 ** 18);
        starbucks.approve(address(uniRouter), 2440 * 10 ** 18);
        walmart.approve(address(uniRouter), 2300 * 10 ** 18);
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

        console.log("delta miles deployed at:", address(deltamiles));
        console.log("starbucks deployed at:", address(starbucks));
        console.log("walmart deployed at:", address(walmart));
        //console.log("shell deployed at:", address(shell));

        console.log(
            "delta miles card deployed at:",
            address(slminteroracle.returnCard(address(deltamiles)))
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
