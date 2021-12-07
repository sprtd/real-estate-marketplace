// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

import './MyERC721Metadata.sol';

// Create CustomERC721Token contract that inherits from the ERC721Metadata contract. You can name this contract as you please.
// 1) Pass in appropriate values for the inherited ERC721Metadata contract
//     - make the base token uri: https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/
// 2) create a public mint() that does the following:
//     -can only be executed by the contract owner
//     -takes in a 'to' address, tokenId, and tokenURI as parameters
//     -returns a true boolean upon completion of the function
//     -calls the superclass mint and setTokenURI functions
contract RealEstateToken is 
MyERC721Metadata('RealEstateToken', 'RET', 'https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/') {

  event LogTokenMinted(address indexed sender, uint256 tokenId);
  modifier isOwner()  {
    onlyOwner();
    _;
  }
   
  function mint() public isOwner returns(bool) {
    uint256 tokenId = getTotalSupply();
    mintToken();
    emit LogTokenMinted(msg.sender, tokenId);
    super._setTokenURI(tokenId);
    return true;
  }

}
   