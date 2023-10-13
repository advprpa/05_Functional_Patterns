-- Maybe Example

safeDivide :: Double -> Double -> Maybe Double
safeDivide x 0.0 = Nothing
safeDivide x y   = Just (x / y)

safeRoot :: Double -> Maybe Double
safeRoot x | x < 0.0   = Nothing 
           | otherwise = Just (sqrt x)


computeResult :: Double -> Double -> Double -> Maybe Double
computeResult x y z = do 
    divisionResult <- safeDivide x y
    rooted <- safeRoot divisionResult
    Just (rooted * z)

result1, result2, result3 :: Maybe Double
result1 = computeResult 10.0 2.0 3.0  -- Just 6.708203932499369
result2 = computeResult 10.0 0.0 3.0  -- Nothing (due to division by zero)
result3 = computeResult (-10.0) 1.0 3.0 -- None (due to square root of negative number)
