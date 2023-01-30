// SPDX-License-Identifier: MIT 
pragma solidity  >=0.7.0 < 0.9.0;

contract Upload {
    struct Acess {
        address user;
        bool acess; // true or false
    }

    mapping(address=> string[]) value;
    mapping(address => mapping(address => bool))  ownership;
    mapping(address => Acess[]) acessList;
    mapping(address => mapping(address => bool))  previousData;

    function add(address _user, string memory url) external {
        value[_user].push(url);
    }

    function allow(address user) external {
        ownership[msg.sender][user] = true;
        if(previousData[msg.sender][user]){
            for( uint i = 0; i < acessList[msg.sender].length; i++){
                if(acessList[msg.sender][i].user == user){
                    acessList[msg.sender][i].acess == true;
                }
                else{
                    acessList[msg.sender].push(Acess(user,true));
                    previousData[msg.sender][user] = true;

                }
            }
        }
    }

    function disAllow(address user) public  {
        ownership[msg.sender][user] = false;
        for(uint i = 0;i < acessList[msg.sender].length; i++){
            if(acessList[msg.sender][i].user == user){
                acessList[msg.sender][i].acess = false;
            }
        }
    }

    function display(address _user) external view returns (string[] memory){
        require(_user == msg.sender || ownership[_user][msg.sender], "You dont have acess.");
        return value[_user];
    }
function shareAccess() public view returns (Acess[] memory){
    return acessList[msg.sender];
}

}