module Incremental.DOM where

import Prelude (Unit(), unit, return)
import Incremental.Attributes (IAttribute())
import Data.Array
import DOM.Node.Types (Element())
import Control.Monad.Eff (Eff())
foreign import data IDOM :: !

type IElement = Eff (idom :: IDOM) Unit

foreign import element :: String -> Array IAttribute -> IElement -> IElement
foreign import text :: String -> IElement
foreign import patch :: forall eff. IElement -> Element -> Eff (idom :: IDOM | eff) Unit

iempty :: IElement
iempty =
    return unit
