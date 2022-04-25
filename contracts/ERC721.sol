pragma solidity ^0.8.2;

contract ERC721 {
     event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
     event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);


mapping(address => uint256) internal _balances;
mapping(uint => address) internal _owners;
mapping (address => mapping(address => bool)) private _operatorApprovals;
mapping(uint256 => address) private _tokenApprovals;
// return the number of NFT of an user
function balanceOf(address owner) external view returns (uint256) {
    require(owner != address(0), 'Address is zero');
    return _balances[owner];
}
// find the owner of an NFT
function ownerOf(uint256 _tokenId) public view returns (address) {
    address owner = _owners[_tokenId];
    require(owner != address(0), 'Token ID does not exit');
    return owner;
}

// enable or disable an operator
 function setApprovalForAll(address operator, bool approved) external {
     _operatorApprovals[msg.sender][operator] = approved;
     emit ApprovalForAll(msg.sender, operator, approved);
 }

// check  if an address is an operator for an another address 
function isApprovedForAll(address owner, address operator) public view returns (bool){
    return _operatorApprovals[owner][operator];
}
// Update an approved address for an NFT
function approve(address to, uint256 tokenId) public payable {
      address owner = ownerOf(tokenId);
      require(msg.sender == owner || isApprovedForAll(owner,msg.sender) ,'msg.sender is not the owner');
      _tokenApprovals[tokenId] = to;
      emit Approval(owner, to, tokenId);
}
// Get approved  address for an NFT
 function getApproved(uint256 _tokenId) public view returns (address) {
     require(_owners[_tokenId] != address(0),"Token ID does not exist");
    return _tokenApprovals[_tokenId];
 }
// Transfer from ownerNFT to receiver need to buy NFT
function transferFrom(address from, address to, uint256 tokenId) public payable {
    address owner = ownerOf(tokenId);

    require(
        msg.sender == owner ||
        getApproved(tokenId) == msg.sender ||
        isApprovedForAll(owner, msg.sender),
        "Msg.sender is not  the owner or approved for transfer"
    );
    require(owner == from, 'from address is not the owner');
    require(to != address(0),'Address is the  zero address');
    require(_owners[tokenId] != address(0), 'Token ID does not exits');
    approve(address(0), tokenId);
    _balances[from] -= 1;
    _balances[to] += 1;
    _owners[tokenId] = to;
    emit Transfer(from, to, tokenId);
}
// standard transferFrom method
// check if the receiver smart contract is receiving NFT
  function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public payable {
      transferFrom(from, to, tokenId);
      require(_checkOnERC721Received(),'Receivee not implemented');
  }
  function _checkOnERC721Received() private pure returns(bool){
      return true;
  }
   function safeTransferFrom(address from, address to, uint256 tokenId) external payable {
       safeTransferFrom(from, to, tokenId, "");
   }
// EIP165 proposal: query if a contract implement another interface.
    function supportInterface(bytes4 interfaceID) public pure virtual returns(bool) {
        return interfaceID == 0x80ac58cd;
    }
}