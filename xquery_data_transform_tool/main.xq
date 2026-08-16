xquery version "3.1";

(: Import necessary modules if any. This is a standalone example. :)

(: Define the main function to process XML data for compliance reporting. :)
(: Parameters: xml-data as the input XML document. :)
(: Returns a validation report in XML format. :)

declare function local:validate-xml($xml-data as document-node()) as document-node() {
  let $report := doc-available($xml-data)
  let $root-name := $xml-data/*[1]/name()
  let $element-count := count($xml-data//*)
  let $schema-valid := true  (: Placeholder for actual schema validation logic :)
  
  let $compliance-status := 
    if ($root-name = "Invoice" and $schema-valid) then "Valid"
    else if ($root-name = "Invoice") then "Schema Invalid"
    else "Unknown"
  
  let $report-xml := 
    <compliance-report>
      <input-document>
        <name>{$root-name}</name>
        <element-count>{$element-count}</element-count>
      </input-document>
      <validation-result>
        <schema-valid>{$schema-valid}</schema-valid>
        <status>{$compliance-status}</status>
      </validation-result>
      <timestamp>{format-dateTime(current-dateTime(), "[Y0001]-[M01]-[D01]T[h01]:[m01]:[s01]")}</timestamp>
    </compliance-report>
  ;
  
  return $report-xml
};

(: Example usage and execution :)
(: Assume an input XML document is provided via context or external parameter. :)
(: For demonstration, we create a sample XML node. :)

let $sample-invoice := 
  <Invoice id="12345">
    <VendorName>Acme Corp</VendorName>
    <Items>
      <Item>
        <Description>Widget A</Description>
        <Quantity>10</Quantity>
        <Price>5.00</Price>
      </Item>
    </Items>
  </Invoice>

(: Run the validation function on the sample data. :)
local:validate-xml($sample-invoice)
