

import Text.Read (readMaybe) -- Для безпечного зчитування з термінала
import Control.Monad (ap)

nConst :: Double
nConst = 1.0

lg :: Double -> Double
lg x = logBase 10 x


-- f4 = 1 / sqrt(x + n)
f4 :: Double -> Maybe Double
f4 x | (x + nConst) > 0 = Just (1 / sqrt (x + nConst))
     | otherwise        = Nothing

-- f2 = 1 / (nx + lg x)
f2 :: Double -> Maybe Double
f2 x | x > 0 && (nConst * x + lg x) /= 0 = Just (1 / (nConst * x + lg x))
     | otherwise                         = Nothing

-- f1 = 1 / sqrt(n + lg x)
f1 :: Double -> Maybe Double
f1 x | x > 0 && (nConst + lg x) > 0 = Just (1 / sqrt (nConst + lg x))
     | otherwise                    = Nothing


compositeDo :: Double -> Maybe Double
compositeDo x = do
    res1 <- f1 x    
    res2 <- f2 res1 
    f4 res2         

compositeBind :: Double -> Maybe Double
compositeBind x = f1 x >>= f2 >>= f4


vFunc :: Double -> Double -> Maybe Double
vFunc x n | x > 0 && (n + lg x) > 0 = Just (1 / sqrt (n + lg x))
          | otherwise               = Nothing


complexCompositeDo :: Double -> Maybe Double
complexCompositeDo x = do
    arg1 <- f4 x
    arg2 <- f2 x
    vFunc arg1 arg2


complexCompositeBind :: Double -> Maybe Double
complexCompositeBind x = 
    f4 x >>= \arg1 ->
    f2 x >>= \arg2 ->
    vFunc arg1 arg2

main :: IO ()
main = do
    putStrLn "=== Програма обчислення Maybe-функцій ==="
    putStrLn $ "Мій варіант: (4, 2, 1), n = " ++ show nConst
    putStr "Введіть число x для розрахунку: "
    
    input <- getLine
    let xMaybe = readMaybe input :: Maybe Double
    
    case xMaybe of
        Nothing -> putStrLn "Помилка: введено некоректне число!"
        Just xValue -> do
            putStrLn "------------------------------------------"
            putStrLn $ "Результати для x = " ++ show xValue
            
            putStrLn "\n2) Суперпозиція f4(f2(f1(x))):"
            putStr "   do-нотація: " >> print (compositeDo xValue)
            putStr "   bind (>>=):  " >> print (compositeBind xValue)
            
            putStrLn "\n4) Суперпозиція v(f4(x), f2(x)):"
            putStr "   do-нотація: " >> print (complexCompositeDo xValue)
            putStr "   bind (>>=):  " >> print (complexCompositeBind xValue)
            putStrLn "------------------------------------------"