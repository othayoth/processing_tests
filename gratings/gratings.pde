int rows = 2;          // Number of rows
int cols = 4;          // Number of columns
int panelWidth;        // Width of each panel
int panelHeight;       // Height of each panel
GratingPanel[][] panels; // Array to hold panel objects

void setup() {
  size(800, 400); // Canvas size
  panelWidth = width / cols;
  panelHeight = height / rows;
  
  // Initialize the panels
  panels = new GratingPanel[rows][cols];
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      panels[row][col] = new GratingPanel(col * panelWidth, row * panelHeight, panelWidth, panelHeight);
      panels[row][col].start(); // Start each panel's thread
    }
  }
}

void draw() {
  background(0); // Clear the background
  
  // Draw each panel
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      panels[row][col].display();
    }
  }
  
  // Display the frame rate
  fill(255);  // White text
  textSize(16);
  text("Frame Rate: " + nf(frameRate, 1, 2) + " FPS", 10, height - 10);
}

void keyPressed() {
  // Use keys 1-8 to control each panel's speed and direction
  for (int i = 0; i < rows * cols; i++) {
    int row = i / cols;
    int col = i % cols;
    if (key == (char) ('1' + i)) {
      panels[row][col].toggleDirection();
    }
    
    if(key == (char)('a'))
    {
      panels[row][col].faster();
    }
    if(key == (char)('d'))
    {
      panels[row][col].slower();
    }
  }
}

// Panel Class
class GratingPanel extends Thread {
  int x, y, w, h;        // Panel position and size
  int stripeWidth = 20;  // Width of each stripe
  int speed = 5;         // Speed of grating movement
  int offset = 0;        // Offset for animation
  PGraphics grating, mask; // Graphics objects for drawing
  
  GratingPanel(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    // Create graphics objects
    grating = createGraphics(w, h);
    //mask = createGraphics(w, h);
    //createMask();
  }
  
  void faster()
  {
    this.speed++;
  }
  
  void slower()
  {
    this.speed--;
  }
  // Create a circular mask
  void createMask() {
    mask.beginDraw();
    mask.background(0); // Fully transparent background
    mask.fill(255);     // White for the circular area
    mask.noStroke();
    mask.ellipse(w / 2, h / 2, min(w, h), min(w, h)); // Circular mask
    mask.endDraw();
  }
  
  // Animation loop for this panel
  public void run() {
    while (true) {
      offset = (offset + speed) % (stripeWidth * 2); // Update offset
      drawGrating();
      try {
        Thread.sleep(16); // Approx. 60 FPS
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }
  }
  
  // Draw the grating
  void drawGrating() {
    grating.beginDraw();
    grating.background(0); // Black background for outside the circle
    for (int i = -offset; i < w; i += stripeWidth * 2) {
      grating.fill(255); // White stripes
      grating.noStroke();
      grating.rect(i, 0, stripeWidth, h);
    }
    grating.endDraw();
    //grating.mask(mask); // Apply the mask
  }
  
  // Display this panel
  void display() {
    image(grating, x, y);
  }
  
  // Toggle direction
  void toggleDirection() {
    speed = -speed;
  }
}
