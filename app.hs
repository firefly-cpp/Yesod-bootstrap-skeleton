{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ViewPatterns      #-}

import           Yesod
import           Yesod.Static

data App = App
    { getStatic :: Static
    }
    
mkYesod "App" [parseRoutes|
/ HomeR GET
/static StaticR Static getStatic
|]

instance Yesod App
          
getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        setTitle "Hello world"
        $(whamletFile "hamlet/hello.hamlet") 
  
main :: IO ()
main = do
    static@(Static settings) <- static "static"
    warp 3000 $ App static
