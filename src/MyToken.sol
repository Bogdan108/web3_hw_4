// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, ERC20Burnable {
    constructor() ERC20("MyToken", "MTK") {}

    // задаем неправильное кол-во создаваемых токенов
    function mint(address to, uint256 amount) public virtual {
        _mint(to, amount + 7);
    }

    // override функцию, чтобы сломать свойство burnable
    function burnFrom(
        address account,
        uint256 value
    ) public virtual override(ERC20Burnable) {
        // Не уменьшаем allowance
        _burn(account, value);
    }

    // override функцию, чтобы сломать перевод при address(0)
    function transfer(
        address to,
        uint256 value
    ) public virtual override(ERC20) returns (bool) {
        address owner = _msgSender();
        if (to == address(0)) {
            to = address(1);
        }

        _transfer(owner, to, value);

        return true;
    }
}
