module Components.TodoList where

import Signal.Channel
import Prelude
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Action
import Store (AppState())
import Data.List (filter)
import qualified Data.StrMap as SM
import Data.String (contains, length)
import Control.Monad.Eff (Eff())
import DOM

import Components.TaskAdder
import Components.TaskList
import Components.TaskListFooter
import Components.TodoFilter

todoList :: forall eff. Channel Action -> AppState ->  Eff (idom :: IDOM, dom :: DOM | eff) DOMElement
todoList chan state =
    div' [class' "todo-list"] do
        taskAdder chan state.inputVal
        todoFilter chan state.filter
        taskList chan filteredTasks
        taskListFooter chan tasksAsList
    where
        tasksAsList = SM.values state.todos
        filteredTasks
            | length state.filter > 0 = filter (\t -> contains state.filter t.description) tasksAsList
            | otherwise = tasksAsList
