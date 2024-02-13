# NAME

**finddup** – Finds duplicated files fast and efficiently.

# SYNOPSIS

**finddup** \[**-aehiqr0**\] \[**-p** \| **-t**\]
\[**-l** \| **-o** \| **-O** \| **-s** \| **-S** \| **-m** \| **-M** \| **-n**\]
\[**-B** \| **-T**\] \[**-H** \| **-L** \| **-P**\] \[**-I** _glob_\] \[**-X** _glob_\]
\[_file_ ...\]

# DESCRIPTION

This utility compares the contents of files to check if any of them match.
What is considered a match depends on the chosen method.

- By default, files are compared **heuristically**, which means that files are
considered duplicates if they are the same size, and if a few bytes
of different parts of the file contents are identical to their counterparts.

    This method is very fast and accurate enough for most use cases, but it
    can produce false positives (or false negatives when invoked with **-n**).

- The **trim** method (**-t**) also employs heuristic comparison as
described above, but it ignores repeating characters at the start and
end of file contents. This is especially useful for text files, which often
end with blank lines, and video files, which might have a varying number of
NUL characters at the end of their contents.

    However, this method is a little slower because it needs to open every file
    to compare their contents to each other, whereas the default method only
    has to compare files of the same size.

- With **precise comparison** (**-p**), file contents are compared
byte for byte, so it can be guaranteed that only perfect duplicates are found.

    This method is the slowest one unless all files are different sizes, in which
    case it is actually faster than the trim method.

Note that multiple hard links to the same file are considered duplicates
unless the **-h** option is specified.

There are various output modes that are mostly useful for subsequent
processing of the results.

- By default, copies and their originals are shown in pairs. The format of
this mode might change in the future and is therefore not suited for automatic
processing or piping.
- The **-l** option prints the paths of each file and its duplicate on separate
lines.
- The **-o** option prints all copies of other files, whereas **-O** prints
the _original_ files, i.e., the files that were encountered first and found
to have duplicates.
- The **-s** and **-S** options print the smallest and largest duplicates,
respectively. Since this only makes sense when used with the **trim** method,
these options automatically activate it.
- The **-m** and **-M** options print the least and most recently modified
duplicates, respectively.
- The **-n** option negates the results, meaning that only the paths of files
that do not have duplicates are printed.

As for non-option arguments, **finddup** differentiates between files and
directories; files passed as arguments are checked and compared first, and
directories are traversed after. Hence, while it does not matter whether
files or directories appear first on the command line, the order of multiple
files and the order of multiple directories might affect the results,
depending on the output mode.

When invoked without non-option arguments, **finddup** looks for duplicates
in the working directory. When files are passed as arguments, **finddup**
only looks for copies of these files.

This manual contains a [tutorial](#tutorial).

# OPTIONS

## Comparison Methods

- **-p**

    Compare the entire contents of files.
    This is slower but only finds files that are perfect duplicates.

- **-t**

    Trim repeating characters from the beginning and end of file contents
    before comparing them.

## Output Modes

- **-l**

    Print paths of each file and its duplicate on separate lines.

- **-o**

    Only print paths of files that are duplicates of other files.
    This is equivalent to the left path in the default output mode.

- **-O**

    Only print paths of files that have at least one duplicate.
    This is equivalent to the right path in the default output mode.

    This option might cause paths to be printed multiple times.

- **-s**

    Only print paths of files whose size is smaller than or equal to
    the size of their respective duplicates.

    Implies **-t**.

- **-S**

    Only print paths of files whose size is larger than or equal to
    the size of their respective duplicates.

    Implies **-t**.

- **-m**

    Only print paths of files whose modification date is older than
    or equal to the date of their respective duplicates.

- **-M**

    Only print paths of files whose modification date is newer than
    or equal to the date of their respective duplicates.

- **-n**

    Only print paths of files that have no duplicates.

## Directory Traversal Options

- **-a**

    Compare all files, including hidden files, such as `Thumbs.db`
    and `Icon?`. Also look for files in hidden directories.

- **-e**

    Ignore empty files.

- **-r**, **-R**

    Look for duplicates in subdirectories as well.

- **-B**

    Only compare binary files.

- **-T**

    Only compare text files.

- **-H**

    Follow symbolic links on the command line.

- **-L**

    Follow all symbolic links.

- **-P**

    Do not follow symbolic links. This is the default.

- **-I** _glob_

    Only compare files matching the pattern _glob_.

    Run `perldoc Text::Glob` to learn about pattern syntax.
    Don't forget to put the pattern in quotes if it contains wildcard characters!

- **-X** _glob_

    Do not compare files matching the pattern _glob_.

    Run `perldoc Text::Glob` to learn about pattern syntax.
    Don't forget to put the pattern in quotes if it contains wildcard characters!

- **-i**

    Ignore the case of glob patterns.

## Miscellaneous Options

- **-h**

    Do not regard multiple hard links to the same file as duplicates.

- **-q**

    Do not print the number of duplicated or unique files.

- **-0**

    Print paths separated by NUL characters; useful for `xargs -0`.

    Implies **-o** unless an [output mode](#output-modes) is specified.

- **-\-help**

    Print a synopsis of the command and its options.

- **-\-version**

    Print version information.

# TUTORIAL

For all of these examples you should bear in mind that, unless **-p** is
specified, this utility might identify duplicates that are not, in fact,
identical but you have to trade off precision against speed of operation.

In this tutorial, the words _duplicates_ and _copies_ are used
interchangeably.

## Finding Duplicates

Let's start by looking for duplicates in the working directory.

    finddup

You can also check whether a directory contains duplicates of files in
another directory (or vice versa). Note that this command will also find
copies of files that are both located in the same directory.

    finddup dir1 dir2

To simply get a list of duplicates (without the corresponding original file),
call `finddup -o dir1 dir2` instead. Provided that `dir2` contains copies
of files from `dir1`, this command will print the paths of the duplicated
files in `dir2`.

## Comparing Files

You might want to find out which files are copies of other files.

    finddup file1.xyz file2.xyz file3.xyz

The next example shows how to determine which of two files is the original,
i.e., the older one of the duplicates, provided that they are perfectly
identical.

    finddup -pm file1.xyz file2.xyz

## Removing Duplicates

It's easy to pipe the results to another utility, e.g., to delete
duplicated files. (The **-0** (zero) option implies **-o** unless another
[output mode](#output-modes) is specified, which comes in handy for
a simple operation like this.)

    finddup -0 | xargs -0 rm

However, maybe you only want to delete specific files that already exist
somewhere else and leave all other duplicates untouched, if there are any.
This command searches `dir` recursively, and either does nothing or
removes `file.xyz` if a duplicate of it exists anywhere in `dir`. (It
will also try to delete the file more than once if `dir` contains multiple
copies of it.)

    finddup -rO0 file.xyz dir | xargs -0 rm

You could also delete text files that are almost identical but end (or
begin) with unnecessary blank lines.

    finddup -TS0 | xargs -0 rm

**Caution:** In the examples above, _heuristic_ comparison was used, which
could lead to the removal of files that were not exact copies of any other
file but that the utility still regarded as duplicates. Only the _precise
comparison method_ can rule out false positives.

## Finding Unique Files

You might find yourself in a situation where two or more directories contain
the same files except for a few that have been changed (or corrupted). To get
a list of these unique files, you can negate the results.

    finddup -n dir1 dir2

Similarly, to make sure that the working directory does not contain a copy of
a specific file, you can use a command like this.

    finddup -n . file.xyz

# CAVEATS

Although **finddup** should work on any platform, it has so far only been
tested on macOS.

# SEE ALSO

[diff(1)](http://man.he.net/man1/diff), [xargs(1)](http://man.he.net/man1/xargs), [File::Compare](https://metacpan.org/pod/File%3A%3ACompare), [Text::Glob](https://metacpan.org/pod/Text%3A%3AGlob)

# AUTHORS

Bernhard Waldbrunner ([github.com/vbwx](https://github.com/vbwx))
