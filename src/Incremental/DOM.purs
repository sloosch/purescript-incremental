module Incremental.DOM where

import Prelude (Unit())
import Incremental.Attributes (IAttribute())
import Data.Array
import DOM.Node.Types (Element())
import Control.Monad.Eff (Eff())
foreign import data IELEMENT :: !
foreign import data IDOM :: !

type IElement = Eff (ielement :: IELEMENT) Unit

foreign import element :: String -> Array IAttribute -> IElement -> IElement
foreign import iempty :: IElement
foreign import text :: String -> IElement
foreign import patch :: forall eff. IElement -> Element -> Eff (idom :: IDOM | eff) Unit
