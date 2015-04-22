module CoreTests (tests) where

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.QuickCheck as QC

import Paizo.Core.Types
import Paizo.Core.Player

expectDisabled :: Player -> Bool -> Assertion
expectDisabled player status =
    assertBool "expectDisabled -> LogicError" (isDisabled player == status)

testPlayerDisabled :: Assertion
testPlayerDisabled = expectDisabled Player { hitPoints = 0 } True

testPlayerNotDisabled :: IO ()
testPlayerNotDisabled = do
    expectDisabled Player { hitPoints = 1 } False
    expectDisabled Player { hitPoints = -1 } False

tests :: TestTree
tests = testGroup "Core" [unitTests, properties]

unitTests :: TestTree
unitTests = testGroup "Unit tests"
    [ testCase "Player disabled" testPlayerDisabled
    , testCase "Player not disabled" testPlayerNotDisabled
    ]

instance Arbitrary Player where
    arbitrary = do
      hp <- choose (-3, 3) :: Gen Int
      return Player { hitPoints = hp }

properties :: TestTree
properties = testGroup "Properties (checked by QuickCheck)"
    [ QC.testProperty "isDying != isDisabled" $
      \player -> not $ isDisabled player && isDying player
    ]
