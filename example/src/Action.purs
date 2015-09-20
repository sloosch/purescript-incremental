module Action where

data Action =
    NoOp
    | Add String
    | Delete Int
    | Check Int Boolean
    | ChangedInput String
    | DeleteCompleted
    | Edit Int Boolean
    | ChangeDescription Int String
    | ChangeFilter String
