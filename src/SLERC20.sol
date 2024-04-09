// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "solmate/tokens/ERC20.sol";
 

contract SLERC20 is ERC20{

    constructor(string memory name, string memory symbol) ERC20(name,symbol,18){
    }
    function mint(address receiver,uint256 mintAmt) public{
        _mint(receiver, mintAmt * 10 ** decimals);
    }

}

