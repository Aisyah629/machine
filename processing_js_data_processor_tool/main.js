/**
 * Processing.js Data Processor Tool
 * 
 * This script processes and visualizes data using Processing.js.
 */

var data = [];
var processedData = [];
var visualizationMode = 'bar'; // Options: 'bar', 'scatter', 'line'

function setup() {
  // Create a canvas
  var canvas = createCanvas(800, 600);
  canvas.parent('canvas-container');

  // Sample data for demonstration
  data = generateSampleData();

  // Process the data
  processData();

  // Initial draw
  draw();
}

function draw() {
  background(255);

  // Draw based on the current visualization mode
  if (visualizationMode === 'bar') {
    drawBarChart();
  } else if (visualizationMode === 'scatter') {
    drawScatterPlot();
  } else if (visualizationMode === 'line') {
    drawLineChart();
  }

  // Draw UI elements
  drawUI();
}

function generateSampleData() {
  var data = [];
  for (var i = 0; i < 10; i++) {
    data.push({
      label: 'Item ' + (i + 1),
      value: random(10, 100)
    });
  }
  return data;
}

function processData() {
  processedData = data.map(function(d) {
    return {
      label: d.label,
      value: d.value * 1.1 // Simple transformation
    };
  });
}

function drawBarChart() {
  var barWidth = 50;
  var barHeightScale = 5;

  for (var i = 0; i < processedData.length; i++) {
    var d = processedData[i];
    var x = i * (barWidth + 10) + 50;
    var y = height - d.value * barHeightScale - 50;
    var h = d.value * barHeightScale;

    fill(135, 206, 235); // Light blue
    rect(x, y, barWidth, h);

    // Draw label
    fill(0);
    textSize(12);
    text(d.label, x, height - 20);

    // Draw value
    text(d.value.toFixed(2), x + barWidth / 2 - 10, y - 10);
  }
}

function drawScatterPlot() {
  for (var i = 0; i < processedData.length; i++) {
    var d = processedData[i];
    var x = i * 50 + 50;
    var y = height - d.value * 5 - 50;

    fill(255, 100, 100); // Light red
    ellipse(x, y, 10, 10);

    // Draw label
    fill(0);
    textSize(12);
    text(d.label, x - 15, y + 20);
  }
}

function drawLineChart() {
  stroke(135, 206, 235);
  strokeWeight(2);
  noFill();

  beginShape();
  for (var i = 0; i < processedData.length; i++) {
    var d = processedData[i];
    var x = i * 50 + 50;
    var y = height - d.value * 5 - 50;
    vertex(x, y);
  }
  endShape();
}

function drawUI() {
  fill(0);
  textSize(16);
  text('Processing.js Data Processor', 20, 30);

  // Buttons
  fill(100);
  noStroke();
  rect(20, 500, 100, 30);
  fill(255);
  text('Bar Chart', 25, 520);

  rect(130, 500, 100, 30);
  text('Scatter', 135, 520);

  rect(240, 500, 100, 30);
  text('Line', 245, 520);
}

function mousePressed() {
  if (mouseX >= 20 && mouseX <= 120 && mouseY >= 500 && mouseY <= 530) {
    visualizationMode = 'bar';
    redraw();
  } else if (mouseX >= 130 && mouseX <= 230 && mouseY >= 500 && mouseY <= 530) {
    visualizationMode = 'scatter';
    redraw();
  } else if (mouseX >= 240 && mouseX <= 340 && mouseY >= 500 && mouseY <= 530) {
    visualizationMode = 'line';
    redraw();
  }
}
