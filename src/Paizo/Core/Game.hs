module Game where

import Control.Monad.State

import Paizo.Core.Types

data Game = Game
          { players :: [Player]
          }

data ActionType = Standard
                | Move
                | FullRound
                | Free
                | Swift
                | Immediate

data Action = Action
            { actionType :: ActionType }

type GameState = State Game

playRound :: GameState ()
playRound = do
    game <- get
    put game { players = [Player { hitPoints = 1, consScore = 2 }] }
