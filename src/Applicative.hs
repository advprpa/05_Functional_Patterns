
e1, e2 :: Maybe Integer
e1 = pure (+) <*> Just 1 <*> Just 2
e2 = pure (+) <*> Nothing <*> Just 2

data Person = MkPerson { name :: String, yob :: Int } deriving Show

e3 :: Maybe Person
e3 = pure MkPerson <*> Just "Hans" <*> Just 1970

e4 :: [Integer]
e4 = pure (+) <*> [1,2] <*> [3,4]

e5 :: IO String
e5 = pure (++) <*> getLine <*> getLine

e6 :: IO Person
e6 = pure MkPerson <*> getLine <*> (fmap read getLine)

e7, e8 :: Either String Integer
e7 = pure (+) <*> Right 1 <*> Right 2
e8 = pure (+) <*> Left "No good" <*> Right 2


