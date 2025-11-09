![Perl](https://img.shields.io/github/languages/top/vbwx/finddup?style=flat)
![MIT license](https://img.shields.io/github/license/vbwx/finddup?style=flat)

# finddup

<details>
	<summary>Contents</summary>
	<ol>
		<li><a href="#description">Description</a></li>
		<li>
			<a href="#installation">Installation</a>
			<ol type="i">
				<li><a href="#installation-via-homebrew">Installation via Homebrew</a></li>
				<li><a href="#manual-installation">Manual Installation</a></li>
			</ol>
		</li>
		<li>
			<a href="#usage">Usage</a>
			<ol type="i">
				<li><a href="#examples">Examples</a></li>
				<li><a href="#manual">Manual</a></li>
			</ol>
		</li>
	</ol>
</details>

## Description

finddup is a command-line utility which compares the contents of files to check if any of them match.
What is considered a match depends on the chosen method; three methods are available:

- *Heuristic comparison* (very fast)
- *Heuristic comparison with trimming* (useful for text and video files, or any files with padding bytes at the end)
- *Precise comparison* (slow but absolutely accurate)

For further processing of the results, you can choose between seven output modes:

- One match per line
- Original with a list of its duplicates
- Duplicate and original each on a separate line
- Only duplicates/originals
- Smallest/largest duplicates
- Oldest/newest duplicates
- Only unique files

There are many more options that let you control which files are ignored, which files should be compared, how accurate the heuristic comparison methods should be, how the utility should handle symbolic links, and whether to look for files in subdirectories.

## Installation

So far, I have used finddup only on macOS, therefore I can only describe how to install it on a Mac — although the instructions should work just as well on Linux.

### Installation via Homebrew

If [Homebrew](https://brew.sh) is installed, you can run this command:

```sh
brew install vbwx/utils/finddup
```

### Manual Installation

1. Download and extract the [latest release](https://github.com/vbwx/finddup/releases/latest) of finddup.
2. If desired, move the completion script(s) to the appropriate location on your system.
   - Move `completion/finddup` to a directory like `/etc/bash_completion.d`.
   - Move `completion/_finddup` to a directory like `/usr/share/zsh/site-functions`.
3. Make sure you have at least version 5.18 of Perl installed. (Run `perl -v` to check.)
4. Run the following command.

```sh
cpan .
```

Alternatively, if you have [**cpanminus**](https://metacpan.org/pod/App::cpanminus) installed and want more flexibility with regards to installation directories, you can run these commands:

```sh
cpanm --installdeps .
perl Makefile.PL INSTALL_BASE=<your_install_dir>
make
make install
```

## Usage

Run `finddup --help` to get a quick overview of how to use this utility.

### Examples

The following command calculates how much storage is taken up by duplicates in the entire file hierarchy of the working directory.

```sh
finddup -ra0 | xargs -0 du -ch --
```

Here is how to delete the newest exact copies of files located in different directories (a.k.a. keep only the originals):

```sh
finddup -pC0 some_folder another_folder | xargs -0 rm -f
```

Instead of running `diff` in a loop, finddup can be used to determine which files have been changed, even across multiple copies of a directory.

```sh
finddup -rn folder-v*/
```

The following command lists all files with multiple hard links located in the entire file hierarchy of the working directory.

```sh
findlink -rd
```

### Manual

You can find a detailed explanation of all options, a tutorial, and more technical information in the [User Manual](Manual.md).
