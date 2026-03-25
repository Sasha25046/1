import Data.List (nub)
import System.IO (hFlush, stdout)
import Text.Read (readMaybe)
import Data.Maybe (mapMaybe)
import Control.Monad (unless)

countStatistics :: [Int] -> [(Int, Int)]
countStatistics xs = [(x, count x xs) | x <- nub xs]
  where
    count x list = length (filter (== x) list)

main :: IO ()
main = do
    putStrLn "=== Haskell: Статистика входжень ==="
    putStrLn "(Введіть числа через пробіл, 'q' для виходу)"
    loop
  where
    loop = do
        putStr "\nВвід: "
        hFlush stdout
        input <- getLine
        unless (input `elem` ["q", "exit"]) $ do
            let numbers = mapMaybe readMaybe (words input) :: [Int]
            if null numbers
                then putStrLn "Список порожній або некоректний ввід."
                else print (countStatistics numbers)
            loop