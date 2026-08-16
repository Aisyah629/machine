/* REXX */
parse arg sourceFile destFile
if sourceFile = '' then sourceFile = 'input.txt'
if destFile = '' then destFile = 'output.txt'

if sourceFile = destFile then do
  say 'Source and destination files are the same. Please specify unique names.'
  exit 12
end

if .lines(sourceFile) = 0 then do
  say 'Source file not found: ' sourceFile
  exit 13
end

count = 0
processLine: procedure expose count
parse arg line

/* Strip leading/trailing whitespace */
line = strip(line)

/* Skip empty lines */
if length(line) = 0 then return

/* Replace any sequence of tabs with a single space */
line = translate(line, ' ', c2x(9))

/* Convert any sequence of multiple spaces into a single space */
do while pos('  ', line) > 0
  line = changestr('  ', line, ' ')
end

count = count + 1
say line

parse source _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

/* Main logic */
fh = infile(sourceFile)
do while stream(fh, 'C', 'QUERY EXISTS') = 'YES'
  call processLine line
end
close fh

fhOut = outfile(destFile, 'W')
fhOut = outfile(destFile)
if .lines(sourceFile) > 0 then do
  fh = infile(sourceFile)
  do while stream(fh, 'C', 'QUERY EXISTS') = 'YES'
    call processLine line
    fhOut = line
  end
  close fh
end
close fhOut

say 'Processed ' count ' lines.'
exit 0
