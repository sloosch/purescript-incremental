module Incremental.Attributes (
    class', type', key, value, checked, disabled, id', name, href, src, placeholder, width, height, target, IAttribute(),
    accept, autocomplete, autofocus, max, min, maxlength, minlength, pattern, readonly, required, multiple, tabindex, size,
    title, contenteditable, accesskey, draggable, dropzone,
    on', on,
    onClick, onClick',
    onDoubleClick', onDoubleClick,
    onInput', onInput,
    onBlur', onBlur,
    onFocus', onFocus,
    onFocusIn', onFocusIn,
    onFocusOut', onFocusOut,
    onChange', onChange,
    onInvalid',onInvalid,
    onReset',onReset,
    onSearch',onSearch,
    onSelect',onSelect,
    onSubmit',onSubmit,
    onMouseEnter',onMouseEnter,
    onMouseLeave',onMouseLeave,
    onMouseMove',onMouseMove,
    onMouseDown',onMouseDown,
    onMouseUp',onMouseUp,
    onMouseOver',onMouseOver,
    onMouseOut',onMouseOut,
    onDrag',onDrag,
    onDragEnd', onDragEnd,
    onDragEnter',onDragEnter,
    onDragLeave',onDragLeave,
    onDragOver',onDragOver,
    onDragStart',onDragStart,
    onDrop',onDrop,
    onKeyDown',onKeyDown,
    onKeyUp',onKeyUp,
    IEventData(),
    targetValue, mousePosition, MousePosition(..), keyValue
    ) where

import Prelude
import Data.Maybe
import qualified Unsafe.Coerce as U
import Control.Monad.Eff (Eff())
foreign import data IAttributeValue :: *
foreign import data IEventData :: *

data IAttribute = IAttribute {
    name :: String,
    value :: IAttributeValue,
    static :: Boolean
}

data MousePosition = MousePosition {
    clientX :: Int,
    clientY :: Int,
    screenX :: Int,
    screenY :: Int
}

toAttributeValue :: forall a. a -> IAttributeValue
toAttributeValue =
    U.unsafeCoerce

stringAttribute :: String -> Boolean -> String -> IAttribute
stringAttribute name static value =
    IAttribute {name: name, value: toAttributeValue value, static: static}

eventAttribute :: forall eff a. String -> (IEventData -> Eff eff a) -> IAttribute
eventAttribute name handler =
    IAttribute {name : name, value : toAttributeValue handler, static : false}

volatileAttribute :: String -> Boolean -> IAttribute
volatileAttribute name visible =
    stringAttribute name false (if visible then name else "__UNSET__")


class' :: String -> IAttribute
class' =
    stringAttribute "class" false

type' :: String -> IAttribute
type' =
    stringAttribute "type" true

value :: String -> IAttribute
value =
    stringAttribute "value" false

key :: String -> IAttribute
key =
    stringAttribute "key" false

id' :: String -> IAttribute
id' =
    stringAttribute "id" true

name :: String -> IAttribute
name =
    stringAttribute "name" true

href :: String -> IAttribute
href =
    stringAttribute "href" false

src :: String -> IAttribute
src =
    stringAttribute "src" false

placeholder :: String -> IAttribute
placeholder =
    stringAttribute "placeholder" false

target :: String -> IAttribute
target =
    stringAttribute "target" true

width :: String -> IAttribute
width =
    stringAttribute "width" false

height :: String -> IAttribute
height =
    stringAttribute "height" false

for :: String -> IAttribute
for =
    stringAttribute "for" true

accept :: String -> IAttribute
accept =
    stringAttribute "accept" true

autocomplete :: String -> IAttribute
autocomplete =
    stringAttribute "autocomplete" true
max :: String -> IAttribute
max =
    stringAttribute "max" true
min :: String -> IAttribute
min =
    stringAttribute "min" true

maxlength :: Int -> IAttribute
maxlength =
    stringAttribute "maxlength" true <<< show

minlength :: Int -> IAttribute
minlength =
    stringAttribute "minlength" true <<< show

pattern :: String -> IAttribute
pattern =
    stringAttribute "pattern" true

readonly :: Boolean -> IAttribute
readonly = volatileAttribute "readonly"

required :: Boolean -> IAttribute
required = volatileAttribute "required"

autofocus :: Boolean -> IAttribute
autofocus = stringAttribute "autofocus" true <<< show

multiple :: Boolean -> IAttribute
multiple = stringAttribute "multiple" true <<< show

size :: Int -> IAttribute
size = stringAttribute "size" true <<< show

tabindex :: Int -> IAttribute
tabindex = stringAttribute "tabindex" true <<< show

title :: String -> IAttribute
title = stringAttribute "title" false

contenteditable :: Boolean -> IAttribute
contenteditable = stringAttribute "contenteditable" true <<< show

accesskey :: String -> IAttribute
accesskey = stringAttribute "accesskey" true

draggable :: Boolean -> IAttribute
draggable = stringAttribute "accesskey" true <<< show

dropzone :: String -> IAttribute
dropzone = stringAttribute "dropzone" true

checked :: Boolean -> IAttribute
checked = volatileAttribute "checked"

disabled :: Boolean -> IAttribute
disabled = volatileAttribute "disabled"

on' :: forall eff a. String -> (IEventData -> Eff eff a) -> IAttribute
on' = eventAttribute

on :: forall eff a. String -> Eff eff a -> IAttribute
on eventName effect = on' eventName \_ -> effect


foreign import objPropAccessorImpl :: forall a b. (a -> Maybe a) -> Maybe a -> String -> a -> Maybe b

unsafeObjPropAccessor :: forall a b. String -> a -> Maybe b
unsafeObjPropAccessor = objPropAccessorImpl Just Nothing

orDefault :: forall a. a -> Maybe a -> a
orDefault defaultVal ma =
    case ma of
        Just k -> k
        Nothing -> defaultVal

targetValue :: IEventData -> String
targetValue event =
    orDefault "" $ do
        target <- unsafeObjPropAccessor "target" event
        unsafeObjPropAccessor "value" target

mousePosition :: IEventData -> MousePosition
mousePosition event =
    orDefault (MousePosition {clientX : 0, clientY : 0, screenX : 0, screenY : 0}) $ do
        clientX <- unsafeObjPropAccessor "clientX" event
        clientY <- unsafeObjPropAccessor "clientY" event
        screenX <- unsafeObjPropAccessor "screenX" event
        screenY <- unsafeObjPropAccessor "screenY" event
        return $ MousePosition {clientX : clientX, clientY : clientY, screenX : screenX, screenY : screenY}


keyValue :: IEventData -> String
keyValue = orDefault "" <<< unsafeObjPropAccessor "key"

onClick' =
    on' "onclick"
onClick =
    on "onclick"

onDoubleClick' =
    on' "ondblclick"
onDoubleClick =
    on "ondblclick"

onInput' =
    on' "oninput"
onInput =
    on "oninput"

onBlur' =
    on' "onblur"
onBlur =
    on "onblur"

onFocus' =
    on' "onfocus"
onFocus =
    on "onfocus"

onFocusIn' =
    on' "onfocusin"
onFocusIn =
    on "onfocusin"

onFocusOut' =
    on' "onfocusout"
onFocusOut =
    on "onfocusout"

onChange' =
    on' "onchange"
onChange =
    on "onchange"

onInvalid' =
    on' "oninvalid"
onInvalid =
    on "oninvalid"

onReset' =
    on' "onreset"
onReset =
    on "onreset"

onSearch' =
    on' "onsearch"
onSearch =
    on "onsearch"

onSelect' =
    on' "onselect"
onSelect =
    on "onselect"

onSubmit' =
    on' "onsubmit"
onSubmit =
    on "onsubmit"

onMouseEnter' =
    on' "onmouseenter"
onMouseEnter =
    on "onmouseenter"

onMouseLeave' =
    on' "onmouseleave"
onMouseLeave =
    on "onmouseleave"

onMouseMove' =
    on' "onmousemove"
onMouseMove =
    on "onmousemove"

onMouseDown' =
    on' "onmousedown"
onMouseDown =
    on "onmousedown"

onMouseUp' =
    on' "onmouseup"
onMouseUp =
    on "onmouseup"

onMouseOver' =
    on' "onmouseover"
onMouseOver =
    on "onmouseover"

onMouseOut' =
    on' "onmouseout"
onMouseOut =
    on "onmouseout"

onDrag' =
    on' "ondrag"
onDrag =
    on "ondrag"

onDragEnd' =
    on' "ondragend"
onDragEnd =
    on "ondragend"

onDragEnter' =
    on' "ondragenter"
onDragEnter =
    on "ondragenter"

onDragLeave' =
    on' "ondragleave"
onDragLeave =
    on "ondragleave"

onDragOver' =
    on' "ondragover"
onDragOver =
    on "ondragover"

onDragStart' =
    on' "ondragstart"
onDragStart =
    on "ondragstart"

onDrop' =
    on' "ondrop"
onDrop =
    on "ondrop"

onKeyDown' =
    on' "onkeydown"
onKeyDown =
    on "onkeydown"

onKeyUp' =
    on' "onkeyup"
onKeyUp =
    on "onkeyup"
