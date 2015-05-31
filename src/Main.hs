module Main where

import Control.Monad (when)
import Control.Monad.State
import System.IO (stdin, hSetEcho)

data AppConfig = AppConfig
    { crRound :: Int
    } deriving (Show)

type App = StateT AppConfig IO

loadEngine = hSetEcho stdin False

printT :: (MonadIO m) => String -> m ()
printT s = liftIO . putStrLn $ s

loadGame :: App ()
loadGame = printT "Loading game"

playGame :: App ()
playGame = do
    liftIO . putStrLn $ "Play round"
    config <- get
    put $ AppConfig { crRound = crRound config + 1 }
    char <- liftIO getChar
    when (char == 'c') playGame

main2 :: App ()
main2 = do
    loadGame
    playGame

main :: IO ()
main = do
  putStrLn "hello world"

runApp :: App a -> IO (a, AppConfig)
runApp k =
  let config = AppConfig 0
  in runStateT k config
