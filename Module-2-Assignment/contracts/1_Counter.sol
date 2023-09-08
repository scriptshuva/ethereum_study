// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Counter {

  // State variable
  uint public counter;

  // Function to increment the counter
  function increment() public {
    counter++;
  }

  // Function to get the current value of the counter
  function getCounter() public view returns (uint) {
    return counter;
  }

  // Event emitted when the counter is incremented
  event CounterIncremented(uint value);

  // Constructor
  constructor() {
    counter = 0;
  }

}