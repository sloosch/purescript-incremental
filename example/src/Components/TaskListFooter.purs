module Components.TaskListFooter where

import Signal.Channel
import Prelude
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Action
import Store (Task())
import Data.List (filter, length, List())

taskListFooter :: Channel Action -> List Task -> IElement
taskListFooter chan tasks =
    div' [class' "task-list-footer"] do
        button [type' "button", onClick $ send chan DeleteCompleted] $ text "Remove completed"
        div' [class' "task-stats"] do
            span' [class' "total"] $ text $ "Total: " ++ show (length tasks)
            span' [class' "completed"] $ text $ "Completed: " ++ show (length completedTasks)
    where
        completedTasks = filter (\t -> t.completed) tasks
