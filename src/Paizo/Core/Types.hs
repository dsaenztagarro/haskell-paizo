module Paizo.Core.Types (
  -- * Player
  Player(..)

  ) where

data Player = Player
    { hitPoints :: Int
    } deriving (Show)
