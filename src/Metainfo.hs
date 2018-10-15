module Metainfo where

import Data.ByteString
import Network.URI

newtype Announce = Announce URI
  deriving (Eq, Show)

newtype FileName = FileName ByteString
  deriving (Eq, Show)

newtype DirectoryName = DirectoryName ByteString
  deriving (Eq, Show)

newtype SHA1 = SHA1 ByteString
  deriving (Eq, Show)

data MetaInfo = MetaInfo
  { announce :: Announce
  , info :: Info
  }

data Info = Info BaseInfo (Either FileInfo FilesInfo)

data BaseInfo = BaseInfo
  { pieces :: [SHA1]
  , pieceLength :: Int
  } deriving (Eq, Show)

data FileInfo = FileInfo
  { name :: FileName
  , length :: Int
  } deriving (Eq, Show)

data FilesInfo = FilesInfo
  { directory :: DirectoryName
  , files :: [File]
  } deriving (Eq, Show)

data File = File
  { fileLength :: Int
  , filePath :: [DirectoryName] -- Last item is name of a file
  } deriving (Eq, Show)
