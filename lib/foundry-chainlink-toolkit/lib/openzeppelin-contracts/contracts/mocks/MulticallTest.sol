// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./MulticallTokenMock.sol";

contract MulticallTest {
    function checkReturnValues(
        MulticallTokenMock multicallToken,
        address[] calldata recipients,
        uint256[] calldata amounts
    ) external {
        bytes[] memory calls = new bytes[](recipients.length);
        for (uint256 i = 0; i < recipients.length; i++) {
            calls[i] = abi.encodeWithSignature("transfer(address,uint256)", recipients[i], amounts[i]);
        }

        bytes[] memory results = multicallToken.multicall(calls);
        for (uint256 i = 0; i < results.length; i++) {
            require(abi.decode(results[i], (bool)));
        }
    }
}
