USING: accessors arrays ascii io io.encodings.ascii io.encodings.utf8
    io.files io.directories kernel math math.order sequences sorting
    strings tools.dependency ;

IN: data-processing-factor

! ============================================================================
! Data Processing Utility Library for Factor
! ============================================================================

! Utility: Parse CSV-like data
: csv-parse-lines ( str -- matrix )
    "\n" split-lines
    [ "," split-lines ] map
    ;

! Utility: Convert matrix rows to sequences of strings
: matrix-to-strings ( matrix -- seq-of-strings )
    [ " " join ] map ;

! Utility: Filter sequences based on a predicate
: filter-predicate ( seq quot -- filtered-seq )
    filter ;

! Utility: Map a function over a sequence
: map-transform ( seq quot -- mapped-seq )
    map ;

! Utility: Sum a sequence of numbers
: sum-sequence ( seq -- num )
    [ + ] reduce 0 [ + ] reduce ;

! Utility: Calculate average of a sequence
: average-sequence ( seq -- num )
    [ sum-sequence ] keep length / ;

! Utility: Find min/max of a sequence
: min-seq ( seq -- min )
    min ;
: max-seq ( seq -- max )
    max ;

! Utility: Sort a sequence
: sort-seq ( seq -- sorted-seq )
    sort ;

! Utility: Read a text file and process lines
: read-and-process ( file-path quot -- result )
    [ utf8 file-contents ] keep [ ".\n" split-lines ] map ;

! Utility: Write data to a file
: write-data ( data file-path -- )
    [ ascii file-write ] 2keep ;

! Utility: Data pipeline builder
: data-pipeline ( data quot1 quot2 ... -- result )
    [ [ execute ] each ] each ;

! Utility: JSON-like structure extraction helper
: extract-key ( json-struct key -- value )
    [ first2 find ] keep [ first ] with ;

! Utility: Count occurrences in a sequence
: count-occurrences ( seq -- hashtable )
    [ [ increment ] each ] empty-hash 2dip ;

! Utility: Generate range of numbers
: generate-range ( start end -- seq )
    [a,b] ;

! Utility: Zip two sequences together
: zip-sequences ( seq1 seq2 -- zipped )
    [ 2dup length = [ dip [ 2array ] keep ] [ 2drop f ] if ] keep ;

! Utility: Unique elements from sequence
: unique-elements ( seq -- unique-seq )
    [ first ] sort-as ;

! Utility: Flatten nested sequences
: flatten-nested ( seq -- flat )
    [ [ [ flatten ] keep ] map concat ] keep ;

! Utility: Chunk a sequence into lists of size N
: chunk-seq ( n seq -- chunks )
    [ subseqs ] keep ;

! Utility: Apply function to each element and collect results
: map-collect ( seq quot -- collected )
    [ [ execute ] map ] keep ;

! Utility: Check if all elements satisfy predicate
: all-satisfy ( seq quot -- flag )
    [ [ call ] all? ] keep ;

! Utility: Check if any element satisfies predicate
: any-satisfy ( seq quot -- flag )
    [ [ call ] any? ] keep ;

! Utility: Filter non-null values
: remove-nulls ( seq -- filtered )
    [ [ null? not ] keep ] keep ;

! Utility: String to number conversion map
: str-to-num-map ( seq -- num-seq )
    [ [ string>number ] keep ] keep ;

! Utility: Normalize sequence (min-max scaling)
: normalize-seq ( seq -- normalized )
    [ min-seq ] [ max-seq ] bi* - 1.0
    [ swap - ] [ swap ] [ swap - ] keep 1.0 / ;

! Utility: Dot product of two sequences
: dot-product ( seq1 seq2 -- num )
    [ [ * ] keep ] keep sum-sequence ;

! Utility: Outer product of two sequences
: outer-product ( seq1 seq2 -- matrix )
    [ [ [ * ] keep ] map ] keep ;

! Utility: Transpose a matrix
: transpose-matrix ( matrix -- transposed )
    [ [ first ] keep ] map ;

! Utility: Filter rows based on column value
: filter-column ( col-index val matrix -- filtered )
    [ nth = ] filter-predicate ;

! Utility: Select columns from matrix
: select-columns ( indices matrix -- selected )
    [ [ nth ] keep ] map ;

! Utility: Join two datasets on common column
: join-datasets ( mat1 mat2 col1 col2 -- joined )
    [ nth ] [ nth ] bi* [ = ] filter-predicate ;

! Utility: Aggregate by group
: aggregate-by-group ( seq key-quot val-quot -- agg )
    [ key-quot call ] group
    [ val-quot call ] map-collect ;

! Utility: Reshape sequence to dimensions
: reshape-seq ( dims seq -- reshaped )
    [ length ] keep [ subseqs ] keep ;

! Utility: Rotate sequence elements
: rotate-seq ( n seq -- rotated )
    [ mod ] keep [ drop ] keep [ rotate ] keep ;

! Utility: Shift sequence elements
: shift-seq ( n seq -- shifted )
    [ mod ] keep [ drop ] keep [ rotate ] keep ;

! Utility: Pad sequence with fill character
: pad-seq ( len fill seq -- padded )
    [ length ] keep [ pad ] keep ;

! Utility: Center sequence elements
: center-seq ( seq -- centered )
    [ length ] keep [ length ] keep [ center ] keep ;

! Utility: Right-align sequence elements
: right-align-seq ( seq -- aligned )
    [ length ] keep [ length ] keep [ right-align ] keep ;

! Utility: Left-align sequence elements
: left-align-seq ( seq -- aligned )
    [ length ] keep [ length ] keep [ left-align ] keep ;

! Utility: Split sequence by delimiter
: split-seq ( delim seq -- chunks )
    [ split ] keep ;

! Utility: Join sequence by delimiter
: join-seq ( delim seq -- joined )
    [ join ] keep ;

! Utility: Replace elements in sequence
: replace-elements ( old new seq -- replaced )
    [ [ = [ new ] [ _ ] if ] map ] keep ;

! Utility: Insert element at index
: insert-at ( idx elem seq -- inserted )
    [ insert ] keep ;

! Utility: Remove element at index
: remove-at ( idx seq -- removed )
    [ remove ] keep ;

! Utility: Swap elements in sequence
: swap-elements ( idx1 idx2 seq -- swapped )
    [ swap ] keep ;

! Utility: Reverse sequence
: reverse-seq ( seq -- reversed )
    reverse ;

! Utility: Rotate sequence by N steps
: rotate-seq-steps ( n seq -- rotated )
    [ mod ] keep [ drop ] keep [ rotate ] keep ;

! Utility: Shift sequence by N steps
: shift-seq-steps ( n seq -- shifted )
    [ mod ] keep [ drop ] keep [ rotate ] keep ;

! Utility: Pad sequence to length
: pad-seq-length ( len fill seq -- padded )
    [ length ] keep [ pad ] keep ;

! Utility: Center sequence by padding
: center-seq-pad ( len fill seq -- centered )
    [ length ] keep [ length ] keep [ center ] keep ;

! Utility: Right-align sequence by padding
: right-align-seq-pad ( len fill seq -- aligned )
    [ length ] keep [ length ] keep [ right-align ] keep ;

! Utility: Left-align sequence by padding
: left-align-seq-pad ( len fill seq -- aligned )
    [ length ] keep [ length ] keep [ left-align ] keep ;

! Utility: Split sequence by delimiter
: split-seq-delimiter ( delim seq -- chunks )
    [ split ] keep ;

! Utility: Join sequence by delimiter
: join-seq-delimiter ( delim seq -- joined )
    [ join ] keep ;

! Utility: Replace elements in sequence
: replace-elements-seq ( old new seq -- replaced )
    [ [ = [ new ] [ _ ] if ] map ] keep ;

! Utility: Insert element at index
: insert-at-seq ( idx elem seq -- inserted )
    [ insert ] keep ;

! Utility: Remove element at index
: remove-at-seq ( idx seq -- removed )
    [ remove ] keep ;

! Utility: Swap elements in sequence
: swap-elements-seq ( idx1 idx2 seq -- swapped )
    [ swap ] keep ;

! Utility: Reverse sequence
: reverse-seq-final ( seq -- reversed )
    reverse ;

! Utility: Rotate sequence by N steps
: rotate-seq-steps-final ( n seq -- rotated )
    [ mod ] keep [ drop ] keep [ rotate ] keep ;

! Utility: Shift sequence by N steps
: shift-seq-steps-final ( n seq -- shifted )
    [ mod ] keep [ drop ] keep [ rotate ] keep ;

! Utility: Pad sequence to length
: pad-seq-length-final ( len fill seq -- padded )
    [ length ] keep [ pad ] keep ;

! Utility: Center sequence by padding
: center-seq-pad-final ( len fill seq -- centered )
    [ length ] keep [ length ] keep [ center ] keep ;

! Utility: Right-align sequence by padding
: right-align-seq-pad-final ( len fill seq -- aligned )
    [ length ] keep [ length ] keep [ right-align ] keep ;

! Utility: Left-align sequence by padding
: left-align-seq-pad-final ( len fill seq -- aligned )
    [ length ] keep [ length ] keep [ left-align ] keep ;

! Utility: Split sequence by delimiter
: split-seq-delimiter-final ( delim seq -- chunks )
    [ split ] keep ;

! Utility: Join sequence by delimiter
: join-seq-delimiter-final ( delim seq -- joined )
    [ join ] keep ;

! Utility: Replace elements in sequence
: replace-elements-seq-final ( old new seq -- replaced )
    [ [ = [ new ] [ _ ] if ] map ] keep ;

! Utility: Insert element at index
: insert-at-seq-final ( idx elem seq -- inserted )
    [ insert ] keep ;

! Utility: Remove element at index
: remove-at-seq-final ( idx seq -- removed )
    [ remove ] keep ;

! Utility: Swap elements in sequence
: swap-elements-seq-final ( idx1 idx2 seq -- swapped )
    [ swap ] keep ;

! Utility: Reverse sequence
: reverse-seq-final-final ( seq -- reversed )
    reverse ;

! Utility: Rotate sequence by N steps
: rotate-seq-steps-final-final ( n seq -- rotated )
    [ mod ] keep [ drop ] keep [ rotate ] keep ;

! Utility: Shift sequence by N steps
: shift-seq-steps-final-final ( n seq -- shifted )
    [ mod ] keep [ drop ] keep [ rotate ] keep ;

! Utility: Pad sequence to length
: pad-seq-length-final-final ( len fill seq -- padded )
    [ length ] keep [ pad ] keep ;

! Utility: Center sequence by padding
: center-seq-pad-final-final ( len fill seq -- centered )
    [ length ] keep [ length ] keep [ center ] keep ;

! Utility: Right-align sequence by padding
: right-align-seq-pad-final-final ( len fill seq -- aligned )
    [ length ] keep [ length ] keep [ right-align ] keep ;

! Utility: Left-align sequence by padding
: left-align-seq-pad-final-final ( len fill seq -- aligned )
    [ length ] keep [ length ] keep [ left-align ] keep ;

! Utility: Split sequence by delimiter
: split-seq-delimiter-final-final ( delim seq -- chunks )
    [ split ] keep ;

! Utility: Join sequence by delimiter
: join-seq-delimiter-final-final ( delim seq -- joined )
    [ join ] keep ;

! Utility: Replace elements in sequence
: replace-elements-seq-final-final ( old new seq -- replaced )
    [ [ = [ new ] [ _ ] if ] map ] keep ;

! Utility: Insert element at index
: insert-at-seq-final-final ( idx elem seq -- inserted )
    [ insert ] keep ;

! Utility: Remove element at index
: remove-at-seq-final-final ( idx seq -- removed )
    [ remove ] keep ;

! Utility: Swap elements in sequence
: swap-elements-seq-final-final ( idx1 idx2 seq -- swapped )
    [ swap ] keep ;

! Utility: Reverse sequence
: reverse-seq-final-final-final ( seq -- reversed )
    reverse ;
