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

  enum Status { Unassgined, Verified, Minted}

  struct Solution {
    uint256 index;
    address minter;
    Status status;
    bytes32 mintHash;
  }

  

  Counters.Counter private solutionsCounter;

  mapping(bytes32 => Solution) solutions;
  mapping(uint256 => bytes32) public tokenIdToKey;
  

  event LogSolutionAdded(uint256 indexed index, address indexed minter, uint256 status);
  event LogMintStatus(uint256 indexed index, address indexed minter, bytes32 indexed mintHash, uint256 status);

  function addSolution(uint[2] memory _a, uint[2][2] memory _b, uint[2] memory _c, uint[2] memory _inputs) public isOwner {
    require(verifier.verifyTx( _a, _b, _c, _inputs), 'invalid verification');
    bytes32 mintKey = getMintKey(msg.sender);

    require(solutions[mintKey].minter == address(0), 'already minted');
    require(solutions[mintKey].status == Status.Unassgined, 'not in unassgined state');
    uint256 tokenId = solutionsCounter.current();
    solutionsCounter.increment();

    solutions[mintKey] = Solution({
      index: tokenId,
      minter: msg.sender,
      status: Status.Verified, 
      mintHash: mintKey
    });
  
    tokenIdToKey[tokenId] = mintKey;

    emit LogSolutionAdded(tokenId, msg.sender, uint256(solutions[mintKey].status));
  }


  function mintNFT(uint[2] memory _a, uint[2][2] memory _b, uint[2] memory _c, uint[2] memory _inputs) public {
    addSolution(_a, _b, _c, _inputs);
    bytes32 key = getMintKey(msg.sender);
    require(solutions[key].status == Status.Verified, 'not in verified state');
    solutions[key].status = Status.Minted;
    uint256 tokenId = solutions[key].index;
    mint();
    emit LogMintStatus(tokenId, msg.sender, key, uint256(solutions[key].status));
    // emit LogMintStatus(tokenId, msg.sender, uint256(solutions[mintKey].status));
  }


  function getMintKey(address _account) private view returns(bytes32) {
    uint256 index = getTotalSupply();
    bytes32 mintKey = keccak256(abi.encode(index, _account));
    return mintKey;
  }



  function getSolutionDetails(uint256 _tokenId) public view returns(uint256 index, address minter, string memory status) {
    bytes32 key = tokenIdToKey[_tokenId];
    require(_tokenId == solutions[key].index, 'non-existent soln');

    uint256 state = uint256(solutions[key].status);
    if(state == 0) {
      status =  'Unassigned';
    
    } else if(state == 1) {
      status = 'Verified';
    } else if(state == 2) {
      status = 'Minted';
    }

    index = solutions[key].index;
    minter = solutions[key].minter;

   

  }



}

