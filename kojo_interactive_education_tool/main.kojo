// Kojo Interactive Education Tool - Main Script
// This script sets up the interactive graphics and mathematical visualization environment.

import org.kijoxo.
import org.kijoxo.math._

// Initialize the Kojo environment
val canvas = new KojoCanvas(800, 600)
canvas.setSize(800, 600)
canvas.setCoordinateSystem(StandardCoordinateSystem)

// Define colors and styles
val greenPen = Pen(green, 2)
canvas.setPenColor(greenPen)

// Function to draw a basic geometric shape (e.g., a circle)
def drawCircle(x: Int, y: Int, radius: Int): Unit = {
  canvas.pen.moveTo(x, y)
  canvas.pen.drawCircle(radius)
}

// Function to simulate a mathematical function visually
def plotFunction(f: Double => Double, start: Double, end: Double, step: Double): Unit = {
  var x = start
  while (x <= end) {
    val y = f(x)
    canvas.pen.lineTo(x, y)
    x += step
  }
}

// Example: Draw a circle and plot a simple sine wave
drawCircle(100, 100, 50)
plotFunction(sin, 0, 2 * math.Pi, 0.1)

// Add interactive elements: allow user to control animation speed
val speedSlider = new Slider(1, 10, 5)

def animateFrame(frameCount: Int): Unit = {
  val rotation = frameCount * speedSlider.getValue * 0.1
  canvas.pen.rotate(rotation)
  canvas.pen.drawCircle(50)
}

// Start the animation loop
canvas.startAnimation(animateFrame, 60) // 60 FPS

// Display the canvas
canvas.setVisible(true)
