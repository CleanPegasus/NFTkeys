// SPDX-License-Identifier: GPL-3
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTKeys is ERC721 {
    // using Counters for Counters.Counter;
    // Counters.Counter private _tokenIds;

    uint tokenId = 0;
    address[] owners;
    mapping(address => bool) private transactionApproval;

    constructor() public ERC721("NFT Keys", "kNFT") {
        owners = [0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,
                0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,
                0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2];

        for(uint i = 0; i<owners.length; i++) {
        _mint(owners[i], tokenId);
        tokenId++;
      }
    }

    receive() external payable{}

    modifier checkNFT(address _address) {
        bool yes_NFT = false;
        for(uint256 i = 0; i<3; i++) { // Change it to token supply
                if(msg.sender == ownerOf(i)) {
                    yes_NFT = true;
                }
        require(yes_NFT == true, "Not allowed");
        _;
        }
  }

    function approveTransaction() public checkNFT(msg.sender){
        transactionApproval[msg.sender] = true;
    }

    function withdrawEther(address payable _to, uint256 _value) public payable  {
            _to.transfer(_value);
            for(uint256 i = 0; i<owners.length; i++) {
                transactionApproval[owners[i]] = false;
            }
        }    

}