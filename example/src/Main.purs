module Main where

import Prelude
import Control.Monad.Eff (Eff())
import Incremental.DOM (patch, IDOM())
import DOM.Node.Types (Element())
import DOM.HTML.Types (htmlElementToElement)
import DOM (DOM())
import Signal (Signal(), foldp, runSignal, (~>))
import Signal.Channel (Channel(), channel, Chan(), subscribe)
import Action
import Store

import Components.TodoList

body :: forall eff. Eff (dom :: DOM | eff) Element
body =
    htmlElementToElement
    <$> Data.Maybe.Unsafe.fromJust
    <$> Data.Nullable.toMaybe
    <$> (DOM.HTML.window >>= DOM.HTML.Window.document >>= DOM.HTML.Document.body)

renderAction :: forall eff. Channel Action -> Signal Action -> Eff (dom :: DOM, idom :: IDOM | eff) Unit
renderAction chan action =
     runSignal $ foldp handleAction initialAppState action ~> todoList chan ~> patch ~> bind body

main :: forall eff. Eff (dom :: DOM, idom :: IDOM, chan :: Chan | eff) Unit
main =
    do
        c <- channel NoOp
        renderAction c $ subscribe c
