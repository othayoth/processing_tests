int circleDiameterInches = 30; // Diameter of the large circle in inches
int spotDiameter = 50;        // Diameter of each white spot in pixels
boolean[] spotStates = new boolean[9]; // States for each spot (on/off)
float radius;                 // Radius of the large circle in pixels

void setup() {
  size(800, 800);            // Canvas size
  background(0);             // Black background
  
  // Calculate radius based on desired circle size
  // Assuming 96 pixels per inch for scaling
  radius = 300;
  
  // Initialize all spots to ON
  for (int i = 0; i < spotStates.length; i++) {
    spotStates[i] = false;
  }
}

void draw() {
  background(0); // Clear background to black
  drawSpots();
}

void drawSpots() {
  // Center of the large circle
  float centerX = width / 2;
  float centerY = height / 2;

  // Draw 9 spots around the edge
  for (int i = 0; i < 9; i++) {
    if (spotStates[i]) { // Only draw if the spot is ON
      float angle = radians(i * 20 + 180); // Angles in radians (0, 40, 80, ..., 320)
      float x = centerX + cos(angle) * radius;
      float y = centerY + sin(angle) * radius;

      fill(255); // White spots
      noStroke();
      ellipse(x, y, spotDiameter, spotDiameter);
    }
  }
}

void keyPressed() {
  // Toggle the state of the spots when keys 1-9 are pressed
  if (key >= '1' && key <= '9') {
    int spotIndex = key; // Map '1'-'9' to indices 0-8
    spotStates[spotIndex] = !spotStates[spotIndex]; // Toggle state
  }
}
