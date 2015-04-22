module Main where

import Test.Tasty

import qualified CoreTests

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [ CoreTests.tests ]
