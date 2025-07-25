// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.28;

/**
 * @title SchemaRegistry
 * @dev Smart Contract for Schema Methods
 */
contract SchemaRegistry {
    mapping(address _id => mapping(string schemaId => string schema)) public schemas;

    event SchemaCreate(address indexed id, string schemaId);

    /*
     * @dev Creates a new schema.
     * @param newSchemaId Identifier for the new schema.
     * @param _json JSON representation of the schema.
     */
    function createSchema(
        string memory newSchemaId,
        string memory _json
    ) external {
        require(bytes(schemas[msg.sender][newSchemaId]).length == 0, "NOT_ALLOWED");
        schemas[msg.sender][newSchemaId] = _json;
        emit SchemaCreate(msg.sender, newSchemaId);
    }
}
