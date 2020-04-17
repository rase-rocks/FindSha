# FindSha

FindSha is a very simple macOS command line utility to recursively search a directory for files with the given sha hash.

The hash/digest to search for can be either sha256 or sha512, the correct type will be used.

This document assumes the use of macOS Catalina, and a knowledge of terminal and command line programs. It was designed and built with Xcode and has therefore not been tested with other Swift implementations

## Why

This tool was created as a simple way to search a directory that was full of policy documents. It was necessary to check that the policy documents had not been altered or tampered with so at the time of creation the documents had a sha256 hash generated and stored separately. Meaning they could be referred to, with a high degree of certainty again in the future without any ambiguity surrounding two different users referring to two different documents on two different machines, across versions. But sha256 hashes are a little unwieldy (and sha512 even worse) for humans and relying on naming with file with the hash would defeat any correctness checking measures put into place.

Therefore this tool was born.

A GUI version of this tool is available under the name `ShaSearch` on the Mac App Store.

## Installation

Clone and build the repository in Xcode.

You can find the compiled binary by clicking on the 'FindSha' item under 'Products' in the project explorer.

<img width="480" alt="XcodeFindShaProducts" src="https://user-images.githubusercontent.com/38786434/76707156-d62be900-66e4-11ea-8c5a-ada0874f613c.gif">

The detail inspector will show the full path and clicking the arrow next to the path will open in in Finder. From here you can just copy the binary to someplace on your file system.

<img src="https://user-images.githubusercontent.com/38786434/76706224-cbba2100-66dd-11ea-88ed-13cf7ffa2b9c.png" alt="Identity Inspector" width="50%"/>

I tend to store simple CLI tools like this in a folder `~/scripts` so I then add an alias to my .zshrc file like the following:

```sh
alias findsha='~/scripts/FindSha'
```

You could also add the folder to your `PATH` environment variable.

## Usage

| Long Form | Short Form  | Description                    |
|-----------|-------------|--------------------------------|
| --in      | -i          | The location to search         |
| --sha     | -s          | The hash to search for (sha256)|
    
Rather than typing in a hash it is probably easier to copy the hash from somewhere else and use the command below.

It uses command subsitution to search for whatever is in the pasteboard in the current directory.

```sh
findsha -i ./ -s $(pbpaste)
```

## OpenSSL and SHA

This tool is for the circumstances in which you already have the hash and you need to find the file. But to complete the circle a quick reminder on how to create hashes is included here.

Lets assume we have a pdf document that we want to find the sha hash for, for future reference.

Finding the hash is easy with openssl. Just run the command with the option `sha256` or `sha512` and the file name to be hashed:

```sh
 % openssl sha256 important-document.pdf 
SHA256(important-document.pdf)= e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
```

The SHA256 hash for `important-document.pdf` therefore is `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

(The file was zero bytes long in this case).

