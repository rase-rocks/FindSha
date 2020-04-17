import Foundation

enum OpeningError: String, Error {
    case noInput
}

do {
    
    guard let tool = CLI() else {
        throw OpeningError.noInput
    }
    
    tool.runRecursive()
    
} catch {
    
    let message = """
    
    Whoops! An error occured: \(error)
    
    Arguments
    =========
    
    \(CommandLine.arguments)

    Correct Usage
    =============
    
    --in, -i        :   The location to search
    --sha, -s       :   The hash to search for
    
    findsha -i <path to search> -s <hash to search for>
    
    Note
    ====
    
    The examples below assume that a line similar to the one below has been added to your
    .zshrc / .bash_profile etc:
    
    alias findsha='~/path/to/binary/FindSha'
    
    Where ~/path/to/binary is the path the place you have located the FindSha binary
    
    Example
    -------
    
    [ % findsha -i ./ -s 24e55b58575f0cb9a661b1a07e3d33b6910e6353826ba5ff03befb1f61152b55 ]
    
    This example will find the above hash in the current working directory.
    
    To find a sha hash currently in the pasteboard try the following:
    
    [ % findsha -i ./ -s $(pbpaste) ]
    
    This example subsitutes the sha to find with the data contained in the pasteboard
    
    
    
"""
    
    print(message)
    
}

