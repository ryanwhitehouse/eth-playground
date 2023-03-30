
contract ERC721 {
    struct Token {
        uint256 tokenId;
        address owner;
    }

    Token[] public tokens;

    event Transfer(address indexed from, address indexed to, uint256 tokenId);

    constructor() {
    }

    function mint(address receiver, uint256 tokenId) public {
        // Check if tokenId already exists
        require(tokens[tokenId].owner == address(0), "Token ID already exists!");
        tokens[tokenId].owner = receiver;
    }

    function transfer(address _to, uint256 _tokenId) public {
        require(tokens[_tokenId].owner != _to);
        tokens[_tokenId].owner = _to;
        emit Transfer(msg.sender, _to, _tokenId);
    }

    function balanceOf(address _owner) public view returns (uint256) {
        uint256 balance = 0;
        for (uint256 i = 0; i < tokens.length; i++) {
            if (tokens[i].owner == _owner) {
                balance++;
            }
        }
        return balance;
    }
}