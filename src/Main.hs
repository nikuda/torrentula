module Main where

import System.IO
import System.Environment
import Data.BEncode
import Data.BEncode.Types (BDict)
import qualified Data.ByteString as BS
import MetaInfo

main :: IO ()
main = do
  path : _ <- getArgs
  content  <- BS.readFile path

  case decode content :: (Result BDict) of
    Left  err -> hPutStrLn stderr err
    Right ben -> print $ (fromBEncode $ toBEncode ben :: Result FileInfo)
