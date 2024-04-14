// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

abstract contract ERC20Mintable is ERC20 {
  uint8 public _decimals;

  constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

  function mint(address account, uint256 amount) external {
    super._mint(account, amount);
  }
}