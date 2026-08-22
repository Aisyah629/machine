package org.example.xtend.dataprocessor

import java.util.ArrayList
import java.util.List
import java.util.stream.Collectors

class DataProcessor {

    public static def processData(List<String> data) {
        if (data === null || data.isEmpty()) {
            return new ArrayList<String>()
        }

        val filtered = data.stream()
            .filter[ s | !s.isEmpty() ]
            .collect(Collectors.toList())

        val processed = new ArrayList<String>()
        for (item : filtered) {
            val trimmed = item.trim()
            if (trimmed.length > 0) {
                processed.add(trimmed.toUpperCase())
            }
        }
        return processed
    }

    public static def main(String[] args) {
        val sampleData = new ArrayList<String>()
        sampleData.add("  hello  ")
        sampleData.add("world")
        sampleData.add("")
        sampleData.add(" xtend  ")
        sampleData.add("data")

        val result = processData(sampleData)
        System.out.println("Processed Data:")
        for (item : result) {
            System.out.println("- " + item)
        }
    }
}
