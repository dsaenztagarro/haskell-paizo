module CoreTests (tests) where

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.QuickCheck as QC

import Paizo.Core.Types
import Paizo.Core.Player

expectStatus :: (Player -> Bool) -> Player -> Bool -> String -> Assertion
expectStatus fn player status errorMessage =
    assertBool errorMessage (fn player == status)

testPlayerDisabled :: Assertion
testPlayerDisabled = expectStatus isDisabled player True "player is disabled"
    where player = Player { hitPoints = 0, consScore = 5 }

testPlayerNotDisabled :: IO ()
testPlayerNotDisabled = do
    expectStatus isDisabled alivePlayer False "alive player isn't disabled"
    expectStatus isDisabled dyingPlayer False "dying player isn't disabled"
    where alivePlayer = Player { hitPoints = 10, consScore = 5 }
          dyingPlayer = Player { hitPoints = -1, consScore = 5 }

tests :: TestTree
tests = testGroup "Core" [unitTests, properties]

unitTests :: TestTree
unitTests = testGroup "Unit tests"
    [ testCase "Player disabled" testPlayerDisabled
    , testCase "Player not disabled" testPlayerNotDisabled
    ]

instance Arbitrary Player where
    arbitrary = do
      hp <- choose (-20, 50) :: Gen Int
      cons <- choose (5, 10) :: Gen Int
      return Player { hitPoints = hp
                    , consScore = cons }

properties :: TestTree
properties = testGroup "Properties (checked by QuickCheck)"
    [ QC.testProperty "isDying != isDisabled" $
      \player -> not $ isDisabled player && isDying player
    ]
