// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

import './MyERC721.sol';
import './MyERC165.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';


contract MyERC721Enumerable is  MyERC165,  MyERC721 {
	using SafeMath for uint256;
	/********************************************************************************************/
	/*                                      STATE VARIABLES                                    */
	/******************************************************************************************/
    
  // mapping owner to list owned IDs
  mapping(address => uint256[]) private _ownedTokens;
	
	// mapping token ID to owner' tokens list
	mapping(uint256 => uint256) private _ownedTokensIndex;
	
	// array of token IDs
	uint256[] private _allTokens;
	
	// mapping token id to position in allTokens array
	mapping(uint256 => uint256) private _allTokensIndex;
    
	bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;
	/*
		* 0x780e9d63 ===
		*     bytes4(keccak256('totalSupply()')) ^
		*     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) ^
		*     bytes4(keccak256('tokenByIndex(uint256)'))
		*/

	/**
		* @dev Constructor function
	*/
	constructor (string memory _tokenName, string memory _symbol) MyERC721(_tokenName, _symbol) {
		// register the supported interface to conform to ERC721Enumerable via ERC165
		_registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);

	}
	
	/**
		* @dev Internal function to mint a new token
		* Reverts if the given token ID already exists
		*/
	function mintToken() public  {
		uint256 tokenId = getTotalSupply();
		mintToken(msg.sender);
		_addTokenOwnerEnumeration(msg.sender, tokenId);
		_addTokenToAllEnumeration(tokenId);
	}

	/**
		* @dev Internal function to transfer ownership of a given token ID to another address.
		* As opposed to transferFrom, this imposes no restrictions on msg.sender.
		* @param _from current owner of the token
		* @param _to address to receive the ownership of the given token ID
		* @param _tokenId uint256 ID of the token to be transferred
	*/
	
	function _transferTokenFrom(address _from, address _to, uint256 _tokenId) internal   {
		require(_ownedTokens[_from][_tokenId] == _tokenId, 'token not owned');
		_removeTokenFromOwnerEnumeration(_from, _tokenId);
		_addTokenOwnerEnumeration(_to, _tokenId);
		_transferTokenFrom(_from, _to, _tokenId);
			
	}
	
	/**
		* @dev Private function to add a token to this extension's ownership-tracking data structures.
		* @param _to address representing the new owner of the given token ID
		* @param _tokenId uint256 ID of the token to be added to the tokens list of the given address
	*/
		
	function _addTokenOwnerEnumeration(address _to, uint256 _tokenId) private {
		_ownedTokensIndex[_tokenId] = _ownedTokens[_to].length;
		_ownedTokens[_to].push(_tokenId);
	
	}
	
     
	/**
	* @dev Private function to add a token to this extension's token tracking data structures.
	* @param _tokenId uint256 ID of the token to be added to the tokens list
	*/
	function _addTokenToAllEnumeration(uint256 _tokenId) private {
		_allTokensIndex[_tokenId] = _allTokens.length;

		_allTokens.push(_tokenId);
	}
     
	/**
		* @dev Private function to remove a token from this extension's ownership-tracking data structures. Note that
		* while the token is not assigned a new owner, the `_ownedTokensIndex` mapping is _not_ updated: this allows for
		* gas optimizations e.g. when performing a transfer operation (avoiding double writes).
		* This has O(1) time complexity, but alters the order of the _ownedTokens array.
		* @param _from address representing the previous owner of the given token ID
		* @param _tokenId uint256 ID of the token to be removed from the tokens list of the given address
	*/

	function _removeTokenFromOwnerEnumeration(address _from, uint256 _tokenId) private {
		// To prevent a gap in from's tokens array, we store the last token in the index of the token to delete, and
		// then delete the last slot (swap and pop).

		uint256 lastTokenIndex = ERC721.balanceOf(_from) - 1;
		uint256 tokenIndex = _ownedTokensIndex[_tokenId];

		// When the token to delete is the last token, the swap operation is unnecessary
		if (tokenIndex != lastTokenIndex) {
			uint256 lastTokenId = _ownedTokens[_from][lastTokenIndex];

			_ownedTokens[_from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
			_ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
		}

		// This also deletes the contents at the last position of the array
		delete _ownedTokensIndex[_tokenId];
		delete _ownedTokens[_from][lastTokenIndex];
	}
	
    
	/********************************************************************************************/
	/*                                      UTILITY FUNCITONS                                  */
	/******************************************************************************************/


	/**
		* @dev Gets the list of token IDs of the requested owner
		* @param _owner address owning the tokens
		* @return uint256[] List of token IDs owned by the requested address
	*/
     
	
	function getTokensOfOwner(address _owner) internal view returns(uint256[] storage) {
		return _ownedTokens[_owner];
			
	}
     
	function isApprovedForAllCheck(address _owner, address _operator) public view  returns (bool) {
		// return _operatorApprovals[owner][operator];
		return isApprovedForAll(_owner, _operator);
	}

    
	/**
		* @dev Gets the token ID at a given index of the tokens list of the requested owner
		* @param _owner address owning the tokens list to be accessed
		* @param _index uint256 representing the index to be accessed of the requested tokens list
		* @return uint256 token ID at the given index of the tokens list owned by the requested address
	*/

	function tokenOfOwnerByIndex(address _owner, uint256 _index) public view returns(uint256) {
		require(_index < balanceOf(_owner), 'invalid index');
		return _ownedTokens[_owner][_index];
		
	}

	function getTotalTokenSupply() external view returns(uint256 totalSupply) {
		totalSupply = getTotalSupply();
		return totalSupply;
	}

    
}