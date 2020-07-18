 pragma solidity 0.4.24;

contract Vote {
    // structure
    struct candidator {
        string name;
        uint upVote;
        
    }
    
    // variables
    bool live; // Is vote alive?
    address owner; // Contract owner
    candidator[] public candidatorList;
    
    // mapping
    mapping(address => bool) Voted; // To check voters cast their votes before
    
    // event
    event AddCandidator(string name);
    event UpVote(string candidator, uint upVoate);
    event FinishVote(bool live);
    event Voting(address owner);
    
    // modifier
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    // constructor
    constructor() public {
        owner = msg.sender;
        live = true;
        
        emit Voting(owner);
    }
    
    // Candidator
    function addCandidator (string _name) public onlyOwner {
        require(live == true);
        require(candidatorList.length < 6); // Limiting the number of candidates to five
        
        candidatorList.push(candidator(_name, 0));
        
        // emit event
        emit AddCandidator(_name);
    }
    
    // Voting
    function upVote(uint _indexOfCandidator) public {
        require(candidatorList.length > _indexOfCandidator); // Check index out of range
        require(Voted[msg.sender] == false); // Voters should not cast their votes before
        candidatorList[_indexOfCandidator].upVote++;
        
        Voted[msg.sender] = true;
        
        // emit event
        emit UpVote(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upVote);
    }
    
    // Finish Vote
    function finishVote () public onlyOwner {
        require(live == true);
        live = false;
        
        emit FinishVote(live);
    }
}
