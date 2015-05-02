module Paizo.Core.Player where

import Paizo.Core.Types

isDisabled :: Player -> Bool
isDisabled player = hitPoints player == 0

isDying :: Player -> Bool
isDying player = hp < 0 && hp > - consScore player
    where hp = hitPoints player

isDead :: Player -> Bool
isDead player = hitPoints player < - consScore player
