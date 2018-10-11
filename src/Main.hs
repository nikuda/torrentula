module Main where

import System.IO
import System.Environment
import Data.BEncode
import Data.BEncode.Types (BDict)
import qualified Data.ByteString as BS

main :: IO ()
main = do
  path : _ <- getArgs
  content  <- BS.readFile path

  case decode content :: (Result BDict) of
    Left  err -> hPutStrLn stderr err
    Right ben -> print $ toBEncode ben
