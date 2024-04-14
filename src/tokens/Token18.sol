// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20Mintable} from "./ERC20Mintable.sol";

contract Token6 is ERC20Mintable {
  constructor(string memory _name, string memory _symbol) ERC20Mintable(_name, _symbol) {
    _decimals = 18;
  }
}