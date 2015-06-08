{-# LANGUAGE DeriveGeneric #-}

module Paizo.Core.Types (
  -- * Player
  Player(..)
  ) where

import Data.Aeson
import GHC.Generics

data Player = Player {
      hitPoints :: Int
    , consScore :: Int
    } deriving (Show, Generic)

-- Instances to convert our type to/from JSON.

instance FromJSON Player
instance ToJSON Player
