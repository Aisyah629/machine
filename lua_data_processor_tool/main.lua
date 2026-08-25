-- Lua Data Processor Tool
-- A robust utility for processing and transforming data structures.

local M = {}

-- Utility: Deep copy a table
define deep_copy
function M.deepcopy(original)
  local copy = {}
  local copymt = {}
  setmetatable(copymt, copymt) -- create recursive metatable
  copymt.__index = copymt
  setmetatable(copy, copymt)

  for k, v in pairs(original) do
    if type(v) ~= 'table' then
      copy[k] = v
    elseif type(v) == 'table' then
      copy[k] = M.deepcopy(v)
    else
      copy[k] = v -- should not happen, but handles functions etc
    end
  end
  return copy
end

-- Utility: Parse a simple CSV string into a list of tables
function M.parse_csv(csv_string, delimiter)
  delimiter = delimiter or ','
  local lines = {}
  for line in csv_string:gmatch('[^\r\n]+') do
    table.insert(lines, line)
  end

  if #lines == 0 then
    return {}
  end

  local headers = M.split_csv_line(lines[1], delimiter)
  local result = {}

  for i = 2, #lines do
    local row = M.split_csv_line(lines[i], delimiter)
    local entry = {}
    for j, header in ipairs(headers) do
      entry[header] = row[j] or ''
    end
    table.insert(result, entry)
  end
  return result
end

-- Helper: Split a CSV line handling basic cases
function M.split_csv_line(line, delimiter)
  local fields = {}
  local field = ''
  local in_quotes = false

  for char in line:gmatch('.') do
    if char == '"' then
      in_quotes = not in_quotes
    elseif char == delimiter and not in_quotes then
      table.insert(fields, field)
      field = ''
    else
      field = field .. char
    end
  end
  table.insert(fields, field)
  return fields
end

-- Utility: Filter a list of records based on a predicate
function M.filter(records, predicate)
  local result = {}
  for _, record in ipairs(records) do
    if predicate(record) then
      table.insert(result, record)
    end
  end
  return result
end

-- Utility: Map a function over a list of records
function M.map(records, func)
  local result = {}
  for _, record in ipairs(records) do
    table.insert(result, func(record))
  end
  return result
end

-- Utility: Transform specific columns in a list of records
function M.transform_columns(records, transformations)
  return M.map(records, function(record)
    local new_record = M.deepcopy(record)
    for column_name, transform_func in pairs(transformations) do
      if new_record[column_name] ~= nil then
        new_record[column_name] = transform_func(new_record[column_name])
      end
    end
    return new_record
  end)
end

-- Example Usage
function M.run_demo()
  local csv_data = [[
Name,Age,City
Alice,30,New York
Bob,25,Paris
Charlie,35,London
David,22,New York
]]

  -- 1. Parse CSV
  local data = M.parse_csv(csv_data)
  print("Parsed Data:")
  for _, row in ipairs(data) do
    print(row.Name .. " is " .. row.Age .. " years old from " .. row.City)
  end

  -- 2. Filter: People over 28
  local filtered = M.filter(data, function(row)
    return tonumber(row.Age) > 28
  end)

  print("\nFiltered Data (Age > 28):")
  for _, row in ipairs(filtered) do
    print(row.Name)
  end

  -- 3. Transform: Uppercase names and double ages
  local transformations = {
    Name = function(name) return string.upper(name) end,
    Age = function(age) return tonumber(age) * 2 end
  }

  local transformed = M.transform_columns(data, transformations)
  print("\nTransformed Data (Upper Names, Double Ages):")
  for _, row in ipairs(transformed) do
    print(row.Name .. ": " .. row.Age .. " (Original: " .. row.Age / 2 .. ")")
  end
end

-- Run if executed directly
if arg and arg[0] == 'main.lua' then
  M.run_demo()
end

return M
