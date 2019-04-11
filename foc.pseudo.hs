key <- readKey <$> readFile "key.data"
data <- readCache <$> readFile "cache.cache"
rarg <- words <$> getArgs
let args  = safeTail rarg
let argup = safeHead rarg
let files = mapM getFileSafe args
let holes = checkUsing data <$> files
newdata <- scrapeUsing holes key
let data2 = mergeCache data newdata argup
writeFile "cache.cache" data2
let conv  = safeConvUsing data2 <$> 
