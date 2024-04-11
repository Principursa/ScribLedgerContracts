// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "solmate/tokens/ERC20.sol";
import "solmate/auth/Auth.sol"; //@NOTE: implement auth, probably only need 1, owner/minter
import "./interfaces/IUniRouter.sol";
import "./SLERC20.sol";
import "./SLRouter.sol";
import "./SLCard.sol";


contract SLMinterOracle{
    SLRouter slRouter;
    IUniRouter uniRouter;


    mapping (address=>SLERC20) addressToBrands; //need better way to go between brands
    mapping (string => SLERC20) stringToBrands;
    mapping(address => SLCard) brandsToCards;

    constructor(IUniRouter routerAddress){
        uniRouter = routerAddress;
    }
    function setSLRouter(address router) external {
        slRouter = SLRouter(router);
    } 
    function returnCard (address brand) external returns(SLCard card){
        return brandsToCards[brand];

    }

    function createBrand(string memory name,string memory symbol, uint mintAmt, address receiver) public returns(SLERC20 brand){
        SLERC20 brand = new SLERC20(name,symbol);
        address  brandAddress = address(brand);
        addressToBrands[brandAddress] = brand;
        stringToBrands[name] = brand;
        brand.mint(receiver,mintAmt);
        SLCard newCard = new SLCard(address(brand),address(this));
        brandsToCards[address(brand)] = newCard;
        return brand;
    }
    function mintBrand(SLERC20 brand, uint mintAmt, address receiver) public{
        brand.mint(receiver,mintAmt);
    }
    function transferBrand(SLERC20 brand,uint transferAmt, address receiver) public {
        brand.transfer(receiver,transferAmt);
    }
    function transferToCard(SLERC20 brand, uint transferAmt, SLCard card) public {
        brand.transfer(address(card), transferAmt);
    }

    function FeTestCall() public {
        //don't implement now
    }


}