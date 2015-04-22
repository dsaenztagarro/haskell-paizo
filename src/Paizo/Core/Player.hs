module Paizo.Core.Player where

import Paizo.Core.Types

isDisabled :: Player -> Bool
isDisabled player = hitPoints player == 0

isDying :: Player -> Bool
isDying player = hitPoints player < 0

