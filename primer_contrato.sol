//Primer contrato con solidity
//"SPDX-License-Identifier: <SPDX-License>"

pragma solidity >=0.4.4  <0.9.0;
import "./ERC20.sol";

contract primercontrato {
    address owner;
    ERC20Basic token;
    
    constructor() public{
        owner = msg.sender;
        token = new ERC20Basic(1000);

    }
}
