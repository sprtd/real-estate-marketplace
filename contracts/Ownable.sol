// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Ownable {


  address private _owner;
  event LogOwnershipTransferred(address indexed oldOwner, address indexed newOwner);


  function onlyOwner() public view {
    require(msg.sender == _owner, 'ONL OWN');
  }

  modifier checkOnlyOwner() {
    onlyOwner();
    _;
  }

  constructor() {
    _owner = msg.sender;
  }

  function getOwner() public view returns(address) {
    return _owner;
  }

  function transferOwnership(address _account) public checkOnlyOwner {
    _account = _owner;
    emit LogOwnershipTransferred(msg.sender, _owner);
  }

}