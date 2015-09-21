module Components.TaskListFooter where

import Signal.Channel
import Prelude
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Action
import Store (AppState())
import Data.Array (filter, length)

taskListFooter :: Channel Action -> AppState -> IElement
taskListFooter chan state = do
    div' [class' "task-list-footer"] do
        button [type' "button", onClick $ send chan DeleteCompleted] $ text "Remove completed"
        div' [class' "task-stats"] do
            span' [class' "total"] $ text $ "Total: " ++ show (length state.todos)
            span' [class' "completed"] $ text $ "Completed: " ++ show (length completedTodos)
    where
        completedTodos = filter (\t -> t.completed) state.todos
