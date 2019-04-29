module Main where

import Prelude
import qualified OptparseApplicative.Simple.Parser as A
import qualified OptparseApplicative.Simple.IO as B
import qualified Attoparsec.Data as B


main =
  B.parseCmdArgs "demo" parser >>= print
  where
    parser =
      (,,) <$> arg1 <*> arg2 <*> arg3
      where
        arg1 =
          A.argument "arg1" (Just 'a') (Just "Description1") (Just (True, "True")) B.bool
        arg2 =
          A.argument "arg2" Nothing Nothing Nothing B.text
        arg3 =
          A.argument "arg3" Nothing Nothing Nothing B.utf8Bytes <|> pure ""
