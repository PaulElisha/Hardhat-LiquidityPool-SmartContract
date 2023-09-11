// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SUBI is ERC20 {
    constructor() ERC20('SUBI', 'SBI'){
        _mint(msg.sender, 1000e18);
    }
}