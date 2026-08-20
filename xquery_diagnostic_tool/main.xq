xquery version "3.1";

(: XQuery Interactive Diagnostic and Visualization Tool Main Script :)  
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

(: Input: XML Document to be diagnosed or analyzed :)  
(: For this diagnostic tool, we simulate an input document :)  
let $input-doc := <root> 
                     <record id="1"><name>Alice</name><value>100</value></record> 
                     <record id="2"><name>Bob</name><value>200</value></record> 
                     <record id="3"><name>Charlie</name><value>300</value></record> 
                     <error_record id="4"><name/> <value>NaN</value></error_record> 
                  </root>

(: Diagnostic Logic :)  
let $diagnostics := 
   for $record in $input-doc//record
   let $id := $record/@id
   let $name := $record/name/text()
   let $val := $record/value/text()
   let $errors := if (empty($name) or $val castable as xs:decimal) then () else <error>Invalid data for ID {$id}</error>
   return <diag id="{$id}">
             <node type="record">ID: {$id}</node>
             <data name="{$name}" value="{$val}"/>
             { if (exists($errors)) then <issue type="error">{$errors/error/text()}</issue> else <issue type="info">Valid</issue> }
          </diag>

(: Visualization Logic :)  
let $visualization := 
   <visualization type="diagram">
      { 
        for $d in $diagnostics/diag
        let $id := $d/@id
        let $status := $d/issue/@type
        return <node x="{$id * 50}" y="{if ($status = 'error') then 100 else 50}">
                  <label>Record {$id}</label>
                  <status>{$status}</status>
               </node>
      }
   </visualization>

(: Output :)  
<result>
   <title>XQuery Diagnostic Report</title>
   <section name="Diagnostics">
      {$diagnostics}
   </section>
   <section name="Visualization">
      {$visualization}
   </section>
</result>
