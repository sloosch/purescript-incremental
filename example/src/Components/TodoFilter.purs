module Components.TodoFilter where

import Prelude
import Incremental.DOM
import Incremental.Elements
import Incremental.Attributes
import Signal.Channel
import Signal
import Action
import Control.Monad.Eff (Eff())

todoFilter :: forall eff. Channel Action -> String -> Eff (idom :: IDOM | eff) DOMElement
todoFilter chan filterStr =
    div' [class' "todo-filter"] do
        input [
            placeholder "Enter filter",
            value filterStr,
            type' "text",
            onInput' $ send chan <<< ChangeFilter <<< targetValue
        ] iempty
