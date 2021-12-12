
// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
 
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "https://github.com/0xcert/ethereum-erc721/src/contracts/tokens/nf-token-metadata.sol";
import "https://github.com/0xcert/ethereum-erc721/src/contracts/ownership/ownable.sol";
import "https://github.com/0xcert/ethereum-erc721/src/contracts/tokens/nf-token.sol";
 
contract newNFT is ERC721, Ownable, NFToken {
    uint256 public netSupply;
    address[] public owners;
    uint256 tokenId = 0;
    mapping(address => bool) private transactionApproval;

    event approval(address _address);
 
    constructor() ERC721("NFT Keys", "kNFT") {


    owners = [0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,
            0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,
            0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2];


    for(uint i = 0; i<owners.length; i++) {
        super._mint(owners[i], tokenId);
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

  function askApproval() {
      for(uint256 i = 0; i<owners.length; i++) {
          emit approval(owners[i]);
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




  // function setAddresses(address[] memory _addresses) public {
      // require(_addresses.length = netSupply);
      // owners = _addresses;
  // }
 
     // super._mint(_to, _tokenId);
    // add token_uri as an IPFS scrambled code

}
