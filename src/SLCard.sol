// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;
import "./SLERC20.sol";


contract SLCard {
    SLERC20 token;
    constructor(address _token) {
        token = SLERC20(_token);
    }
    function transferRewards(address receiver){
        uint contractBalance = token.balanceOf(address(this)); 
        token.transfer(receiver, contractBalance);
    }
}

