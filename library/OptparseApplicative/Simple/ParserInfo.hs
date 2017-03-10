module OptparseApplicative.Simple.ParserInfo
(
  parser,
  -- * Reexports
  B.ParserInfo,
)
where

import BasePrelude
import Data.Text (Text)
import qualified OptparseApplicative.Simple.Parser as C
import qualified Options.Applicative as B
import qualified Data.Text as D


{-|
Constructs ParserInfo from Parser.
-}
parser 
  :: Text -- ^ Program description
  -> B.Parser a -- ^ Parser
  -> B.ParserInfo a
parser description parser =
  B.info (B.helper <*> parser) mods
  where
    mods =
      B.fullDesc <>
      B.progDesc (D.unpack description)
