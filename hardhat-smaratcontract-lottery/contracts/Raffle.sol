// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;


error Raffle__NotEnoughETHEntered();

contract Raffle {

    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    /*Events */
    event RaffleEnter(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee
    }

    function enterRaffle() public payable{
        // require (msg.value > i_entranceFee, "Not enough ETH!")
        if(msg.value < i_entranceFee) {
            revert Raffle__NotEnoughETHEntered();
            }

        s_players.push(payable(msg.sender));
        // emit event when array or mapping is updated
        // Named events with the function name reversed
        emit RaffleEnter(msg.sender);

    }

    //function pickRandomWinner() {}

    function getEntranceFee() public view returns(uint256) {
        return i_entranceFee;
    }

    function getPlayer(uint256 index) public view returns(address) {
        return s_players[index];
    }
}