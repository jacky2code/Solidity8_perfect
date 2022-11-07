// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Structs 结构体
contract Structs {
    struct Car {
        string model;
        uint year;
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
        Car memory et7 = Car({year: 2022, model: "NIO ET7", owner: msg.sender});
        Car memory es8;
        es8.model = "NIO ES8";
        es8.year = 2019;
        es8.owner = msg.sender;

        cars.push(ec6);
        cars.push(et7);
        cars.push(es8);

        // 取出到内存中
        Car memory _car = cars[1];
        _car.year;

        // 取出到存储中
        Car storage _carModify = cars[0];
        _carModify.year = 2020;
        delete _carModify.owner;

        delete cars[1];
    }
}
