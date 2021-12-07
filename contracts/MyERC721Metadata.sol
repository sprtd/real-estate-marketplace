// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

import './MyERC721Enumerable.sol';



contract MyERC721Metadata is MyERC721Enumerable {

  string private _tokenName;
  string private _tokenSymbol;
  string private _baseTokenURI;

  // map tokenid to token uri 
  mapping(uint256 => string) private _tokenURIs;

  bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f; 


  /*
  * 0x5b5e139f ===
  *  bytes4(keccak256('name()')) ^
  *  bytes4(keccak256('symbol()')) ^
  *  bytes4(keccak256('tokenURI(uint256)'))
  */

  constructor(string memory _name, string memory _symbol, string memory _cBaseTokenURI) MyERC721Enumerable(_name, _symbol) {
    _tokenName = _name;
    _tokenSymbol = _symbol;
    _baseTokenURI = _cBaseTokenURI;

    _registerInterface(_INTERFACE_ID_ERC721_METADATA);

  }


    // TODO: Create an internal function to set the tokenURI of a specified tokenId
    // It should be the _baseTokenURI + the tokenId in string form
    // TIP #1: use strConcat() from the imported oraclizeAPI lib to set the complete token URI
    // TIP #2: you can also use uint2str() to convert a uint to a string
        // see https://github.com/oraclize/ethereum-api/blob/master/oraclizeAPI_0.5.sol for strConcat()
    // require the token exists before setting

  function strConcat(string memory _a, string memory _b) public pure returns (string memory _concatenatedString) {
    bytes memory _ba = bytes(_a);
    bytes memory _bb = bytes(_b);
    
    string memory ab = new string(_ba.length + _bb.length);
    bytes memory bab = bytes(ab);
    uint k = 0;
    uint i = 0;
    for (i = 0; i < _ba.length; i++) {
        bab[k++] = _ba[i];
    }
    for (i = 0; i < _bb.length; i++) {
        bab[k++] = _bb[i];
    }
      return string(bab);
  }

    function _setTokenURI(uint256 _tokenId) internal  {
      require(_exists(_tokenId));
      _tokenURIs[_tokenId] = strConcat(_baseTokenURI, Strings.toString(_tokenId));

    }


  /********************************************************************************************/
	/*                                      UTILITY FUNCITONS                                  */
	/******************************************************************************************/
  function getTokenURI(uint256 tokenId) public view  returns (string memory) {
    require(_exists(tokenId), 'token does not exist');
    return _tokenURIs[tokenId];
  }

  function getTokenName() public view returns(string memory) {
    return _tokenName;

  }

  function getTokenSymbol() public view returns(string memory) {
    return _tokenSymbol;
  }


  function getBaseTokenURI() public view returns(string memory) {
    return _baseTokenURI;
  }







  



}

