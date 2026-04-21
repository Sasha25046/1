import Data.List (nub)
import System.IO (hFlush, stdout)


data Symbol = NT String | T String deriving (Eq, Show)
type Rule = (String, [Symbol])

myGrammar :: [Rule]
myGrammar = 
    [ ("S", [T "a", NT "S"])
    , ("S", [T "b", NT "A"])
    , ("A", [NT "S", NT "A"])
    , ("B", [T "xyz"])
    ]
   

getRightmostNT :: Rule -> Maybe String
getRightmostNT (_, []) = Nothing
getRightmostNT (_, rhs) = case last rhs of
    NT name -> Just name
    _       -> Nothing

isRecursive :: String -> [Rule] -> Bool
isRecursive startNT grammar = go startNT []
  where
    go current visited
        | current == startNT && not (null visited) = True
        | current `elem` visited = False
        | otherwise = 
            let nexts = [n | (lhs, rhs) <- grammar, lhs == current, Just n <- [getRightmostNT (lhs, rhs)]]
            in any (\n -> go n (current : visited)) nexts

solve :: [String]
solve = filter (\nt -> isRecursive nt myGrammar) $ nub [lhs | (lhs, _) <- myGrammar]


main :: IO ()
main = do
    putStrLn "\n=== Аналізатор граматики (Haskell) ==="
    putStrLn "Введіть 'check' для аналізу або 'exit' для виходу:"
    loop

loop :: IO ()
loop = do
    putStr "\ncommand > "
    hFlush stdout
    input <- getLine
    case input of
        "exit" -> putStrLn "Бувай!"
        "check" -> do
            let results = solve
            if null results 
                then putStrLn "Праворекурсивних нетерміналів не знайдено."
                else putStrLn $ "Результат: " ++ show results
            loop
        _ -> do
            putStrLn "Невідома команда. Доступні: check, exit"
            loop