module Components.TaskList (taskList) where

import Signal.Channel
import Prelude
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Action
import Control.Monad.Eff (Eff())
import Data.List (List())
import Store (Task())
import Data.Foldable (traverse_)

taskList ::forall eff. Channel Action -> List Task -> Eff (idom :: IDOM | eff) DOMElement
taskList chan tasks =
    ul [class' "task-list"] $ traverse_ (taskItem chan) tasks

taskItem ::forall eff. Channel Action -> Task -> Eff (idom :: IDOM | eff) DOMElement
taskItem chan task =
    li [key $ show task.taskId, class' "task-item"] do
        input [type' "checkbox", checked task.completed, onClick $ send chan $ Check task.taskId (not task.completed)] iempty
        taskEditableLabel chan task
        span' [onClick $ send chan $ Delete task.taskId] $ text "×"

taskEditableLabel ::forall eff. Channel Action -> Task -> Eff (idom :: IDOM | eff) DOMElement
taskEditableLabel chan task
    | task.editing =
        input [
            type' "text",
            value task.description,
            class' "task-description",
            onInput' $ send chan <<< ChangeDescription task.taskId <<< targetValue,
            onBlur $ send chan $ Edit task.taskId false
        ] iempty
    | otherwise =
        label [class' "task-label", onDoubleClick $ send chan $ Edit task.taskId true] $ text task.description
