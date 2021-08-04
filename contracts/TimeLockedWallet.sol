pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TimeLockedWallet {
    
    address public creator;
    address public owner;
    uint256 public unlockDate;
    uint256 public createdAt;
    event Received(address _from, uint _amount);
    event Withdrew(address _to, uint _amount);
    event WithdrewTokens(address _tokenContract, address _to, uint _amount);
    modifier onlyOwner {
        require(msg.sender == owner);
            _;
    }
    receive() external payable{
        emit Received(msg.sender, msg.value);
    }
    constructor (address _creator, address _owner, uint _unlockDate) {
        creator = _creator;
        owner = _owner;
        unlockDate = _unlockDate;
        createdAt = block.timestamp;
    }
    
    function info() public view returns(address, address, uint, uint) {
        return (creator, owner, unlockDate, createdAt);
    }
    
    function withdraw( ) onlyOwner public {
        require(block.timestamp >= unlockDate);
        payable(msg.sender).transfer(address(this).balance);
        emit Withdrew(msg.sender, address(this).balance);
    }
    
    function withdrawTokens(address _tokenContract) onlyOwner public {
        require(block.timestamp >= unlockDate);
        IERC20 token = IERC20(_tokenContract);
        uint tokenBalance = token.balanceOf(address(this));
        token.transfer(owner, tokenBalance);
       emit WithdrewTokens(_tokenContract, msg.sender, tokenBalance);
    }
}