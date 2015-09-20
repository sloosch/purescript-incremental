# purescript-incremental

[incremental-dom](https://github.com/google/incremental-dom) for purescript inspired by [elm-html](https://github.com/evancz/elm-html)

````
bower install purescript-incremental
````

````purescript
taskListFooter :: Channel Action -> AppState -> IElement
taskListFooter chan state =
    div' [class' "task-list-footer"] [
        button [type' "button", onClick $ send chan DeleteCompleted] [text "Remove completed"],
        div' [class' "task-stats"] [
            span' [class' "total"] [text $ "Total: " ++ show (length state.todos)],
            span' [class' "completed"] [text $ "Completed: " ++ show (length completedTodos)]
        ]
    ]
    where
        completedTodos = filter (\t -> t.completed) state.todos
````

see [example project](example) to get started.
