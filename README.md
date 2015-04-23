[![Build Status](https://travis-ci.org/dsaenztagarro/haskell-paizo.svg)]
(https://travis-ci.org/dsaenztagarro/haskell-paizo)
[![Coverage Status](https://coveralls.io/repos/dsaenztagarro/haskell-paizo/badge.svg)]
(https://coveralls.io/r/dsaenztagarro/haskell-paizo)

# haskell-paizo

```
cabal init
cabal configure --enable-tests --enable-coverage
cabal install --only-dependencies --enable-tests
cabal build
cabal test --show-details=always --keep-tix-files
cabal run MainTest
```