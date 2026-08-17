package com.queue.analyzer;

import javax.swing.*;
import java.awt.*;
import java.io.*;
import java.util.*;
import java.util.List;
import javax.swing.table.DefaultTableModel;

public class QueueAnalyzerMain extends JFrame {
    private DefaultTableModel tableModel;
    private JTable dataTable;
    private JTextArea logArea;

    public QueueAnalyzerMain() {
        setTitle("Java Queue Analyzer Tool");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        // Initialize UI components
        JPanel mainPanel = new JPanel(new BorderLayout());
        JSplitPane splitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT);

        // Table for displaying metrics
        String[] columnNames = {"Metric", "Value"};
        tableModel = new DefaultTableModel(columnNames, 0);
        dataTable = new JTable(tableModel);
        JScrollPane tableScroll = new JScrollPane(dataTable);
        splitPane.setTopComponent(tableScroll);

        // Log area for status messages
        logArea = new JTextArea();
        logArea.setEditable(false);
        JScrollPane logScroll = new JScrollPane(logArea);
        splitPane.setBottomComponent(logScroll);

        mainPanel.add(splitPane, BorderLayout.CENTER);
        add(mainPanel);

        // Simulate loading data
        simulateDataLoading();
    }

    private void simulateDataLoading() {
        // Sample data representing queue metrics
        List<String[]> data = Arrays.asList(
            new String[]{"Average Waiting Time", "2.5 mins"},
            new String[]{"Average Service Time", "1.2 mins"},
            new String[]{"Max Queue Length", "45"},
            new String[]{"Server Utilization", "85%"},
            new String[]{"Bottleneck Identified", "Server 3"},
            new String[]{"Throughput", "120 jobs/min"}
        );

        for (String[] row : data) {
            tableModel.addRow(row);
        }

        logArea.setText("Data loaded successfully.\nSimulation metrics visualized.\nReady for analysis.");
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            try {
                UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
            } catch (Exception e) {
                e.printStackTrace();
            }
            new QueueAnalyzerMain().setVisible(true);
        });
    }
}
