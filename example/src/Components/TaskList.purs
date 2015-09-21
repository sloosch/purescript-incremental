module Components.TaskList (taskList) where

import Signal.Channel
import Prelude
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Action
import Data.Array
import Store (Task())
import Data.Foldable

taskList :: Channel Action -> Array Task -> IElement
taskList chan tasks = do
    ul [class' "task-list"] $ for_ tasks $ taskItem chan

taskItem :: Channel Action -> Task -> IElement
taskItem chan task = do
    li [key $ show task.taskId, class' "task-item"] do
        input [type' "checkbox", checked task.completed, onClick $ send chan $ Check task.taskId (not task.completed)] iempty
        taskEditableLabel chan task
        span' [onClick $ send chan $ Delete task.taskId] $ text "×"

taskEditableLabel :: Channel Action -> Task -> IElement
taskEditableLabel chan task
    | task.editing = do
        input [
            type' "text",
            value task.description,
            class' "task-description",
            onInput' $ send chan <<< ChangeDescription task.taskId <<< targetValue,
            onBlur $ send chan $ Edit task.taskId false
        ] iempty
    | otherwise = do
        label [class' "task-label", onDoubleClick $ send chan $ Edit task.taskId true] $ text task.description
