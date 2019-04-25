module OptparseApplicative.Simple.IO
(
  parseCmdArgs,
)
where

import BasePrelude
import Data.Text (Text)
import qualified OptparseApplicative.Simple.Parser as D
import qualified OptparseApplicative.Simple.ParserInfo as C
import qualified Options.Applicative as B


{-|
Parses the application arguments and outputs help when needed.
-}
parseCmdArgs 
  :: Text -- ^ Program description
  -> D.Parser a -- ^ Arguments specification
  -> IO a -- ^ IO action producing the parsed arguments
parseCmdArgs description parser =
  parserInfo (C.parser description parser)

parserInfo :: C.ParserInfo a -> IO a
parserInfo =
  B.execParser
