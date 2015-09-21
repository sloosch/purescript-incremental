# purescript-incremental

[incremental-dom](https://github.com/google/incremental-dom) for purescript inspired by [elm-html](https://github.com/evancz/elm-html)

````purescript
taskListFooter :: Channel Action -> AppState -> IElement
taskListFooter chan state = do
    div' [class' "task-list-footer"] do
        button [type' "button", onClick $ send chan DeleteCompleted] $ text "Remove completed"
        div' [class' "task-stats"] do
            span' [class' "total"] $ text $ "Total: " ++ show (length state.todos)
            span' [class' "completed"] $ text $ "Completed: " ++ show (length completedTodos)
    where
        completedTodos = filter (\t -> t.completed) state.todos

````

see [example project](example) to get started.

## Installation

````
bower install purescript-incremental
````

## Usage
do not forget to install incremental-dom via npm before trying to compile your project
````
npm install incremental-dom
````
