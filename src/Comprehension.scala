
/*
lookup :: Eq a => a -> [(a,b)] -> Maybe b
lookup _ [] = Nothing
lookup key ((k,v):kvs) 
  | key == k = Just v
  | otherwise = lookup key kvs

data Acc = Acc { nr :: Int, balance :: Double }

userIdByEmail :: String -> Maybe Int
userIdByEmail email = lookup email users 

accountByUserId :: Int -> Maybe Acc
accountByUserId uid = lookup uid accountKVs 
  where accountKVs = map (\a -> (nr a, a)) accounts

balanceByEmail :: String -> Maybe Double
balanceByEmail email =
  userIdByEmail email >>= (\uid ->
    accountByUserId uid >>= (\acc ->
      return (balance acc)))
*/

object Example {

    case class Acc(nr : Int , balance : Double)

    val users = List(
    ("daniel.kroeni@fhnw.ch", 42),
    ("philipp.hausmann@fhnw.ch", 41))

    val accounts = List(
    Acc(1, 1000000),
    Acc(41, 200000),
    Acc(42, 0))

    def userIdByEmail(email: String) : Option[Int] = {
        users.find(_._1 == email).map(_._2)
    }

    def accountByUserId(userId : Int) : Option[Acc] = {
        accounts.find(_.nr == userId)
    }

    /*
      balanceByEmail :: String -> Maybe Double
      balanceByEmail email =
        userIdByEmail email >>= (\uid ->
          accountByUserId uid >>= (\acc ->
            return (balance acc)))
    */
    def balanceByEmail(email : String) : Option[Double] = {
        // userIdByEmail(email).flatMap(accountByUserId).map(_.balance)
        userIdByEmail(email).flatMap(uid => 
            accountByUserId(uid)).flatMap(acc => 
                Some(acc.balance))
    }

    /*
      balanceByEmail :: String -> Maybe Double
      balanceByEmail email = do
        uid <- userIdByEmail email
        acc <- accountByUserId uid
        return (balance acc)
    */
    def balanceByEmail2(email : String) : Option[Double] = {
        for {
                uid <- userIdByEmail(email)
                acc <- accountByUserId(uid)
        } yield acc.balance
    }

    def main(args : Array[String]) : Unit = {
        println(balanceByEmail("daniel.kroeni@fhnw.ch"));
    }
}

