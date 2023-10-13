import Prelude hiding (Maybe(..), lookup)

-- Maybe Example
data Maybe a = Nothing | Just a deriving (Show, Eq)

data Account = MkAccount { userId :: Int, balance :: Double }

users :: [(String, Int)]
users = [
  ("daniel.kroeni@fhnw.ch", 42),
  ("hans@noaccou.nt", 43)]

accounts :: [Account]
accounts = [
 MkAccount 1 5,
 MkAccount 41 20,
 MkAccount 42 0]

lookup :: Eq a => a -> [(a,b)] -> Maybe b
lookup _ [] = Nothing
lookup key ((k,v):kvs) 
  | key == k = Just v
  | otherwise = lookup key kvs


userIdByEmail :: String -> Maybe Int
userIdByEmail email = lookup email users 


accountByUserId :: Int -> Maybe Account
accountByUserId uid = lookup uid accountKVs 
  where accountKVs = map (\a -> (userId a, a)) accounts


balanceByEmail''' :: String -> Maybe Double
balanceByEmail''' email = case userIdByEmail email of
    Nothing  -> Nothing
    Just uid -> case accountByUserId uid of
        Nothing -> Nothing
        Just acc -> Just (balance acc)


bindM :: Maybe a -> (a -> Maybe b) -> Maybe b 
bindM Nothing _ = Nothing
bindM (Just a) f = f a


balanceByEmail'' :: String -> Maybe Double
balanceByEmail'' email =
    userIdByEmail email `bindM` (\uid ->
         accountByUserId uid `bindM` (\acc ->
             Just (balance acc)))


-- Functor, Applicative, Monad
instance Functor Maybe where
    fmap :: (a -> b) -> Maybe a -> Maybe b
    fmap _ Nothing = Nothing
    fmap f (Just a) = Just (f a)

instance Applicative Maybe where
    pure :: a -> Maybe a
    pure a = Just a
    
    (<*>) :: Maybe (a -> b) -> Maybe a -> Maybe b
    Just f <*> Just a = Just (f a)
    _ <*> _ = Nothing

instance Monad Maybe where
  (>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
  Nothing >>= _ = Nothing
  Just a >>= f  = f a


balanceByEmail' :: String -> Maybe Double
balanceByEmail' email =
  userIdByEmail email >>= (\uid ->
    accountByUserId uid >>= (\acc ->
      return (balance acc)))


balanceByEmail :: String -> Maybe Double
balanceByEmail email = do
  uid <- userIdByEmail email 
  acc <- accountByUserId uid
  return (balance acc)


main :: IO ()
main = print $ balanceByEmail "daniel.kroeni@fhnw.ch"