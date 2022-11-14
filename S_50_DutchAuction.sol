// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IERC721 {
    function transferFrom(address _from, address _to, uint _nftId) external;
}

/**
 * @name: DutchAuction
 * @desc: 荷兰拍卖
 */
contract DutchAuction {
    // 拍卖持续时间
    uint private constant DURATION = 7 days;
    // 拍卖 nft 合约
    IERC721 public immutable nft;
    // 拍卖 nft id
    uint public immutable nftId;

    // 拍卖人
    address payable public immutable seller;
    // 起始价格
    uint public immutable startPrice;
    // 开始时间
    uint public immutable startAt;
    // 到期时间
    uint public immutable expiresAt;
    // 每秒折扣率
    uint public immutable discountRate;

    constructor(
        uint _startPrice,
        uint _discountRate,
        address _nft,
        uint _nftId
        ) {
            // 拍卖完后要把主币发送给seller
            seller = payable(msg.sender);
            startPrice = _startPrice;
            discountRate = _discountRate;
            startAt = block.timestamp;
            expiresAt = startAt + DURATION;

            // 随着每秒折扣，价格不能大于起拍价
            require(_startPrice >= _discountRate * DURATION, "starting price < discount");
            // 将address转换成IERC721合约
            nft = IERC721(_nft);
            nftId = _nftId;
        }

    /**
     * @name: getPrice
     * @desc: 随着时间的流逝，获取当前价格
     * @param {public view} returns
     * @return {*}
     */    
    function getPrice() public view returns (uint) {
        // 流逝时间
        uint timeElapsed = block.timestamp - startAt;
        // 需要折扣的价格
        uint discount = discountRate * timeElapsed;
        // 当前价
        return startPrice - discount
    }

    /**
     * @name: buy
     * @desc: 购买nft
     * @return {*}
     */
    function buy() external payable {
        // 拍卖没有到期
        require(block.timestamp < expiresAt, "auction expired");
        // 获取价格
        uint price = getPrice();
        // 购买的ETH必须大于价格
        require(msg.value >= price, "ETH < price");
        // 发送nft
        nft.transferFrom(seller, msg.sender, nftId);
        // 当ETH>价格，要把多余eth退款给用户
        uint refund = msg.value - price;
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }
        // 自毁并发送主币给seller
        selfdestruct(seller);
    }
}