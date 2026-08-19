ns clojure-tool.main
  (:require [clojure.string :as str] [clojure.set :as set])

(defn trim-string
  "Trims whitespace from a string."
  [s]
  (if (string? s)
    (str/trim s)
    s))

(defn normalize-case
  "Converts string to lower case, or title case for names."
  [k v]
  (cond
    (and (keyword? k) (string? v))
    (let [k-str (name k)]
      (if (#{"name" "email"} k-str)
        [(keyword k-str) (str/lower-case v)]
        [(keyword k-str) v]))
    :else
    [k v]))

(defn clean-row
  "Cleans a single data row."
  [row]
  (let [trimmed-name (trim-string (get row :name ""))]
    (-> row
        (assoc :name trimmed-name)
        (update :age #(if (nil? %) 0 %))
        (update :status #(if (string? %) (trim-string %) %)))))

(defn clean-dataset
  "Cleans a dataset by trimming strings, filling nils, and removing duplicates."
  [dataset]
  (let [cleaned (mapv clean-row dataset)
        unique (distinct cleaned)]
    unique))

(defn format-dataset
  "Formats the cleaned dataset."
  [dataset]
  (mapv (fn [row]
          (-> row
              (update :name (fn [n] (if (string? n) (str/trim n) n)))
              (update :status (fn [s] (if (string? s) (str/capitalize (str/trim s)) s)))))
        dataset))

(defn -main
  "Entry point for the tool."
  [& args]
  (let [sample-data [
                      {:id 1 :name "  Alice  " :age 30 :email "alice@example.com" :status "active"}
                      {:id 2 :name "Bob" :age nil :email "bob@example.com" :status "inactive"}
                      {:id 3 :name "  Charlie  " :age 25 :email "charlie@example.com" :status "Active"}
                      {:id 1 :name "  Alice  " :age 30 :email "alice@example.com" :status "active"}
                      ]
        cleaned (clean-dataset sample-data)
        formatted (format-dataset cleaned)]
    (println "=== Original Data ===")
    (println sample-data)
    (println "\n=== Cleaned Data ===")
    (println cleaned)
    (println "\n=== Formatted Data ===")
    (println formatted)))
