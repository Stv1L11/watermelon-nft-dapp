 SPDX-License-Identifier MIT
pragma solidity ^0.8.20;

import @openzeppelincontractstokenERC721extensionsERC721URIStorage.sol;
import @openzeppelincontractsaccessOwnable.sol;

contract WatermelonNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId = 1;
    uint256 private randomNonce = 1;

    struct ItemType {
        string name;
        string rarity;
        uint256 power;
        uint256 defense;
        string uri;
        bool exists;
    }

    struct TokenData {
        uint8 itemType;
        uint256 mintedAt;
    }

    struct TradeListing {
        address seller;
        address buyer;
        bool active;
    }

    mapping(uint8 = ItemType) public itemTypes;
    mapping(uint256 = TokenData) public tokenData;

    mapping(address = uint256) public lastMintedTokenId;
    mapping(address = uint256[]) private lastBatchMintedTokenIds;

    mapping(uint8 = uint256) public typePrices;
    mapping(uint256 = TradeListing) public tradeListings;

    event WatermelonMinted(
        address indexed owner,
        uint256 indexed tokenId,
        uint8 indexed itemType,
        string name
    );

    event TokenListedForSale(
        uint256 indexed tokenId,
        address indexed seller,
        address indexed buyer,
        uint256 price
    );

    event TokenSaleCancelled(
        uint256 indexed tokenId,
        address indexed seller
    );

    event TokenSold(
        uint256 indexed tokenId,
        address indexed seller,
        address indexed buyer,
        uint256 price
    );

    constructor() ERC721(Watermelon Game Item, WMELON) Ownable(msg.sender) {
        typePrices[1] = 0.0001 ether;  Normal Watermelon
        typePrices[2] = 0.0005 ether;  Yellow Watermelon
        typePrices[3] = 0.001 ether;  Square Watermelon
        typePrices[4] = 0.004 ether;  Frozen Watermelon
        typePrices[5] = 0.007 ether;   Golden Watermelon
    }

    function setItemType(
        uint8 typeId,
        string memory name,
        string memory rarity,
        uint256 power,
        uint256 defense,
        string memory uri
    ) external onlyOwner {
        require(typeId = 1 && typeId = 5, Invalid typeId);

        itemTypes[typeId] = ItemType(
            name,
            rarity,
            power,
            defense,
            uri,
            true
        );
    }

    function setTypePrice(uint8 typeId, uint256 price) external onlyOwner {
        require(typeId = 1 && typeId = 5, Invalid typeId);
        require(price  0, Price must be greater than 0);

        typePrices[typeId] = price;
    }

    function mintByType(uint8 typeId) external returns (uint256) {
        delete lastBatchMintedTokenIds[msg.sender];

        uint256 tokenId = _mintWatermelon(msg.sender, typeId);
        lastBatchMintedTokenIds[msg.sender].push(tokenId);

        return tokenId;
    }

    function mintRandom() external returns (uint256) {
        _requireAllTypesSet();

        delete lastBatchMintedTokenIds[msg.sender];

        uint8 typeId = _getRandomType(msg.sender);
        uint256 tokenId = _mintWatermelon(msg.sender, typeId);

        lastBatchMintedTokenIds[msg.sender].push(tokenId);

        return tokenId;
    }

    function mintRandomTen() external returns (uint256[] memory) {
        _requireAllTypesSet();

        delete lastBatchMintedTokenIds[msg.sender];

        uint256[] memory tokenIds = new uint256[](10);

        for (uint256 i = 0; i  10; i++) {
            uint8 typeId = _getRandomType(msg.sender);
            uint256 tokenId = _mintWatermelon(msg.sender, typeId);

            tokenIds[i] = tokenId;
            lastBatchMintedTokenIds[msg.sender].push(tokenId);
        }

        return tokenIds;
    }

    function _mintWatermelon(address to, uint8 typeId)
        internal
        returns (uint256)
    {
        require(itemTypes[typeId].exists, Item type does not exist);

        uint256 tokenId = nextTokenId;
        nextTokenId++;

        _safeMint(to, tokenId);
        _setTokenURI(tokenId, itemTypes[typeId].uri);

        tokenData[tokenId] = TokenData(typeId, block.timestamp);
        lastMintedTokenId[to] = tokenId;

        emit WatermelonMinted(
            to,
            tokenId,
            typeId,
            itemTypes[typeId].name
        );

        return tokenId;
    }

    function _getRandomType(address user) internal returns (uint8) {
        uint256 randomNumber = uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.prevrandao,
                    blockhash(block.number - 1),
                    user,
                    nextTokenId,
                    randomNonce
                )
            )
        ) % 100;

        randomNonce++;

        if (randomNumber  50) {
            return 1;  Normal Watermelon 50%
        } else if (randomNumber  75) {
            return 2;  Yellow Watermelon 25%
        } else if (randomNumber  90) {
            return 3;  Square Watermelon 15%
        } else if (randomNumber  98) {
            return 4;  Frozen Watermelon 8%
        } else {
            return 5;  Golden Watermelon 2%
        }
    }

    function _requireAllTypesSet() internal view {
        require(itemTypes[1].exists, Normal Watermelon not set);
        require(itemTypes[2].exists, Yellow Watermelon not set);
        require(itemTypes[3].exists, Square Watermelon not set);
        require(itemTypes[4].exists, Frozen Watermelon not set);
        require(itemTypes[5].exists, Golden Watermelon not set);
    }

    function getWatermelon(uint256 _tokenId)
        external
        view
        returns (
            string memory name,
            string memory rarity,
            uint256 power,
            uint256 defense,
            string memory uri
        )
    {
        ownerOf(_tokenId);

        TokenData memory data = tokenData[_tokenId];
        ItemType memory item = itemTypes[data.itemType];

        return (
            item.name,
            item.rarity,
            item.power,
            item.defense,
            item.uri
        );
    }

    function getFullTokenInfo(uint256 _tokenId)
        external
        view
        returns (
            address owner,
            uint8 itemType,
            string memory name,
            string memory rarity,
            uint256 power,
            uint256 defense,
            string memory actualTokenURI,
            uint256 mintedAt
        )
    {
        owner = ownerOf(_tokenId);

        TokenData memory data = tokenData[_tokenId];
        ItemType memory item = itemTypes[data.itemType];

        string memory uri = super.tokenURI(_tokenId);

        return (
            owner,
            data.itemType,
            item.name,
            item.rarity,
            item.power,
            item.defense,
            uri,
            data.mintedAt
        );
    }

    function getTokenURIById(uint256 _tokenId)
        external
        view
        returns (string memory)
    {
        ownerOf(_tokenId);
        return super.tokenURI(_tokenId);
    }

    function getLastBatchMintedTokenIds(address owner)
        external
        view
        returns (uint256[] memory)
    {
        return lastBatchMintedTokenIds[owner];
    }

    function getTokenPrice(uint256 tokenId) public view returns (uint256) {
        ownerOf(tokenId);

        TokenData memory data = tokenData[tokenId];
        uint8 itemType = data.itemType;

        require(itemTypes[itemType].exists, Item type does not exist);
        require(typePrices[itemType]  0, Price not set);

        return typePrices[itemType];
    }

    function listTokenForPublicSale(uint256 tokenId) external {
    require(ownerOf(tokenId) == msg.sender, You are not the owner);

    uint256 price = getTokenPrice(tokenId);

    tradeListings[tokenId] = TradeListing({
        seller msg.sender,
        buyer address(0),  address(0) 代表自由市場，任何人都可以買
        active true
    });

    emit TokenListedForSale(
        tokenId,
        msg.sender,
        address(0),
        price
    );
}

    function cancelTokenSale(uint256 tokenId) external {
        TradeListing memory listing = tradeListings[tokenId];

        require(listing.active, Token is not listed);
        require(listing.seller == msg.sender, You are not the seller);

        delete tradeListings[tokenId];

        emit TokenSaleCancelled(tokenId, msg.sender);
    }

    function buyListedToken(uint256 tokenId) external payable {
    TradeListing memory listing = tradeListings[tokenId];

    require(listing.active, Token is not listed);
    require(ownerOf(tokenId) == listing.seller, Seller is no longer owner);
    require(listing.seller != msg.sender, Seller cannot buy own NFT);

     如果 buyer 是 address(0)，代表自由市場，任何人都可以買
     如果 buyer 不是 address(0)，代表指定買家交易，只有指定買家能買
    if (listing.buyer != address(0)) {
        require(listing.buyer == msg.sender, You are not the assigned buyer);
    }

    uint256 price = getTokenPrice(tokenId);

    require(msg.value = price, Not enough ETH);

    delete tradeListings[tokenId];

    _safeTransfer(
        listing.seller,
        msg.sender,
        tokenId,
        
    );

    (bool paidSeller, ) = payable(listing.seller).call{value price}();
    require(paidSeller, Payment to seller failed);

    if (msg.value  price) {
        (bool refunded, ) = payable(msg.sender).call{
            value msg.value - price
        }();
        require(refunded, Refund failed);
    }

    emit TokenSold(
        tokenId,
        listing.seller,
        msg.sender,
        price
    );
}

    function getTradeInfo(uint256 tokenId)
        external
        view
        returns (
            address seller,
            address buyer,
            bool active,
            uint256 price
        )
    {
        TradeListing memory listing = tradeListings[tokenId];

        uint256 tokenPrice = getTokenPrice(tokenId);

        return (
            listing.seller,
            listing.buyer,
            listing.active,
            tokenPrice
        );
    }
}