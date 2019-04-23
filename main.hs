main = do   orthKey        <- parseMapTxt <$> readFile "../dat/key"
            lexicon        <- parseMapTxt <$> readFile "../dat/lex"
            argList        <- getArgs
            let fileList    = safeTail argList
            let mergeMode   = safeHead argList
            fileTexts      <- mapM readFileSafe fileList
            let lexHoles    = checkLexForHoles lexicon <$> fileTexts
            lexicon'       <- buildLexicon orthKey <$> scrapeFor lexHoles
            let newLex      = mergeLex mergeMode lexicon lexicon'
            writeFile "../dat/lex" $ encode newLex
            let results     = safeConvert newLex <$> fileTexts
            let converted   = fst <$> results
            let errors      = snd <$> results
            mapM_ (uncurry writeCopySafe) <$> zip fileList converted
            putStrLn . formatErrors $ zip fileList errors
