module CoreTests (tests) where

import Paizo.Core.Types
import Paizo.Core.Player

import Test.Framework (Test, testGroup)
import Test.Framework.Providers.HUnit (testCase)
import Test.Framework.Providers.QuickCheck2 (testProperty)

import Test.HUnit (Assertion, assertBool)

expectDisabled :: Player -> Bool -> Assertion
expectDisabled player status = do
    assertBool "expectDisabled -> LogicError" (isDisabled player == status)

testPlayerDisabled :: Assertion
testPlayerDisabled = expectDisabled Player { hitPoints = 0 } True

testPlayerNotDisabled :: IO ()
testPlayerNotDisabled = do
    expectDisabled Player { hitPoints = 1 } False
    expectDisabled Player { hitPoints = -1 } False

tests :: Test
tests = testGroup "isDisabled" [
      testCase "testPlayerDisabled" $ testPlayerDisabled
    , testCase "testPlayerNotDisabled" $ testPlayerNotDisabled
    ]
