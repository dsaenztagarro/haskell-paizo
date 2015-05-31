module Paizo.Core.Types (
  -- * Player
  Player(..)
  ) where

data Player = Player {
      hitPoints :: Int
    , consScore :: Int
    } deriving (Show)
