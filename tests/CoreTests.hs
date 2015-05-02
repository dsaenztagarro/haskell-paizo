module CoreTests (tests) where

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.QuickCheck as QC

import Paizo.Core.Types
import Paizo.Core.Player

expectStatus :: (Player -> Bool) -> Player -> Bool -> String -> Assertion
expectStatus fn player status errorMessage =
    assertBool errorMessage (fn player == status)

testPlayerIsAlive :: Assertion
testPlayerIsAlive = expectStatus isAlive player True "player is disabled"
    where player = Player { hitPoints = 10, consScore = 5 }

testPlayerIsDisabled :: Assertion
testPlayerIsDisabled = expectStatus isDisabled player True "player is disabled"
    where player = Player { hitPoints = 0, consScore = 5 }

testPlayerIsDying :: Assertion
testPlayerIsDying = expectStatus isDying player True "player is dying"
    where player = Player { hitPoints = -1, consScore = 5 }

testPlayerIsDead :: Assertion
testPlayerIsDead = expectStatus isDead player True "player is dead"
    where player = Player { hitPoints = -5, consScore = 5 }

tests :: TestTree
tests = testGroup "Core" [unitTests, properties]

unitTests :: TestTree
unitTests = testGroup "Unit tests"
    [ testCase "Player is alive" testPlayerIsAlive
    , testCase "Player is disabled" testPlayerIsDisabled
    , testCase "Player is dying" testPlayerIsDying
    , testCase "Player is dead" testPlayerIsDead
    ]

instance Arbitrary Player where
    arbitrary = do
      hp <- choose (-20, 50) :: Gen Int
      cons <- choose (5, 10) :: Gen Int
      return Player { hitPoints = hp
                    , consScore = cons }

properties :: TestTree
properties = testGroup "Properties (checked by QuickCheck)"
    [ QC.testProperty "isAlive != isDisabled" $
      \player -> not $ isAlive player && isDisabled player
    , QC.testProperty "isAlive != isDying" $
      \player -> not $ isAlive player && isDying player
    , QC.testProperty "isAlive != isDead" $
      \player -> not $ isAlive player && isDead player
    , QC.testProperty "isDisabled != isDying" $
      \player -> not $ isDisabled player && isDying player
    , QC.testProperty "isDisabled != isDead" $
      \player -> not $ isDisabled player && isDead player
    , QC.testProperty "isDying != isDead" $
      \player -> not $ isDying player && isDead player
    ]
