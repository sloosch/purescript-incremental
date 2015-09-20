module Components.TodoList where

import Signal.Channel
import Prelude
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Action
import Store (AppState())
import Data.Array (filter)
import Data.String (contains, length)

import Components.TaskAdder
import Components.TaskList
import Components.TaskListFooter
import Components.TodoFilter

todoList :: Channel Action -> AppState -> IElement
todoList chan state =
    div' [class' "todo-list"] [
        taskAdder chan state.inputVal,
        todoFilter chan state.filter,
        taskList chan filteredTasks,
        taskListFooter chan state
    ]
    where
        filteredTasks
            | length state.filter > 0 = filter (\t -> contains state.filter t.description) state.todos
            | otherwise = state.todos
