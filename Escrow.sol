pragma solidity ^0.5.0;

contract Escrow {

    enum State {AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE}

    State public currentState;

    address buyer;
    address payable seller;
    uint ballance;

    // confirmPayment needs to require correct balance

    modifier buyerOnly() {
        require(msg.sender == buyer, "Sender not authorized.");
        _;
    }

    modifier inState(State expectedState) {
        require(currentState == expectedState, "Sender not authorized.");
        _;
    }

    constructor(address _buyer, address payable _seller) payable public {
        buyer = _buyer;
        seller = _seller;
        ballance = 0;
        currentState = State.AWAITING_PAYMENT;
    }

    function confirmPayment() public buyerOnly inState(State.AWAITING_PAYMENT) payable{
        currentState = State.AWAITING_DELIVERY;
        ballance += msg.value;
    }

    function confirmDelivery() public buyerOnly inState(State.AWAITING_DELIVERY) {
        seller.transfer(ballance);
        currentState = State.COMPLETE;
    }
}