module Incremental.DOM where

import Prelude (Unit())
import Incremental.Attributes (IAttribute())
import Data.Array
import DOM.Node.Types (Element())
import Control.Monad.Eff (Eff())
foreign import data IElement :: *
foreign import data IDOM :: !

foreign import element :: String -> Array IAttribute -> Array IElement -> IElement
foreign import text :: String -> IElement
foreign import patch :: forall eff. IElement -> Element -> Eff (idom :: IDOM | eff) Unit
