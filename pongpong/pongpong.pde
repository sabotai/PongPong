import processing.sound.*;


SoundFile bounceSnd, hitSnd;

boolean debug;

PVector ball, ballSpeed, ballSize;
PVector gravity;
PVector[] points = new PVector[2];
boolean above, left;
int score = 0;
boolean angleUp;
float value = 0;
float scaleStr;

boolean squee, squoo;
PVector mouseForce;
float mouseFDiff;

PVector ballTrail[] = new PVector[30];

float shakeTime;
boolean movePos;

PVector mouse;

String scoreMode = "other";

float bg;

color c1, c2, c3, c4;

boolean armFree; //keep track of whether the arm is allowed to move (so ball doesnt get stuck)
int lastBounce, bounceThresh;  
float ballRad; //keep track of the largest ballSize variable (for collisions)

void setup() {
  debug = true;
  c1 = color(200, 250, 250);
  c2 = color(250, 200, 200);
  c3 = color(50, 50, 50);
  c4 = color(240, 240, 240);
  lastBounce = 5;
  bounceThresh = 1;
  size(1920, 1080);
  armFree = true;
  //if (bounceSnd == null){
  //bounceSnd = new SoundFile(this, "Powerup7.wav");
  //}

  // if (hitSnd == null){
  //  hitSnd = new SoundFile(this, "Explosion9.wav");
  // }
  if (debug) println("SETUP");
  bg = 250;
  strokeCap(PROJECT);
  movePos = false;
  shakeTime = 0;
  squee = false;
  mouseFDiff = 10;
  //noStroke();
  gravity = new PVector(0, 0.4);

  for (int i = 0; i < ballTrail.length; i++) {
    ballTrail[i] = new PVector(i, i);
  }

  // if (ballSpeed == null){ //dont reset speed unless first time
  ballSpeed = new PVector(10, -10);
  // }
  ballSize = new PVector(100, 100);
  above = true;
  if (points[0] == null) {
    for (int i = 0; i < points.length; i++) {
      //randomly on bottom half of screen

      points[i] = new PVector(random(0, width), random(height/2, height));
    }
  }
  ball = new PVector(points[0].x, height/5 + points[1].y/3);
  scaleStr = 100;
  mouseForce = new PVector((mouseX - pmouseX), (mouseY - pmouseY));
  frameRate(60);
  mouse = new PVector(mouseX, mouseY);
}









void draw() {
  if (debug) print(frameCount + " ");
  print("ballpos = " + ball);
  ballRad = max(ballSize.x, ballSize.y) / 2;
  lastBounce++;
  shake(ballSpeed.x/10);
  //println("fr = " + frameRate);
  //background(200, 200, bg);
  background(c1);
  //fill(255, 200);
  //rect(0,0,width,height);
  mouseForce.set(mouseX - pmouseX, mouseY - pmouseY);
  mouseForce.normalize();
  mouseForce.mult(mouseFDiff);
  //println("mouseF = " + mouseForce);

  //rect(0, 0, width, height); 
  //clock face attempt
  fill(bg);
  bg = 255;
  if (scoreMode == "circle" ){
    strokeWeight(scaleStr);
    stroke(200, 250, 250);
    stroke(c3);
    fill(c2);
    ellipse(points[1].x, points[1].y, width, width);
  }
  noStroke();
  fill(0);
  rect(0, 0, width * value/5, 20);
  fill(c4);
  float txtSize = constrain(score * 10, 10, 600);
  textSize(txtSize);
  textAlign(CENTER);
  text("" + score, width/2, height/2);

  /*
  float angle = PVector.angleBetween(points[0], points[1]);
   //println("angle= " + angle);
   if (points[1].y > points[0].y){
   angleUp = true; 
   } else {
   angleUp = false; 
   }
   */

  //draw paddle / clockhands/whatever
  fill(c3);
  beginShape();
  curveVertex(points[0].x, height* 0.98);
  for (int i = 0; i < points.length; i++) {
    curveVertex(points[i].x, points[i].y);
    ellipse(points[i].x, points[i].y, 20, 20); 
    if (i>0) {
      line(points[i].x, points[i].y, points[i-1].x, points[i-1].y);
    }
  }
  curveVertex(points[points.length-1].x, height * 0.98);
  endShape();


  ballSpeed.add(gravity);//
  //ballSpeed.set(0, 0);
  checkLine(ball, ballSize, points[1], points[0]);
  checkWalls();
  if (scoreMode.equals("circle")) checkCircle();
  updatePos();
  //animate the ball squish
  if (squee) squeeze(); 
  if (squoo) squooze();

  //fill(0,100);
  ellipse(ball.x, ball.y, ballSize.x, ballSize.y);


  float totSpeed = abs(ballSpeed.x) + abs(ballSpeed.y);
  totSpeed /= 10.0;
  //println("totSpeed = " + totSpeed);
  showTrail(totSpeed, 5, false);

  if (movePos) {
    repose();
  }

  if (mousePressed) {
    mouse.set(mouseX, mouseY);
  }
  
  
  if (armFree) points[0].set(mouseX, mouseY);
  points[1].add(gravity);


  if (debug) println();
}

void mousePressed() {
  movePos = true;
  mouse.set(mouseX, mouseY);
}



void keyPressed() {
  noLoop();
}

void keyReleased() {
  loop();
}