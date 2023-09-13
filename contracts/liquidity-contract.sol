// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// import {IMEME} from "./iPool.sol";
// import {ISUB} from "./iPool.sol";

contract LiquidityPool {

    uint public totalReserveA;
    uint public totalReserveB;
    uint public totalReserve;
    
    IERC20 mem;
    IERC20 sub;

    constructor(address _mem, address _sub){
        mem = IERC20(_mem);
        sub = IERC20(_sub);
    }

    struct LiquidityProvider {
        uint amountA;
        uint amountB;
    }

    LiquidityProvider provider;

    mapping(address => LiquidityProvider) public liquidityProvider;

    function addLiquidity(uint256 _amountA, uint256 _amountB) external {
        mem.transferFrom(msg.sender, address(this), _amountA);
        sub.transferFrom(msg.sender, address(this), _amountB);
        totalReserveA+= _amountA;
        totalReserveB+= _amountB;
        totalReserve = totalReserveA * totalReserveB;
        LiquidityProvider storage _provider = liquidityProvider[msg.sender];
        _provider.amountA += _amountA;
        _provider.amountB += _amountB;
    }

    function removeLiquidity(uint256 _amountA, uint256 _amountB) external {
        require(provider.amountA > _amountA && provider.amountB > _amountB, "Insufficient Balance");
        mem.transfer(msg.sender, _amountA);
        sub.transfer(msg.sender, _amountB);
        totalReserveA-= _amountA;
        totalReserveB-= _amountB;
        totalReserve = totalReserveA * totalReserveB;
        LiquidityProvider storage _provider = liquidityProvider[msg.sender];
        _provider.amountA -= _amountA;
        _provider.amountB -= _amountB;
    }

    function swapTokenA(address to, uint256 amount) external{
        _safeSwapA( to, amount);
    }

    function swapTokenB(address to, uint256 amount) external {
        _safeSwapB( to, amount);
    }

    function _safeSwapA( address to, uint amount) internal returns(bool sent) {
        mem.transferFrom(msg.sender, address(this), amount);
        totalReserveA += amount;
        sub.transfer(to, totalReserveB - (totalReserve / totalReserveA + amount));
        totalReserveB -= amount;
        sent = true;
        require(sent, "Failed transaction");
    }

    function _safeSwapB( address to, uint amount) internal returns(bool sent) {
        mem.transferFrom(msg.sender, address(this), amount);
        totalReserveB += amount;
        sub.transfer(to, totalReserveB - (totalReserve / totalReserveA + amount));
        totalReserveA -= amount;
        sent = true;
        require(sent, "Failed transaction");
    }


}