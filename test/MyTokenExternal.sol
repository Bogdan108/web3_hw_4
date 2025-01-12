// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.0;

import "../src/MyToken.sol";
import {ITokenMock} from "lib/properties/contracts/ERC20/external/util/ITokenMock.sol";
import {CryticERC20ExternalBasicProperties} from "lib/properties/contracts/ERC20/external/properties/ERC20ExternalBasicProperties.sol";
import {CryticERC20ExternalBurnableProperties} from "lib/properties/contracts/ERC20/external/properties/ERC20ExternalBurnableProperties.sol";
import {CryticERC20ExternalMintableProperties} from "lib/properties/contracts/ERC20/external/properties/ERC20ExternalMintableProperties.sol";
import {PropertiesConstants} from "lib/properties/contracts/util/PropertiesConstants.sol";

contract MyTokenERC20ExternalHarness is
    CryticERC20ExternalBasicProperties,
    CryticERC20ExternalBurnableProperties,
    CryticERC20ExternalMintableProperties
{
    constructor() {
        token = ITokenMock(address(new MyTokenMock(true)));
    }
}
contract MyTokenMock is MyToken, PropertiesConstants {
    bool public isMintableOrBurnable;
    uint256 public initialSupply;

    constructor(bool _isMintableOrBurnable) {
        _mint(USER1, INITIAL_BALANCE);
        _mint(USER2, INITIAL_BALANCE);
        _mint(USER3, INITIAL_BALANCE);
        _mint(msg.sender, INITIAL_BALANCE);

        initialSupply = totalSupply();
        isMintableOrBurnable = _isMintableOrBurnable;
    }
}
