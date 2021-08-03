pragma solidity 0.8.0;

import "./TimeLockedWallet.sol";

contract TimeLockedWalletFactory {
    mapping(address => address[]) wallets;
    
    event Created(address wallet, address from, address to, uint createdAt, uint unlockDate, uint amount);
    
    function getWallets(address _user) public view returns(address[] memory){
        return wallets[_user];
    }
    
    function newTimeLockedWallet(address creator, address payable _owner, uint _unlockDate) payable public returns(address walletAddress) {
        TimeLockedWallet wallet = new TimeLockedWallet(creator, _owner, _unlockDate);
        wallets[creator].push(address(wallet));
        if(creator != _owner){
            wallets[_owner].push(address(wallet));
        }
        emit Created(address(wallet), msg.sender, _owner, block.timestamp, _unlockDate, msg.value);
        
        return address(wallet);
    }
}