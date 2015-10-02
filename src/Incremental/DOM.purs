module Incremental.DOM where

import Prelude (Unit(), unit, return)
import Incremental.Attributes (IAttribute())
import Data.Array
import Control.Monad.Eff (Eff())
import qualified DOM.Node.Types as DT
import qualified DOM as D
foreign import data IDOM :: !

type DOMElement = DT.Element
type DOMText = DT.Text

foreign import element :: forall a eff. String -> Array IAttribute -> Eff (idom :: IDOM | eff) a -> Eff (idom :: IDOM | eff) DOMElement
foreign import text :: forall eff. String -> Eff (idom :: IDOM | eff) DOMText
foreign import patch :: forall eff. Eff (idom :: IDOM | eff) DOMElement -> DOMElement -> Eff (idom :: IDOM | eff) Unit

iempty :: forall eff. Eff (idom :: IDOM | eff) Unit
iempty =
    return unit
