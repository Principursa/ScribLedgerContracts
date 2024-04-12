// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
 

contract SLERC20 is ERC20{
    uint seed = 10;

    constructor(string memory name, string memory symbol) ERC20(name,symbol){
    }
    function mint(address receiver,uint256 mintAmt) public{
        _mint(receiver, mintAmt * 10 ** 18);
    }

}

