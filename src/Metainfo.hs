module Metainfo where

import Network.URI

newtype Announce = Announce URI
  deriving (Eq, Show)

data Info = Info
  { name :: Maybe String
  , pieceLength :: Int
  , pieces :: String
  } deriving (Eq, Show)

newtype File = File
  { fileLength :: Int
  } deriving (Eq, Show)

newtype Files = Files
  { files :: [FilesInfo]
  } deriving (Eq, Show)

data FilesInfo = FilesInfo
  { filesLength :: Int
  , path :: [String]
  } deriving (Eq, Show)
