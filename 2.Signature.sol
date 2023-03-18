// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Signature {
    
    //'белый список': адрес => true - в белом списке, false - не в белом списке
    mapping (address => bool) list; 
    
    //список подписавших: адрес => true - подписал proposal, false - не подписал proposal
    mapping (address => bool) public proposal; 
    
    //проверка на принадлежность адреса к белому списку
    modifier whitelist {
        require(list[msg.sender] == true, "You address is not in whitelist!"); 
        _;
    }
    
    //функция подписания документа (значение в proposal меняется на true)
    function signContract() public whitelist {
        proposal[msg.sender] = true;
    }

    //функция добавления адреса в белый список (значение в list меняется на true)
    function addToWhitelist(address _address) public {
        list[_address] = true;
    }
}
