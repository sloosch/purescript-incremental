module Store (Task(), AppState(), initialAppState, handleAction) where

import Action
import Prelude
import Data.Array

type Task = {
    taskId :: Int,
    description :: String,
    completed :: Boolean,
    editing :: Boolean
}

type AppState = {
    inputVal :: String,
    todos :: Array Task,
    lastUid :: Int,
    filter :: String
}

initialAppState :: AppState
initialAppState =
    {
        inputVal : "",
        todos : [],
        lastUid : 0,
        filter : ""
    }

newTask :: Int -> String -> Task
newTask taskId description =
    {
        taskId : taskId,
        description : description,
        completed: false,
        editing : false
    }


handleAction :: Action -> AppState -> AppState
handleAction action state =
    case action of
        NoOp ->
            state
        Add description ->
            let uid = state.lastUid + 1
                newTodos = (newTask uid description) : state.todos
            in
                state {lastUid = uid, todos = newTodos, inputVal = ""}
        Check uid isCompleted ->
            let changeTodo = \t -> if t.taskId == uid then t {completed = isCompleted} else t
                newTodos = changeTodo <$> state.todos
            in
                state {todos = newTodos}
        Delete uid ->
            let newTodos = filter (\t -> t.taskId /= uid) state.todos
            in
                state {todos = newTodos}
        ChangedInput input ->
            state {inputVal = input}
        DeleteCompleted ->
            let newTodos = filter (\t -> not t.completed) state.todos
            in
                state {todos = newTodos}
        Edit uid isEditing ->
            let changeTodo = \t -> if t.taskId == uid then t {editing = isEditing} else t
                newTodos = changeTodo <$> state.todos
            in
                state {todos = newTodos}
        ChangeDescription uid description ->
            let changeTodo = \t -> if t.taskId == uid then t {description = description} else t
                newTodos = changeTodo <$> state.todos
            in
                state {todos = newTodos}
        ChangeFilter filterStr ->
            state {filter = filterStr}
