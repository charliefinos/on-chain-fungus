// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract Fungus is ERC721 {
    using Strings for uint256;

    constructor() ERC721("Fungus", "FNG") {}

    function mint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
    }

    function getFungusBase() private view returns (string memory turtleBase) {
        return
            string(
                abi.encodePacked(
                    "<rect fill='#66ff33' height='24' width='24' />"
                )
            );
    }

    function getFungusSvg() private view returns (string memory svg) {
        svg = string(abi.encodePacked(getFungusBase()));

        return
            string(
                abi.encodePacked(
                    "<svg id='tiny-winged-turtle' xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 24 24'>",
                    svg,
                    "<style>#tiny-winged-turtle{shape-rendering:crispedges;}</style></svg>"
                )
            );
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            string(
                                abi.encodePacked(
                                    '{"name": "Fungus #1',
                                    '", "description": "Fungus are a collection of fully on-chain, randomly generated.", "image": "data:image/svg+xml;base64,',
                                    Base64.encode(bytes(getFungusSvg()))
                                )
                            )
                        )
                    )
                )
            );
    }
}
