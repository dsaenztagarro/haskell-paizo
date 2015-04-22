module CoreTests (tests) where

import Paizo.Core.Types
import Paizo.Core.Player

import Test.HUnit

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
tests = TestList
    [ TestLabel "testPlayerDisabled" $ TestCase testPlayerDisabled
    , TestLabel "testPlayerNotDisabled" $ TestCase testPlayerNotDisabled
    ]
