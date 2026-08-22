(:
  XPath Data Processor
  Extracts, transforms, and filters XML data based on query expressions.
  Supports complex node selection and conditional logic.
)

declare namespace output = 'http://www.w3.org/2010/xslt-xquery-serialization';
declare option output:method 'json';

(: Main entry point - processes a static XML document for demonstration. :) 
let $xml := doc('input.xml')
let $root := $xml//root

(: Extract key fields from all matching nodes :) 
let $data := 
  for $node in $root//item
  where exists($node/@id)
  return {
    'id': $node/@id,
    'value': $node/value/text(),
    'type': $node/@type
  }

return $data
