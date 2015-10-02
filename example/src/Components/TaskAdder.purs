module Components.TaskAdder where

import Signal.Channel
import Prelude
import Control.Monad.Eff (Eff())
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Action

taskAdder :: forall eff. Channel Action -> String -> Eff (idom :: IDOM | eff) DOMElement
taskAdder chan val =
    div' [class' "task-adder"] do
        input [type' "text", value val, onInput' $ send chan <<< ChangedInput <<< targetValue] iempty
        button [type' "button", onClick $ send chan $ Add val] $ text "Add todo"
