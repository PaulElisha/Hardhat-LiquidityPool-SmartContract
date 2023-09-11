// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

interface ILiquidity {
    function addLiquidity(uint256 _amountA, uint256 _amountB) external;
    function swapTokenA(address to, uint256 amount) external;
    function swapTokenB(address to, uint256 amount) external;
    function approve(address to, uint256 amount) external;
}