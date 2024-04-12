// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;
import "./SLERC20.sol";
import "./SLMinterOracle.sol";


contract SLCard {
    SLERC20 token;
    SLMinterOracle minterOracle;
    uint mintamt = 50 * 10 ** 18;
    constructor(address _token, address _minterOracle) {
        token = SLERC20(_token);
        minterOracle = SLMinterOracle(_minterOracle);
    }
    function transferRewards(address receiver) public{
        uint contractBalance = token.balanceOf(address(this)); 
        token.transfer(receiver, contractBalance);
    }
    function transferToCard() public {
        minterOracle.mintBrand(token, mintamt, address(this));
    }
}

