module Paizo.Core.Types (
  -- * Player
  Player(..)

  ) where

data Player = Player
    { hitPoints :: Int -- hit points
    , consScore :: Int -- constitution score
    } deriving (Show)
