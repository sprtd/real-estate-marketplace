// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

contract MyERC165 {
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

    /*
     * 0x01ffc9a7 ===
     *     bytes4(keccak256('supportsInterface(bytes4)'))
     */

    /**
     * @dev a mapping of interface id to whether or not it's supported
     */

    mapping(bytes4 => bool) private _supportedInterfaces;

    /**
     * @dev A contract implementing SupportsInterfaceWithLookup
     * implement ERC165 itself
    */


    constructor() {

    }

    /********************************************************************************************/
    /*                                      CORE FUNCTIONS                           */
    /******************************************************************************************/

    /**
    * @dev internal method for registering an interface
    */

    function _registerInterface(bytes4 _interfaceId) internal {
        require(_interfaceId != 0xffffffff);
        _supportedInterfaces[_interfaceId] = true;
    }


    /********************************************************************************************/
    /*                                      UTILITY FUNCTIONS                                  */
    /******************************************************************************************/

    /**
     * @dev implement supportsInterface(bytes4) using a lookup table
     */
    function checkSupportInterface(bytes4 _interfaceId) external view virtual returns(bool) {
        return _supportedInterfaces[_interfaceId];
    }


}
