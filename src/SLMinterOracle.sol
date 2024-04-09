// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "solmate/tokens/ERC20.sol";
import "solmate/auth/Auth.sol"; //@NOTE: implement auth, probably only need 1, owner/minter
import "./interfaces/IUniRouter.sol";
import "./SLERC20.sol";
import "./SLRouter.sol";


contract SLMinterOracle{
    SLRouter slRouter;

    IUniswapRouter uniRouter;

    mapping (address=>SLERC20) brands;

    constructor(IUniswapRouter routerAddress){
        uniRouter = routerAddress;
    }
    function changeSlRouter(address router) external {
        slRouter = SLRouter(router);
    } 

    function createBrand(string memory name,string memory symbol, uint mintAmt) public{
        SLERC20 brand = new SLERC20(name,symbol);
        address  brandAddress = address(brand);
        brands[brandAddress] = brand;
        brand.mint(msg.sender,mintAmt);

    }
    function mintBrand(address brand, uint mintAmt) public{

    }
    function createMarket(address assetOne, address assetTwo, uint amtOne, uint amtTwo) public{

    }
    function ProvLiquidity(address assetOne, address assetTwo, uint amtOne, uint amtTwo) public {


    }
    function FeTestCall() public{
        //don't implement now
    }


}