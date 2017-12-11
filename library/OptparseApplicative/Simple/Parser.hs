module OptparseApplicative.Simple.Parser
(
  Parser,
  argument,
  lenientArgument,
)
where

import BasePrelude
import Data.Text (Text)
import qualified Options.Applicative as A
import qualified Data.Attoparsec.Text as B
import qualified Data.Text as C
import qualified Attoparsec.Data as D


{-|
Specification of a command line arguments parser and help generator.

Has instances of 'Functor', 'Applicative' and 'Alternative',
which you can use for composition.
-}
type Parser =
  A.Parser

{-|
Definition of a single argument.
-}
argument
  :: Text -- ^ Long name
  -> Maybe Char -- ^ Possible short name
  -> Maybe Text -- ^ Possible description
  -> Maybe (a, Text) -- ^ Possible default value with its text representation to display in the generated help
  -> B.Parser a -- ^ Attoparsec parser of the value. The \"attoparsec-data\" package provides such parsers for a lot of standard types
  -> A.Parser a
argument longName shortName description defaultValue parser =
  A.option readM mods
  where
    readM =
      A.eitherReader (B.parseOnly parser . C.pack)
    mods =
      A.long (C.unpack longName) <>
      foldMap A.short shortName <>
      foldMap (A.help . C.unpack) description <>
      foldMap (\(value, text) -> A.value value <> A.showDefaultWith (const (C.unpack text))) defaultValue

{-|
Same as 'argument', only provided with a default parser.
-}
lenientArgument :: D.LenientParser a => Text -> Maybe Char -> Maybe Text -> Maybe (a, Text) -> A.Parser a
lenientArgument longName shortName description defaultValue =
  A.option readM mods
  where
    readM =
      A.eitherReader (B.parseOnly D.lenientParser . C.pack)
    mods =
      A.long (C.unpack longName) <>
      foldMap A.short shortName <>
      foldMap (A.help . C.unpack) description <>
      foldMap (\(value, text) -> A.value value <> A.showDefaultWith (const (C.unpack text))) defaultValue
