-- List example
import Control.Monad

data User = U { uid :: Int, name :: String } deriving Show
data Account = A { aid :: Int, balance :: Int } deriving Show 

users :: [User]
users = [
    U 1 "Hans",
    U 2 "Petra",
    U 3 "Susi"
  ]

accounts :: [Account]
accounts = [
    A 1 10,
    A 3 200
  ]

test :: [(String, Int)]
test = do
    U uId name <- users
    A aId bal <- accounts
    guard (uId == aId && bal > 100) 
    return (name,bal)


test' :: [(String, Int)]
test' = users >>= \(U uId name) -> 
          accounts >>= (\(A aId bal) -> 
            guard (uId == aId && bal > 100) >> return (name,bal))


test'' :: [(String, Int)]
test'' = concat (map (\(U uId name) -> 
           concat (map (\(A aId bal) -> 
               concat (map (\_ -> [(name, bal)]) 
               (if uId == aId && bal > 100 then [()] else [])))
           accounts)) 
         users)
