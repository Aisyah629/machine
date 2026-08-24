USING: io io.encodings.io.encodings.utf8 kernel math namespaces sequences tools ;
IN: data-processing-tool

: read-data-file ( path -- data )
    utf8 [ slurp-lines ] with-file-strings ;

: clean-data ( seq -- cleaned )
    [ string>number <f=? ] filter ;

: transform-data ( seq -- transformed )
    [ sq dupd + ] map ;

: write-output ( data path -- )
    utf8 [ write-lines ] with-file-output ;

: process-file ( input-path output-path -- )
    read-data-file clean-data transform-data swap write-output ;

MAIN: main
    "input.txt" "output.txt" process-file
