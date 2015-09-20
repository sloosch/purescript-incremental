module Components.TaskAdder where

import Signal.Channel
import Prelude
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Action

taskAdder :: Channel Action -> String -> IElement
taskAdder chan val =
    div' [class' "task-adder"] [
        input [type' "text", value val, onInput' $ send chan <<< ChangedInput <<< targetValue] [],
        button [type' "button", onClick $ send chan $ Add val] [text "Add todo"]
    ]
