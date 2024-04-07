#!/bin/env fish

# Requires opus-tools, golf (included in gist)
set SOURCE_DIR $argv[1]
set OUTPUT_DIR $argv[2]
set SOURCE_TREE (gold $SOURCE_DIR)

# incase I want to make any changes to the encoding.
function _encode
    opusenc $argv[1] $argv[2]
end

# Create source tree structure
for folder in $SOURCE_TREE
    mkdir -p $OUTPUT_DIR/$folder
    set list (golf $SOURCE_DIR/$folder)
    for i in $list
        if test (string match -r "\.flac" $i)
            set o (string replace ".flac" ".opus" $i)
            if test ! -e $OUTPUT_DIR/$folder/$o
                _encode $SOURCE_DIR/$folder/$i $OUTPUT_DIR/$folder/$o
            end
        else
            if test ! -e $OUTPUT_DIR/$folder/$i
                cp $SOURCE_DIR/$folder/$i $OUTPUT_DIR/$folder/$i
            end
        end
    end
end
