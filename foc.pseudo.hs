key <- readKey <$> readFile "key.data"                -- finds key for respelling
dat <- readCache <$> readFile "cache.cache"           -- reads list of known words ("index")
rarg <- getArgs                                       -- gets list of arguments ("args")
let args  = safeTail rarg                             -- extracts tail of *args (-list) ("files")
let argup = safeHead rarg                             -- extracts first argument (first element of *args)
let files = mapM readFileSafe args                    -- reads files
let holes = checkUsing dat <$> files                  -- looks for unknown words
newdat <- scrapeUsing holes key                       -- scrapes for pronounciations, spells them
let dat2 = mergeCache dat newdat argup                -- combines new index with old index
writeFile "cache.cache" dat2                          -- saves new index
let result = safeConvUsing dat2 <$> files             -- converts file contents using new index ("results")
let conv  = map fst result                            -- extracts the converted files from the *results ("converted")
let errs  = map snd result                            -- extracts the errors from the *results
mapM_ (uncurry writeCopySafe) <$> zip args conv       -- writes *converted to new files
putStrLn . customshow $ zip args errs                 -- prints errors


{-

Example usage:

A@B:~$ ls
file1 file2 file3 file4 cache.cache key.data
A@B:~$ foc keep file1 file2 file3 file5
file1       no errors
file2       2 words left
file3       empty file
file5       empty file
A@B:~$ ls
file1 file2 file3 file4 file1_1 file2_1 file3_1 file5
A@B:~$ echo "That's it! For now."
That's it! For now.
A@B:~$ exit
logout

-}
