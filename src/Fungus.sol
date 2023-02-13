// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Fungus is ERC721 {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private _nextTokenId;

    uint256 public constant MAX_SUPPLY = 4242;

    constructor() ERC721("Fungus", "FNG") {
        // Starts as 1
        _nextTokenId.increment();
    }

    function mint(address to, uint256 amount) public payable {
        require(amount > 0, "Amount must be at least 1");
        require(
            _nextTokenId.current() + amount <= MAX_SUPPLY,
            "Not enough tokens left"
        );
        // _safeMint IS NOT SAFE!!!!
        // use a nonReentrant
        for (uint256 i = 0; i < amount; i++) {
            _safeMint(to, _nextTokenId.current());
            _nextTokenId.increment();
        }
    }

    // Getters
    function getFungusBase() private view returns (string memory fungusBase) {
        return
            string(
                abi.encodePacked(
                    "<rect fill='#ffcc00' height='24' width='24' />",
                    "<rect fill='#ff0000' height='1' width='8' x='8' y='3' />",
                    "<rect fill='#ff0000' height='1' width='10' x='7' y='4' />",
                    "<rect fill='#ff0000' height='1' width='12' x='6' y='5' />",
                    "<rect fill='#ff0000' height='1' width='14' x='5' y='6' />",
                    "<rect fill='#ff0000' height='1' width='16' x='4' y='7' />",
                    "<rect fill='#ff0000' height='1' width='18' x='3' y='8' />",
                    "<rect fill='#ff0000' height='1' width='18' x='3' y='9' />",
                    "<rect fill='#ff0000' height='1' width='18' x='3' y='10' />",
                    "<rect fill='#ff0000' height='1' width='18' x='3' y='11' />",
                    "<rect fill='#ff0000' height='1' width='18' x='3' y='12' />",
                    "<rect fill='#ff0000' height='1' width='16' x='4' y='13' />",
                    "<rect fill='#ff0000' height='1' width='14' x='5' y='14' />",
                    "<rect fill='#ff0000' height='1' width='12' x='6' y='15' />"
                )
            );
    }

    function getFungusTail() private view returns (string memory fungusTail) {
        return
            string(
                abi.encodePacked(
                    "<rect fill='#0099ff' height='5' width='6' x='9' y='16' />"
                )
            );
    }

    function getFungusEyes() private view returns (string memory fungusEyes) {
        return
            string(
                abi.encodePacked(
                    "<rect fill='#ffffff' height='2' width='2' x='8' y='8' />",
                    "<rect fill='#ffffff' height='2' width='2' x='12' y='8' />"
                )
            );
    }

    function getFungusMouth() private view returns (string memory fungusEyes) {
        return
            string(
                abi.encodePacked(
                    "<rect fill='#ffffff' height='2' width='6' x='8' y='12' />"
                )
            );
    }

    function getFungusGrass() private view returns (string memory fungusTail) {
        return
            string(
                abi.encodePacked(
                    "<rect fill='#33cc33' height='4' width='24' y='20' />"
                )
            );
    }

    function getFungusSvg() private view returns (string memory svg) {
        svg = string(
            abi.encodePacked(
                getFungusBase(),
                getFungusGrass(),
                getFungusTail(),
                getFungusEyes(),
                getFungusMouth()
            )
        );

        return
            string(
                abi.encodePacked(
                    "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 24 24'>",
                    svg,
                    "</svg>"
                )
            );
    }

    // function tokenURI(uint256 tokenId)
    //     public
    //     view
    //     override
    //     returns (string memory)
    // {
    //     return
    //         string(
    //             abi.encodePacked(
    //                 "data:application/json;base64,",
    //                 Base64.encode(
    //                     bytes(
    //                         string(
    //                             abi.encodePacked(
    //                                 '{"name": "Fungus #1',
    //                                 '", "description": "Fungus are a collection of fully on-chain, randomly generated.", "image": "data:image/svg+xml;base64,',
    //                                 Base64.encode(bytes(getFungusSvg())),
    //                                 '"}'
    //                             )
    //                         )
    //                     )
    //                 )
    //             )
    //         );
    // }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    '"image": "data:image/svg+xml;base64,',
                    Base64.encode(bytes(getFungusSvg())),
                    '"}'
                )
            );
    }
}
