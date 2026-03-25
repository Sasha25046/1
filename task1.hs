import System.IO (hFlush, stdout)
import Control.Monad (unless)

moveMinToFront :: [Int] -> [Int]
moveMinToFront [] = []
moveMinToFront xs = mins ++ others
  where
    minVal = minimum xs
    mins   = filter (== minVal) xs
    others = filter (/= minVal) xs

main :: IO ()
main = do
    putStrLn "--- Програма для перестановки мінімумів (Haskell) ---"
    putStrLn "(Для виходу введіть 'q' або порожній рядок)"
    loop
  where
    loop = do
        putStr "\nВведіть числа через пробіл: "
        hFlush stdout
        input <- getLine
        unless (null input || input == "q") $ do
            let numbers = map read (words input) :: [Int]
            print (moveMinToFront numbers)
            loop 