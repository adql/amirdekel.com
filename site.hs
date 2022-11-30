--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
  match "images/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "css/*" $ do
    route   idRoute
    compile compressCssCompiler

  match "pages/*.md" $ do
    route   $ composeRoutes
      ( gsubRoute "pages/" (const "") )
      ( setExtension "html" )
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext

  -- cv.pdf must be created externally since org includes are not
  -- honored -- https://github.com/jaspervdj/hakyll/issues/635
  match "pages/cv.pdf" $ do
    route   $ constRoute
      "Amir_Dekel_CV.pdf"
    compile $ copyFileCompiler

  match "templates/*" $ compile templateBodyCompiler
