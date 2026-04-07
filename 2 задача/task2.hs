import System.IO (hFlush, stdout)
import Text.Read (readMaybe)
import Data.Maybe (mapMaybe)
import Control.Monad (unless)

splitFromEnd :: [Int] -> [[Int]]
splitFromEnd xs = reverse (go (reverse xs) 1)
  where
    go [] _ = []
    go list n = 
        let (part, rest) = splitAt n list
        in reverse part : go rest (n + 1)

main :: IO ()
main = do
    putStrLn "=== Задача 2: Розбиття з кінця (Haskell) ==="
    loop
  where
    loop = do
        putStr "\nВвід (числа через пробіл): "
        hFlush stdout
        input <- getLine
        unless (input `elem` ["q", "exit", "stop"]) $ do
            let numbers = mapMaybe readMaybe (words input) :: [Int]
            if null numbers
                then putStrLn "Список порожній."
                else print (splitFromEnd numbers)
            loop