module Main where

import Paizo.Core.Types (Player(..))
import Paizo.Plugin.FileLoader (getPlayers)

import Control.Monad (when)
import Control.Monad.State
import Data.Text (unpack)
import System.IO (stdin, stdout, hSetEcho, hSetBuffering, BufferMode(..))

data AppConfig =
    AppConfig { players :: [Player]
              , crRound :: Int
              } deriving (Show)

type App = StateT AppConfig IO

initGUI :: App ()
initGUI = liftIO $ do
    hSetEcho stdin False
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering

printT :: (MonadIO m) => String -> m ()
printT s = liftIO . putStrLn $ s

loadGame :: App ()
loadGame = do
    printT "Loading game"
    players <- liftIO getPlayers
    put AppConfig { players = players, crRound = 0 }

playersLoop :: App ()
playersLoop = do
    config <- get
    forM (players config) $ \player -> do
        printT $ "Player " ++ (unpack $ name player)
        char <- liftIO getChar
        return ()
    return ()

gameLoop :: App ()
gameLoop = do
    config <- get
    printT $ "Round " ++ show (crRound config)
    playersLoop
    put $ AppConfig { players = players config, crRound = crRound config + 1 }
    char <- liftIO getChar
    when (char == 'c') gameLoop

main2 :: App ()
main2 = initGUI >> loadGame >> gameLoop

--main :: IO ()
main = runApp main2

runApp :: App a -> IO (a, AppConfig)
runApp k =
  let config = AppConfig [] 0
  in runStateT k config
