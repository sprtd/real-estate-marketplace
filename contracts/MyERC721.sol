// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import '@openzeppelin/contracts/utils/Counters.sol';
import './Pausable.sol';


contract MyERC721 is  Pausable, ERC721 {  
    
	/********************************************************************************************/
	/*                                     STATE VARIABLES                                          */
	/******************************************************************************************/
	// Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
	// which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
	using Counters for Counters.Counter;
	Counters.Counter private _tokenIds; 
	bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
	
	mapping(uint256 => address) private _tokenOwner; 
	
    // mapping token id to approved address
	mapping(uint256 => address) private _tokenApprovals;
	
	// mapping from owner to operator approval
	mapping(address => mapping(address => bool)) private _operatorApprovals;
	


	/********************************************************************************************/
	/*                                      EVENTS                                  */
	/******************************************************************************************/
	event LogApprovalForAll(address indexed owner, address indexed operator, bool approveStatus);
	event LogTransfer(address indexed from, address indexed to, uint256 tokenId);
// 	event LogTokenMinted(address indexed minter, uint256 tokenId);

	constructor(string memory _tokenName, string memory _symbol) ERC721(_tokenName, _symbol) {

	}

	/**
		* @dev approve another address to transfer the given tokenId
	*/

	function approve(address _to, uint256 _tokenId) public  override  {
		require(_tokenOwner[_tokenId] != _to, 'must not be approved address');
		require(msg.sender == contractOwner || isApprovedForAll(msg.sender, _to), 'caller not approved');
		_tokenApprovals[_tokenId] = _to;
		emit Approval(msg.sender, _to, _tokenId);

	}

	function getApproved(uint256 _tokenId) public view override returns(address) {
		return _tokenApprovals[_tokenId];
	}

	/**
		* @dev Sets or unsets the approval of a given operator
		* An operator is allowed to transfer all tokens of the sender on their behalf
		* @param _to operator address to set the approval
	*/
	
	function setApprovalForAll(address _to, bool _approveStatus) public  override {
	  setApprovalForAll(_to, _approveStatus);

	    
	}
	
	/**
    * @dev Tells whether an operator is approved by a given owner
     * @param _owner owner address which you want to query the approval of
     * @param _operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
  */
	
	function isApprovedForAll(address _owner, address _operator) public view override returns(bool)  {
	  return _operatorApprovals[_owner][_operator];
	}


	function mintToken(address _to) internal {
		require(_to != address(0), 'cannot be zero address');
		uint256 id = _tokenIds.current();
		_tokenIds.increment();
		_safeMint(_to, id);
		emit LogTransfer(address(0), _to, id);
	}
	
	// @dev Internal function to transfer ownership of a given token ID to another address.
	// TIP: remember the functions to use for Counters. you can refresh yourself with the link above
	function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
		require(_from == _tokenOwner[_tokenId], 'caller not owner');
		require(_to != address(0), 'not a valid address');
		_clearApproval(_tokenId);

		transferFrom(_from, _to, _tokenId);
		emit Transfer(_from, _to, _tokenId);
	}
	// @dev private function clear approval 
	// @param _tokenId whose approval is to be removed
	function _clearApproval(uint256 _tokenId) private {
		if(_tokenApprovals[_tokenId] != address(0)) {
			_tokenApprovals[_tokenId] = address(0);
		}
	}

	function getTotalSupply() public view returns(uint256) {
		return _tokenIds.current();
	}




}