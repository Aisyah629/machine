dnl main.m4 - M4 Data Processor

dnl Define a simple macro for data processing
define(`process_data', `process_item($1, $2, $3)')

dnl Define a function to process items
define(`process_item', `dnl
ifelse($1, `', `',
  ifelse($2, `', `',
    ifelse($3, `', `',
      `$1 -> $2 -> $3\n')
    )
  )
)dnl
')

dnl Process sample data
dnl Uncomment the following lines to process actual data
dnl process_data(`header', `content', `footer')
dnl process_data(`name', `value', `type')
