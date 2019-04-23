# frenchorthconv
An automatic converter from traditional french orthography to a new and improved orthography


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
