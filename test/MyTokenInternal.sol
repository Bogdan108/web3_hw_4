pragma solidity ^0.8.0;

import "../src/MyToken.sol";
import {CryticERC20BasicProperties} from "lib/properties/contracts/ERC20/internal/properties/ERC20BasicProperties.sol";
import {CryticERC20BurnableProperties} from "lib/properties/contracts/ERC20/internal/properties/ERC20BurnableProperties.sol";
import {CryticERC20MintableProperties} from "lib/properties/contracts/ERC20/internal/properties/ERC20MintableProperties.sol";

contract CryticERC20InternalHarness is
    MyToken,
    CryticERC20BasicProperties,
    CryticERC20BurnableProperties,
    CryticERC20MintableProperties
{
    constructor() {
        _mint(USER1, INITIAL_BALANCE);
        _mint(USER2, INITIAL_BALANCE);
        _mint(USER3, INITIAL_BALANCE);

        initialSupply = totalSupply();
        isMintableOrBurnable = true;
    }

    function mint(
        address to,
        uint256 amount
    ) public virtual override(MyToken, CryticERC20MintableProperties) {
        super.mint(to, amount);
    }

    // override функцию, чтобы сломать свойство burnable
    function burnFrom(
        address account,
        uint256 value
    ) public virtual override(MyToken, ERC20Burnable) {
        super.burnFrom(account, value);
    }
}
