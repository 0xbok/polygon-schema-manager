// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.16;

/**
 * @title SchemaRegistry
 * @dev Smart Contract for Polygon Schema Methods
 */
contract SchemaRegistry {
    mapping(address _id => mapping(string schemaId => string schema)) public schemas;
    mapping(address _id => uint nextNonce) public nonce;

    event SchemaCreate(address indexed id, string schemaId, string schemaJson);

    /*
     * @dev Creates a new schema with signature verification.
     * @param _id Address identifier.
     * @param newSchemaId Identifier for the new schema.
     * @param _json JSON representation of the schema.
     * @param r Signature's r.
     * @param s Signature's s.
     * @param v Signature's v.
     */
    function createSchema(
        address _id,
        string memory newSchemaId,
        string memory _json,
        bytes32 r,
        bytes32 s,
        uint8 v
    ) external {
        require(_id != address(0), 'Invalid address provided');

        bytes32 messageHash = keccak256(abi.encodePacked(_id, newSchemaId, _json, nonce[_id]++));
        bytes32 ethSignedMessageHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash));

        address signer = ecrecover(ethSignedMessageHash, v, r, s);
        require(signer == _id, 'Invalid signature');

        schemas[_id][newSchemaId] = _json;

        emit SchemaCreate(_id, newSchemaId, _json);
    }
}
