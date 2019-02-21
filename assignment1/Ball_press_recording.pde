/**
 *On the basis of the ArrayList of objects by Daniel Shiffman, I added the recording function to the ball.
 * Click the mouse to add bouncing balls.
 * Click R button to record the animation
 */
boolean recording = false;
ArrayList<Ball> balls;
int ballWidth = 48;

void setup() {
  size(640, 360);
  noStroke();

  // Create an empty ArrayList (will store Ball objects)
  balls = new ArrayList<Ball>();
  
  // Start by adding one element
  balls.add(new Ball(width/2, 0, ballWidth));
}

void draw() {
  background(255, 204, 0);
  for (int i = balls.size()-1; i >= 0; i--) { 
    // cast the object coming out
    Ball ball = balls.get(i);
    ball.move();
    ball.display();
    if (ball.finished()) {
      // Items can be deleted with remove()
      balls.remove(i);
    }
    
  }  
  
  // An arbitrary oscillating rotating animation 
  // so that we have something to render
  for (float a = 0; a < TWO_PI; a+= 0.2) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(a+sin(frameCount*0.004*a));
    stroke(255);
    line(-100, 0, 100, 0);
    popMatrix();
  }
  
  // If we are recording call saveFrame!
  // The number signs (#) indicate to Processing to 
  // number the files automatically
  if (recording) {
    saveFrame("output/frames####.png");
  }
   
  // Let's draw some stuff to tell us what is happening
  // It's important to note that none of this will show up in the
  // rendered files b/c it is drawn *after* saveFrame()
  textAlign(CENTER);
  fill(255);
  if (!recording) {
    text("Press t to start recording.", width/2, height-24);
  } 
  else {
    text("Press t to stop recording.", width/2, height-24);
  }
  
  // A red dot for when we are recording
  stroke(255);
  if (recording) {
    fill(255, 0, 0);
  } else { 
    noFill();
  }
  ellipse(width/2, height-48, 16, 16);
}

void keyPressed() {
  
  // If we press r, start or stop recording!
  if (key == 't' || key == 'T') {
    recording = !recording;
  }
}
void mousePressed() {
  // A new ball object is added to the ArrayList (by default to the end)
  balls.add(new Ball(mouseX, mouseY, ballWidth));
}
