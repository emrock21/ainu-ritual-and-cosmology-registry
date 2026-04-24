// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract AinuRitualAndCosmologyRegistry {

    struct RitualTradition {
        string ritualName;          // iomante, inau offerings, kamuy rituals
        string spiritualEntities;   // kamuy involved
        string materials;           // inau, sake, carved objects, food offerings
        string procedures;          // ritual steps, chants, dances
        string symbolism;           // meaning within Ainu cosmology
        string culturalContext;     // seasonal cycles, clan roles, social meaning
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct RitualInput {
        string ritualName;
        string spiritualEntities;
        string materials;
        string procedures;
        string symbolism;
        string culturalContext;
    }

    RitualTradition[] public traditions;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event RitualRecorded(uint256 indexed id, string ritualName, address indexed creator);
    event RitualVoted(uint256 indexed id, bool like, uint256 likes, uint256 dislikes);

    constructor() {
        traditions.push(
            RitualTradition({
                ritualName: "Example (replace manually)",
                spiritualEntities: "example",
                materials: "example",
                procedures: "example",
                symbolism: "example",
                culturalContext: "example",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordRitual(RitualInput calldata r) external {
        traditions.push(
            RitualTradition({
                ritualName: r.ritualName,
                spiritualEntities: r.spiritualEntities,
                materials: r.materials,
                procedures: r.procedures,
                symbolism: r.symbolism,
                culturalContext: r.culturalContext,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit RitualRecorded(traditions.length - 1, r.ritualName, msg.sender);
    }

    function voteRitual(uint256 id, bool like) external {
        require(id < traditions.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;
        RitualTradition storage r = traditions[id];

        if (like) r.likes++;
        else r.dislikes++;

        emit RitualVoted(id, like, r.likes, r.dislikes);
    }

    function totalRituals() external view returns (uint256) {
        return traditions.length;
    }
}
