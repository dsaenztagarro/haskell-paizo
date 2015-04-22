module Main where

import CoreTests

import Test.Framework (defaultMain)

main :: IO ()
main = defaultMain [CoreTests.tests]
