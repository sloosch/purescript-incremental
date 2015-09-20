module Components.TaskList (taskList) where

import Signal.Channel
import Prelude
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Action
import Data.Array
import Store (Task())

taskList :: Channel Action -> Array Task -> IElement
taskList chan tasks =
    ul [class' "task-list"]
        (taskItem chan <$> tasks)

taskItem :: Channel Action -> Task -> IElement
taskItem chan task =
    li [key $ show task.taskId, class' "task-item"] [
        input [type' "checkbox", checked task.completed, onClick $ send chan $ Check task.taskId (not task.completed)] [],
        taskEditableLabel chan task,
        span' [onClick $ send chan $ Delete task.taskId] [text "×"]
    ]

taskEditableLabel :: Channel Action -> Task -> IElement
taskEditableLabel chan task
    | task.editing =
        input [
            type' "text",
            value task.description,
            class' "task-description",
            onInput' $ send chan <<< ChangeDescription task.taskId <<< targetValue,
            onBlur $ send chan $ Edit task.taskId false
        ] []
    | otherwise =
        label [class' "task-label", onDoubleClick $ send chan $ Edit task.taskId true] [text task.description]
