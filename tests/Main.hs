module Main where

import CoreTests

import Test.HUnit

main :: IO Counts
main = runTestTT $ TestList
    [ TestLabel "CoreTests" CoreTests.tests ]
