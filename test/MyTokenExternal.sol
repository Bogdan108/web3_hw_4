// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.0;

import "../src/MyToken.sol";
import {ITokenMock} from "properties/contracts/ERC721/external/util/ITokenMock.sol";
import {CryticERC721ExternalBasicProperties} from "properties/contracts/ERC721/external/properties/ERC721ExternalBasicProperties.sol";
import {PropertiesConstants} from "properties/contracts/util/PropertiesConstants.sol";

contract MyTokenERC721ExternalHarness is MyTokenERC721ExternalBasicProperties {
    constructor() {
        // Deploy ERC721
        token = ITokenMock(address(new MyTokenTokenMock()));
    }
}

contract MyTokenTokenMock is MyToken, PropertiesConstants {
    bool public isMintableOrBurnable;

    constructor() {
        isMintableOrBurnable = true;
        _mint(USER1, INITIAL_BALANCE);
        _mint(USER2, INITIAL_BALANCE);
        _mint(USER3, INITIAL_BALANCE);
        _mint(msg.sender, INITIAL_BALANCE);
        initialSupply = totalSupply();
    }
}
