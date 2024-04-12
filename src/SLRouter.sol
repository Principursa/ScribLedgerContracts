// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "solmate/tokens/ERC20.sol";
import "./interfaces/IUniRouter.sol";
import "./interfaces/IUniFactory.sol";
 
contract SLRouter {
    IUniswapFactory factory;
    IUniRouter router;
    constructor(address _factory, address _router){
        factory = IUniswapFactory(_factory);
        router = IUniRouter(_router);
    }
    mapping (address=>mapping (address=>address)) public markets;
    function getPrice(address brand) external{

    }

}

