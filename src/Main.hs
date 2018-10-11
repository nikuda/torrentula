module Main where

import Data.BEncode
import Data.BEncode.Types (BDict)
import qualified Data.ByteString as BS
import System.IO
import System.Environment

main :: IO ()
main = do
  path : _ <- getArgs
  content  <- BS.readFile path :: IO BS.ByteString
  case decode content :: (Result BDict) of
    Left  e  -> hPutStrLn stderr e
    Right be -> print $ toBEncode be
