module Store (Task(), AppState(), initialAppState, handleAction) where

import Action
import Prelude
import Data.Maybe
import qualified Data.StrMap as SM
import Data.Foldable (foldl)

type Task = {
    taskId :: Int,
    description :: String,
    completed :: Boolean,
    editing :: Boolean
}

type AppState = {
    inputVal :: String,
    todos :: SM.StrMap Task,
    lastUid :: Int,
    filter :: String
}

initialAppState :: AppState
initialAppState =
    {
        inputVal : "",
        todos : SM.empty,
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
                newTodos = SM.insert (show uid) (newTask uid description) state.todos
            in
                state {lastUid = uid, todos = newTodos, inputVal = ""}
        Check uid isCompleted ->
            let changeTodo = \t -> Just $ t {completed = isCompleted}
                newTodos = SM.update changeTodo (show uid) state.todos
            in
                state {todos = newTodos}
        Delete uid ->
            let newTodos = SM.delete (show uid) state.todos
            in
                state {todos = newTodos}
        ChangedInput input ->
            state {inputVal = input}
        DeleteCompleted ->
            let changeTodo = \t -> if t.completed then Nothing else Just t
                newTodos = foldl (flip (SM.update changeTodo)) state.todos (SM.keys state.todos)
            in
                state {todos = newTodos}
        Edit uid isEditing ->
            let changeTodo = \t -> Just $ t {editing = isEditing}
                newTodos = SM.update changeTodo (show uid) state.todos
            in
                state {todos = newTodos}
        ChangeDescription uid description ->
            let changeTodo = \t -> Just $ t {description = description}
                newTodos = SM.update changeTodo (show uid) state.todos
            in
                state {todos = newTodos}
        ChangeFilter filterStr ->
            state {filter = filterStr}
