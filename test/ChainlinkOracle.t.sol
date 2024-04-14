// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ChainlinkPriceFeed} from "../src/ChainlinkPriceFeed.sol";

contract ChainlinkPriceFeedTest is Test {
    ChainlinkPriceFeed public oracle;

    function setUp() public {
        oracle = new ChainlinkPriceFeed("ETH / USD", 8);
    }

    function test_Init() public view {
        assertEq(oracle.description(), "ETH / USD");
        assertEq(oracle.decimals(), 8);
        assertEq(oracle.version(), 0);
        assertEq(oracle.roundId(), 0);
    }

    function test_updatePrice() public {
        uint256 ts = block.timestamp;
        oracle.updatePrice(123 * 1e8);
        vm.warp(ts + 10);
        oracle.updatePrice(456 * 1e8);

        assertEq(oracle.roundId(), 2);

        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) = oracle.latestRoundData();
        assertEq(roundId, 2);
        assertEq(answer, 456 * 1e8);
        assertEq(startedAt, ts + 10);
        assertEq(updatedAt, ts + 10);
        assertEq(answeredInRound, 2);

        (roundId, answer, startedAt, updatedAt, answeredInRound) = oracle.getRoundData(1);
        assertEq(roundId, 1);
        assertEq(answer, 123 * 1e8);
        assertEq(startedAt, ts);
        assertEq(updatedAt, ts);
        assertEq(answeredInRound, 1);

        (roundId, answer, startedAt, updatedAt, answeredInRound) = oracle.getRoundData(2);
        assertEq(roundId, 2);
        assertEq(answer, 456 * 1e8);
        assertEq(startedAt, ts + 10);
        assertEq(updatedAt, ts + 10);
        assertEq(answeredInRound, 2);
    }
}
