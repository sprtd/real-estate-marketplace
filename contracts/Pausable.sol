// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;
import './Ownable.sol';

contract Pausable is Ownable {
  
  /********************************************************************************************/
  /*                                      STATE VARIABLES                           */
  /******************************************************************************************/
  bool private _paused;
  address contractOwner;

  /********************************************************************************************/
  /*                                      EVENT                                              */
  /******************************************************************************************/
  event LogPaused(address owner, bool status);
  event LogUnpaused(address owner, bool status);
  function whenNotPaused() public view {
    require(!_paused, 'must not be paused');
  }

  function paused() public view {
    require(_paused, 'must be paused');
  }

  modifier checkPaused() {
    paused();
    _;
  }

  modifier checkNotPaused() {
    whenNotPaused();
    _;
  }


  constructor() {
    contractOwner = msg.sender;
    

  } 


  /********************************************************************************************/
  /*                                     CORE FUNCTIONS                                      */
  /******************************************************************************************/
  function pauseContract() public checkOnlyOwner {
    require(_paused == false, 'not in paused state');
    _paused = true;
    emit LogPaused(msg.sender, _paused);
  }

  function unpauseContract() public checkOnlyOwner {
    require(_paused == true, 'not in unpaused state');
    _paused = false;
    emit LogUnpaused(msg.sender, _paused);
  }


  /********************************************************************************************/
  /*                                      UTILITY FUNCTIONS                                  */
  /******************************************************************************************/


   







}
