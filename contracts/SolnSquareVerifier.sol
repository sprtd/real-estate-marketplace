// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;
import '@openzeppelin/contracts/utils/Counters.sol';
import './RealEstateToken.sol';
import './Verifier.sol';




contract SolnSquareVerifier is RealEstateToken {
  Verifier verifier;
  using Counters for Counters.Counter;
  

  constructor(address _squareVerifierAddress) {
    verifier = Verifier(_squareVerifierAddress);
    
  }


  struct Solution {
    uint256 index;
    address account;
  }

  

  Counters.Counter private solutionsCounter;

  

  mapping(bytes32 => Solution) solutions;
  // mapping(uint256 => bytes32) private _submittedSolutions;

  event LogSolutionAdded(uint256 indexed tokenID, address indexed account);

  function addSolution(uint[2] memory _a, uint[2][2] memory _b, uint[2] memory _c, uint[2] memory _inputs, uint256 _index, address _account) public {
    require(verifier.verifyTx( _a, _b, _c, _inputs));

  }

  function getSolutionKey(uint[2] memory _a, uint[2][2] memory _b, uint[2] memory _c, uint[2] memory _inputs) public pure returns(bytes32) {
    bytes32 solutionKey = keccak256(abi.encode(_a, _b, _c, _inputs));
    return solutionKey;
    
  }






}

