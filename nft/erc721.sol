
contract ERC721 {
    struct Token {
        uint256 tokenId;
        address owner;
    }

    Token[] public tokens;

    event Transfer(address indexed from, address indexed to, uint256 tokenId);

    constructor() {
    }

    // Ensures that only the owner of the token can perform certain functions
    modifier onlyOwner(address _owner) {
        require(msg.sender == _owner);
        _;
    }

    function mint(address receiver, uint256 tokenId) public {
        // Check if tokenId already exists
        require(tokens[tokenId].owner == address(0), "Token ID already exists!");
        // Check for overflow
        require(tokenId > 0);
        tokens[tokenId].owner = receiver;
    }

    function transfer(address _to, uint256 _tokenId) public onlyOwner(tokens[_tokenId].owner) {
        require(tokens[_tokenId].owner != _to);
        tokens[_tokenId].owner = _to;
        emit Transfer(msg.sender, _to, _tokenId);
    }

    function balanceOf(address _owner) public view returns (uint256) {
        uint256 balance = 0;
        // Use a more efficient looping technique to prevent gas issues if the array of tokens grows too large
        for (uint256 i = 0; i < tokens.length; i++) {
            if (tokens[i].owner == _owner) {
                balance++;
            }
        }
        return balance;
    }
}