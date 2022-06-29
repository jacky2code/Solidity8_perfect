// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

/**
 * 待办事项列表
 * - Insert, update, read from array of structs
 */
contract TodoList {
    // 事项结构体
    struct Todo {
        string text;
        // 待办状态
        bool completed;
    }
    // 待办数组
    Todo[] public todos;

    /** 创建待办事项 */
    function create(string calldata _text) external {
        todos.push(Todo({
            text: _text,
            completed: false
        }));
    }

    /** 
     * 更新待办事项
     * _index: 待办事项索引
     * _text: 更新内容 
     */
    function updateText(uint _index, string calldata _text) external {
        // 35138 gas 如果只更新一个属性，则节省gas，更新多个多次装入内存反而消耗更多gas
        todos[_index].text = _text;
        // todos[_index].text = _text;
        // todos[_index].text = _text;
        // todos[_index].text = _text;

        // 34578 gas 更新多个属性则节省gas
        // Todo storage todo = todos[_index];
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;
    }

    /** 
     * 获取待办事项
     * params
     * _index: 事项索引
     */
    function get(uint _index) external view returns (string memory, bool) {
        // storage - 29397 直接从状态变量中拷贝过来
        Todo storage todo = todos[_index];
        // memory - 29480 从状态变量中拷贝到内存
        // Todo memory todo = todos[_index];
        return (todo.text, todo.completed);
    }

    /**
     * 更新是否完成
     * _index: 事项索引
     */
    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }
}