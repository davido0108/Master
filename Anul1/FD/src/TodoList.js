import React, { useState } from 'react';

function TodoList() {
  const [todos, setTodos] = useState([]);

  const handleAddTodo = (e) => {
    e.preventDefault();
    const todoText = e.target.elements.todoText.value;
    if (todoText.trim() !== '') {
      const newTodo = {
        id: new Date().getTime(),
        text: todoText,
        completed: false,
      };
      setTodos([...todos, newTodo]);
      e.target.reset();
    }
  };

  const handleTodoCompletion = (todoId) => {
    const updatedTodos = todos.map((todo) => {
      if (todo.id === todoId) {
        return {
          ...todo,
          completed: !todo.completed,
        };
      }
      return todo;
    });
    setTodos(updatedTodos);
  };

  return (
    <div>
      <h1>Todo List</h1>
      <ul>
        {todos.map((todo) => (
          <li key={todo.id}>
            <input
              type="checkbox"
              checked={todo.completed}
              onChange={() => handleTodoCompletion(todo.id)}
            />
            <span className={todo.completed ? 'completed' : ''}>
              {todo.text}
            </span>
          </li>
        ))}
      </ul>
      <form onSubmit={handleAddTodo}>
        <input type="text" name="todoText" placeholder="Add a todo" />
        <button type="submit">Add</button>
      </form>
    </div>
  );
}

export default TodoList;