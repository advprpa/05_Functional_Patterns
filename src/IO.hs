
bindIO :: IO a -> (a -> IO b) -> IO b
bindIO = undefined

gr :: IO String
gr = getLine `bindIO` \fName -> readFile fName :: IO String
