# Clojure Dataset Cleaning and Text Formatting Tool

## Overview
This is a robust, functional Clojure tool designed for automated dataset cleaning and text formatting. It provides a pipeline of operations to handle common data quality issues such as missing values, inconsistent casing, and formatting irregularities.

## Features
- **Data Cleaning:** Removes duplicates, handles missing values, and trims whitespace.
- **Text Formatting:** Standardizes casing, removes extra spaces, and formats dates/numbers.
- **Pipelined Processing:** Uses a functional pipeline approach for composable operations.
- **Extensible:** Easy to add new cleaning and formatting rules.

## Installation
1. Ensure [Clojure](https://clojure.org/guides/install_clojure) is installed.
2. Add the following dependency to your `project.clj` if needed (standard library is sufficient for this tool).

## Usage
The main entry point is `clojure_tool.main`.

### Example

```clojure
(require '[clojure.dataframe.core :as df])
(require '[clojure.string :as str])

;; Sample dataset
(def data [
  {:id 1 :name "  Alice  " :age 30 :email "alice@example.com" :status "active"}
  {:id 2 :name "Bob" :age nil :email "bob@example.com" :status "inactive"}
  {:id 3 :name "  Charlie  " :age 25 :email "charlie@example.com" :status "Active"}
  {:id 1 :name "  Alice  " :age 30 :email "alice@example.com" :status "active"}
])

;; Load the main namespace
(require '[clojure-tool.main :as ct])

;; Clean the dataset
(def cleaned-data (ct/clean-dataset data))

;; Format the cleaned dataset
(def formatted-data (ct/format-dataset cleaned-data))

;; Output the results
(println "Cleaned Data:" cleaned-data)
(println "Formatted Data:" formatted-data)
```

## Functions
- `clean-dataset`: Applies cleaning rules (trim, remove duplicates, fill nil).
- `format-dataset`: Applies formatting rules (casing, date/number formatting).

## Contributing
Feel free to submit issues and enhancement requests.
