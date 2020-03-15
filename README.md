# FindSha

FindSha is a very simple macOS command line utility to search a directory for files with the given sha256 hash.

This document assumes the use of macOS Catalina, and a knowledge of terminal and command line programs, however the source should be portable to any system with a Swift compiler, such as Linux based systems, the only dependency is the CommonCrypto library that is available in macOS. It should be noted however that I have not tested this and I have only ever built the binary with Xcode, so build instructions for others operating system are not included here as yet.

## Why

This tool was created as a simple way to search a directory that was full of policy documents. It was necessary to check that the policy documents had not been altered or tampered with so at the time of creation the documents had a sha256 hash generated and stored separately. Meaning they could be referred to, with a high degree of certainty again in the future without any ambiguity surrounding two different users referring to two different documents on two different machines, across versions. But sha256 hashes are a little unwieldy for humans and relying on naming with file with the hash would defeat any correctness checking measures put into place.

Therefore this tool was born.

## Installation

Clone and build the repository in Xcode.

You can find the compiled binary by clicking on the 'FindSha' item under 'Products' in the project explorer.

The detail inspector will show the full path and clicking the arrow next to the path will open in in Finder. From here you can just copy the binary to someplace on your file system.

I tend to store simple CLI tools like this in a folder `~/scripts` so I then add an alias to my .zshrc file like the following:

```sh
alias findsha='~/scripts/FindSha'
```

## Usage

--in, -i    :   The location to search
--sha, -s   :   The sha256 hash to search for
    
Rather than typing in a sha256 hash it is probably easier to copy the hash from somewhere else and use the command below.

It uses command subsitution to search for whatever is in the pasteboard in the current directory.

```sh
findsha -i ./ -s $(pbpaste)
```

## OpenSSL and SHA256

This tool is for the circumstances in which you already have the hash and you need to find the file. But to complete the circle a quick reminder on how to create sha256 hashes is included here.

Lets assume we have a pdf document that we want to find the sha hash for, for future reference.

Finding the sha256 hash is easy with openssl. Just run the command with the option `sha256` and the file name to be hashed:

```sh
 % openssl sha256 important-document.pdf 
SHA256(important-document.pdf)= e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
```

The hash for `important-document.pdf` therefore is `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

(The file was zero bytes long in this case)

