{-# language OverloadedStrings, RankNTypes #-}
module Main where

import Rasa (rasa)
import Rasa.Ext
import Rasa.Ext.Views
import Rasa.Ext.Vim
import Rasa.Ext.Files
import Rasa.Ext.Logger
import Rasa.Ext.Cursors
import Rasa.Ext.Slate

import Control.Lens
import Data.Maybe
import Data.Default
import qualified Yi.Rope as Y
-- import Control.Monad
-- import Control.Monad.Trans

-- | This is the main of an executable that runs rasa with any extensions the
-- user wants
--
-- The @do@ block is just a normal 'Action' ()

main :: IO ()
main = rasa $ do
  viewports
  vim
  files
  cursors
  logger
  slate
  onInit $ onBufAdded eachNewBuffer
  afterInit $ addBuffer "This is a buffer to get you started!\nYou can also pass command line args to rasa"

eachNewBuffer :: BufAdded -> Action ()
eachNewBuffer (BufAdded br) = bufDo_ br $ do
  addBottomBar $ return ("Hello!" :: Y.YiString)
  addLeftBar $ return ("1\n2\n3\n4\n5\n6\n7" :: Y.YiString)
