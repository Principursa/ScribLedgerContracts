// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "solmate/tokens/ERC20.sol";
import "solmate/auth/Auth.sol"; //@NOTE: implement auth, probably only need 1, owner/minter
import "./interfaces/IUniRouter.sol";
import "./SLERC20.sol";
import "./SLRouter.sol";


contract SLMinterOracle{
    SLRouter slRouter;
    IUniRouter uniRouter;

    mapping (address=>SLERC20) addressToBrands; //need better way to go between brands
    mapping (string => SLERC20) stringToBrands;

    constructor(IUniRouter routerAddress){
        uniRouter = routerAddress;
    }
    function setSLRouter(address router) external {
        slRouter = SLRouter(router);
    } 

    function createBrand(string memory name,string memory symbol, uint mintAmt, address receiver) public returns(SLERC20 brand){
        SLERC20 brand = new SLERC20(name,symbol);
        address  brandAddress = address(brand);
        addressToBrands[brandAddress] = brand;
        stringToBrands[name] = brand;
        brand.mint(receiver,mintAmt);
        return brand;
    }
    function mintBrand(SLERC20 brand, uint mintAmt, address receiver) public{
        brand.mint(receiver,mintAmt);
    }
    function createMarket(address assetOne, address assetTwo, uint amtOne, uint amtTwo) public{
        slRouter.createMarket(assetOne,assetTwo);

    }
    function addLiqudity(address assetOne, address assetTwo, uint amtOne, uint amtTwo) public {
        slRouter.addLiquidity();


    }
    function FeTestCall() public{
        //don't implement now
    }


}