#!/usr/bin/env nix-shell
#!nix-shell -i "runhaskell -Wall -no-user-package-db"
--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend)
import Hakyll
import Hakyll.Images        ( loadImage
                            , compressJpgCompiler
                            , scaleImageCompiler
                            )


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "favicon.png" $ do
        route idRoute
        compile copyFileCompiler

    match "materialize/**/*" $ do
        route idRoute
        compile copyFileCompiler

    match "images/**" $ do
        route   idRoute
        compile copyFileCompiler

    match "pictures/**" $ do
        route   idRoute
        compile $ loadImage
            >>= scaleImageCompiler 1200 450
            >>= compressJpgCompiler 90

    match "googlead1fe7ef91f639f7.html" $ do
        route   idRoute
        compile copyFileCompiler

    match "*.json" $ do
        route   idRoute
        compile copyFileCompiler

    match "participants/**/*" $ do
        route idRoute
        compile copyFileCompiler

    match "js/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "fonts/**/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["code-of-conduct.md"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/container.html" defaultContext
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "*.html" $ do
        route idRoute
        compile $ getResourceBody
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext
