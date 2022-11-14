// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IERC721 {
    function transferFrom(
        address _from, 
        address _to, 
        uint _nftId
        ) external;
}

contract EnglishAuction {
    event Start();
    // 增加索引，提供链外查询
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address highestBidder, uint amount);)

    // 竞拍的NFT
    IERC721 public immutable nft;
    // 竞拍的NFTId
    uint public immutable nftId;

    // 销售者地址
    address payable public immutable seller;
    // 结束时间
    uint32 public entAt;
    // 是否开始
    bool public started;
    // 是否结束
    bool public ended;

    // 最高出价者
    address public highestBidder;
    // 最高出价
    uint public highestBid;
    // 最高价除外的所有其他出价
    mapping (address=>uint) public bids;

    constructor(
        address _nft,
        uint _nftId,
        uint _startingBid
    ) {
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    /**
     * @name: start 
     * @desc: 开始
     * @return {*}
     */
    function start() external {
        require(msg.sender == seller, "not seller");
        require(!started, "started");

        started = true;
        endAt = uint32(block.timestamp + 7 days);
        // 把NFT发送到竞拍合约中
        nft.transferFrom(seller, address(this), nftId);

        emit Start();
    }

    /**
     * @name: bid
     * @desc: 竞拍
     * @return {*}
     */
    function bid() external payable {
        require(started, "not started!");
        require(block.timestamp < endAt, "ended");
        require(msg.value > highestBid, "value < highest bid");

        if (highestBidder != address(0)) {
            // 某账户竞拍累加记录，通过累加记录退还竞价的代币
            bids[highestBidder] += highestBid;
        }

        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid(msg.sender, msg.value);
    }

    /**
     * @name: 取出
     * @desc: 取出自己的出价
     * @return {*}
     */
    function withdraw() external {
        // 数组中存储除了最高出价外的每个人的出价
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        // 发送
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender, bal);
    }

    /**
     * @name: end
     * @desc: 结束
     * @return {*}
     */
    function end() external {
        require(started, "not started");
        require(!ended, "ended");
        require(block.timestamp >= endAt, "not ended");

        ended = true;
        // 如果有人竞拍
        if (highestBidder != address(0)) {
            // 发送nft
            nft.transferFrom(address(this), highestBidder, nifId);
            // 把合约中的主币发送给销售者
            seller.transfer(highestBid);
        } else {    // 无人竞拍，nft发送回seller
            nft.transferFrom(address(this), seller, nftId);
        }

        emit End(highestBidder, highestBid);
    }
}