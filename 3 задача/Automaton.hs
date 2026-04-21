import Data.List (find)
import Control.Monad (foldM)

type State = Int
type Symbol = Char
type Transition = ((State, Symbol), State)

data Automaton = Automaton {
    states      :: [State],
    transitions :: [Transition],
    startState  :: State,
    finalStates :: [State]
}

transitionPath :: Automaton -> State -> String -> Maybe State
transitionPath auto s w = foldM step s w
  where
    step currState symbol = lookup (currState, symbol) (transitions auto)

canReachFinal :: Automaton -> State -> Maybe String
canReachFinal auto start = bfs [(start, "")] []
  where
    bfs [] _ = Nothing
    bfs ((curr, path):queue) visited
         curr `elem` finalStates auto = Just (reverse path)
         curr `elem` visited = bfs queue visited
         otherwise = 
            let nextMoves = [(next, sym:path) | ((s, sym), next) <- transitions auto, s == curr]
            in bfs (queue ++ nextMoves) (curr:visited)

findPathToState :: Automaton -> State -> State -> Maybe String
findPathToState auto start target = bfs [(start, "")] []
  where
    bfs [] _ = Nothing
    bfs ((curr, path):queue) visited
          curr == target = Just (reverse path)
          curr `elem` visited = bfs queue visited
          otherwise = 
            let nextMoves = [(next, sym:path) | ((s, sym), next) <- transitions auto, s == curr]
            in bfs (queue ++ nextMoves) (curr:visited)

findAcceptedWord :: Automaton -> String -> Maybe String
findAcceptedWord auto w = 
    let results = [ (s1, s2, pathX) 
                  | s1 <- states auto
                  , let pathX = findPathToState auto (startState auto) s1
                  , pathX /= Nothing
                  , let Just x = pathX
                  , let s2Maybe = transitionPath auto s1 w
                  , s2Maybe /= Nothing
                  , let Just s2 = s2Maybe ]
    in case find (\(_, s2, _) -> canReachFinal auto s2 /= Nothing) results of
        Just (s1, s2, Just x) -> 
            let Just y = canReachFinal auto s2
            in Just (x ++ w ++ y)
        _ -> Nothing

exampleAuto :: Automaton
exampleAuto = Automaton {
    states = [0, 1],
    transitions = [
        ((0, 'a'), 1), 
        ((1, 'a'), 0), 
        ((0, 'b'), 0), 
        ((1, 'b'), 1)
    ],
    startState = 0,
    finalStates = [0]
}

main :: IO ()
main = do
    putStrLn "=== Перевірка автомата ==="
    putStrLn "Введіть слово для перевірки (або 'exit' для виходу):"
    
    loop
  where
    loop = do
        putStr "Input w = "
        input <- getLine
        
        if input == "exit"
            then putStrLn "Бувай!"
            else do
                case findAcceptedWord exampleAuto input of
                    Just result -> putStrLn $ "Знайдено слово xwy: " ++ result
                    Nothing     -> putStrLn $ "Слово " ++ input ++ " неможливе в цьому автоматі."
                putStrLn ""
                loop