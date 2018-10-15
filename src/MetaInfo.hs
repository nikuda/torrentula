{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module MetaInfo where

import Prelude hiding (length)
import Data.ByteString (ByteString)
import Data.BEncode
import Network.URI (URI)
import GHC.Generics

newtype Announce = Announce URI
  deriving (Eq, Show)

newtype FileName = FileName ByteString
  deriving (Generic, Eq, Read, Show)

newtype DirectoryName = DirectoryName ByteString
  deriving (Eq, Read, Show)

newtype SHA1 = SHA1 ByteString
  deriving (Eq, Read, Show)

data MetaInfo = MetaInfo
  { announce :: Announce
  , info :: Info
  }

data Info = Info BaseInfo (Either FileInfo FilesInfo)

data BaseInfo = BaseInfo
  { pieces :: [SHA1]
  , pieceLength :: Int
  } deriving (Eq, Read, Show)

data FileInfo = FileInfo
  { name :: FileName
  , length :: Int
  } deriving (Generic, Eq, Read, Show)

data FilesInfo = FilesInfo
  { directory :: DirectoryName
  , files :: [File]
  } deriving (Eq, Read, Show)

data File = File
  { fileLength :: Int
  , filePath :: [DirectoryName] -- Last item is name of a file
  } deriving (Eq, Read, Show)


--

instance BEncode FileName where
  fromBEncode = fromDict $ FileName <$>! "name"

instance BEncode FileInfo where
  toBEncode FileInfo { name = fiName, length = fiLength } = toDict $
        "name"    .=! fiName
    .: "length"   .=! fiLength
    .: endDict

  fromBEncode = fromDict $
    FileInfo <$>! "name"
             <*>! "length"
