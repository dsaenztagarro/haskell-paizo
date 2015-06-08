module Paizo.Plugin.FileLoader (
  -- * Functions
  getPlayers
  ) where

import Paizo.Core.Types (Player)

import Control.Monad.IO.Class (liftIO)
import Data.Aeson (eitherDecode)
import qualified Data.ByteString.Lazy as B

-- | Location of the players file
jsonFile :: FilePath
jsonFile = "players.json"

-- | Read the local copy of the JSON file.
getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile

-- | Returns the list of players from JSON file
getPlayers :: IO [Player]
getPlayers = do
    d <- (eitherDecode <$> getJSON) :: IO (Either String [Player])
    case d of
        Left err -> return []
        Right players -> return players
