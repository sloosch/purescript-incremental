module Components.TaskListFooter where

import Signal.Channel
import Prelude
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Action
import Store (Task())
import Control.Monad.Eff (Eff())
import Data.List (filter, length, List())
import qualified DOM.Node.Element as DOMElement
import DOM.Node.Types (ElementId())
import DOM
import Control.Bind ((>=>))

taskListFooter ::forall eff. Channel Action -> List Task -> Eff (idom :: IDOM, dom :: DOM | eff) DOMElement
taskListFooter chan tasks =
    div' [class' "task-list-footer"] do
        button [type' "button", onClick $ send chan DeleteCompleted] $ text "Remove completed"
        div' [class' "task-stats"] do
            -- an element can be composed with any effects for an element e.g. DOM manipulations
            span' [class' "total"] >=> DOMElement.setClassName "override-with-dom-manipulation" $ text $ "Total: " ++ show (length tasks)
            span' [class' "completed"] $ text $ "Completed: " ++ show (length completedTasks)
    where
        completedTasks = filter (\t -> t.completed) tasks
