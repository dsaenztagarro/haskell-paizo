module Main where

import Control.Monad (when)
import Control.Monad.State
import System.IO (stdin, stdout, hSetEcho, hSetBuffering, BufferMode(..))

data AppConfig = AppConfig
    { crRound :: Int
    } deriving (Show)

type App = StateT AppConfig IO

loadEngine :: App ()
loadEngine = liftIO $ do
  hSetEcho stdin False
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering

printT :: (MonadIO m) => String -> m ()
printT s = liftIO . putStrLn $ s

loadGame :: App ()
loadGame = printT "Loading game"

gameLoop :: App ()
gameLoop = do
    printT "Play round"
    config <- get
    put $ AppConfig { crRound = crRound config + 1 }
    char <- liftIO getChar
    when (char == 'c') gameLoop

main2 :: App ()
main2 = do
    loadEngine
    loadGame
    gameLoop

main :: IO ()
main = do
  putStrLn "hello world"

runApp :: App a -> IO (a, AppConfig)
runApp k =
  let config = AppConfig 0
  in runStateT k config
