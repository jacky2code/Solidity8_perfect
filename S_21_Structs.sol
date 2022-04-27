// SPDX-License-Identifier: GPL-2.0
pragma solidity >=0.8.7 <0.9.0;

/**
 *   Structs
 */
contract Structs {
    struct Car {
        string model;
        uint256 year;
        address owner;
    }

    // 单辆车
    Car public car;
    // 多辆车
    Car[] public cars;
    // 某人有多辆车
    mapping(address => Car[]) public carsByOwner;

    function example() external {
        Car memory ec6 = Car("NIO EC6", 2021, msg.sender);
        Car memory et7 = Car({model: "NIO ET7", year: 2022, owner: msg.sender});
        Car memory es8;
        es8.model = "NIO ES8";
        es8.year = 2019;
        es8.owner = msg.sender;

        cars.push(ec6);
        cars.push(et7);
        cars.push(es8);

        Car memory _car = cars[0];
        _car.year;

        Car storage _carModify = cars[0];
        _carModify.year = 2020;
        delete _carModify.owner;

        delete cars[1];
    }
}
