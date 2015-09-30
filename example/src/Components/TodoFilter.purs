module Components.TodoFilter where

import Prelude
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Signal.Channel
import Signal
import Action

todoFilter :: Channel Action -> String -> IElement
todoFilter chan filterStr =
    div' [class' "todo-filter"] do
        input [
            placeholder "Enter filter",
            value filterStr,
            type' "text",
            onInput' $ send chan <<< ChangeFilter <<< targetValue
        ] iempty
