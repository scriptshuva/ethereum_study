// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title VotingContract
 * @dev A simple smart contract for voting and donation.
 */
contract VotingContract {
    // Struct to represent a candidate
    struct Candidate {
        string name;
        uint voteCount;
    }

    // Mapping to store candidate information
    mapping(string => Candidate) public candidates;

    // Mapping to keep track of whether an address has voted
    mapping(address => bool) public hasVoted;

    // Event emitted when a donation is received
    event DonationReceived(address indexed sender, uint amount);
    // Event emitted when a vote is cast
    event VoteCast(address indexed voter, string candidateName);

    /**
     * @dev Constructor to initialize the contract with two candidates.
     */
    constructor() {
        // Initialize candidates
        candidates["John"] = Candidate("John", 0);
        candidates["Paul"] = Candidate("Paul", 0);
    }

    /**
     * @dev Function to cast a vote for a candidate.
     * @param _candidateName The name of the candidate to vote for.
     */
    function vote(string memory _candidateName) public onlyValidCandidate(_candidateName) hasNotVoted {
        // Mark the sender as having voted
        hasVoted[msg.sender] = true;

        // Increment the vote count for the selected candidate
        candidates[_candidateName].voteCount++;

        // Emit a VoteCast event
        emit VoteCast(msg.sender, _candidateName);
    }

    /**
     * @dev Modifier to check if the candidate name is valid.
     * @param _candidateName The name of the candidate.
     */
    modifier onlyValidCandidate(string memory _candidateName) {
        require(
            keccak256(abi.encodePacked(_candidateName)) == keccak256(abi.encodePacked("John")) ||
            keccak256(abi.encodePacked(_candidateName)) == keccak256(abi.encodePacked("Paul")),
            "Invalid candidate name"
        );
        _;
    }

    /**
     * @dev Modifier to check if the sender has not voted already.
     */
    modifier hasNotVoted() {
        require(!hasVoted[msg.sender], "You have already voted");
        _;
    }

    /**
     * @dev Function to get the vote count and candidate information.
     * @param _candidateName The name of the candidate.
     * @return voteCount The current vote count for the candidate.
     * @return candidate The Candidate struct containing the name and vote count.
     */
    function getCandidateVoteCount(string memory _candidateName) public view returns (uint voteCount, Candidate memory candidate) {
        candidate = candidates[_candidateName];
        voteCount = candidate.voteCount;
    }

    /**
     * @dev Function to allow users to send Ether as a donation.
     */
    function donate() public payable {
        // Emit an event with the sender's address and the amount of Ether received
        emit DonationReceived(msg.sender, msg.value);
    }
}

