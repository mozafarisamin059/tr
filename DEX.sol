// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DEX {
    mapping(address => mapping(address => uint256)) public balances;

    event Trade(address indexed fromToken, address indexed toToken, address indexed trader, uint256 amount);

    function trade(address _fromToken, address _toToken, uint256 _amount) public {
        require(balances[_fromToken][msg.sender] >= _amount, "Insufficient balance");
        require(IERC20(_toToken).transfer(msg.sender, _amount), "Transfer failed");
        balances[_fromToken][msg.sender] -= _amount;
        balances[_toToken][msg.sender] += _amount;
        emit Trade(_fromToken, _toToken, msg.sender, _amount);
    }
}
