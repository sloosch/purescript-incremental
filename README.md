# purescript-incremental

[incremental-dom](https://github.com/google/incremental-dom) for purescript inspired by [elm-html](https://github.com/evancz/elm-html)

````purescript
taskListFooter ::forall eff. Channel Action -> List Task -> Eff (idom :: IDOM, dom :: DOM | eff) DOMElement
taskListFooter chan tasks =
    div' [class' "task-list-footer"] do
        button [type' "button", onClick $ send chan DeleteCompleted] $ text "Remove completed"
        div' [class' "task-stats"] do
            -- an element can be composed with any effect for an element e.g. DOM manipulations
            span' [class' "total"] >=> E.setClassName "override-class" $ text $ "Total: " ++ show (length tasks)
            span' [class' "completed"] $ text $ "Completed: " ++ show (length completedTasks)
    where
        completedTasks = filter (\t -> t.completed) tasks
````
[full source code](example/src/Components/TaskListFooter.purs)


see [example project](example) to get started.

## Installation

````
bower install purescript-incremental
````

Do not forget to install incremental-dom via npm before trying to compile your project
````
npm install incremental-dom
````
