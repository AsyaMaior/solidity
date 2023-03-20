// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Signature {

    //белый лист
    mapping (address => bool) list;

    //структура отображает адрес и статус подписания им контракта (true or false)
    struct Sign {
        address addr;
        bool signature;
    }

    //signatures - массив структур подписей
    Sign[] public signatures;

    //проверка на принадлежность адреса к белому листу
    modifier whitelist {
        require(list[msg.sender] == true, "You address is not in whitelist!");
        _;
    }

    //функция подписания контракта
    function signContract() public whitelist {
        for (uint i = 0; i < signatures.length; i++) {
            if (signatures[i].addr == msg.sender) {
                signatures[i].signature = true;
            }
        }    
    }

    //добавить адрес в белый лист
    function addToWhitelist(address _address) public {
        list[_address] = true;
        signatures.push(Sign(msg.sender, false));
    }

    //удалить адрес из белого листа
    function dropFromWhitelist(address _address) public {
        list[_address] = false;
        for (uint i = 0; i < signatures.length; i++) {
            if (signatures[i].addr == _address) {
                signatures[i] = signatures[signatures.length - 1];
                signatures.pop();
                break;
            }
        }         
    }    

    //подписан ли контракт? возвращает true or false
    function isSigned () public view returns(bool) {
        bool _status = false;
        for (uint i = 0; i < signatures.length; i++) {
            if (signatures[i].signature == false) {
                return _status;
            }
        }
        _status = true;
        return _status;
    }
}
