import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer bounceSnd, hitSnd, loseSnd;


//import processing.sound.*;


//SoundFile bounceSnd, hitSnd;

boolean debug = true;
boolean pause = false;
boolean mute = false;

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

String scoreMode = "circle";

float bg;

color c1, c2, c3, c4, ballColor;

boolean armFree; //keep track of whether the arm is allowed to move (so ball doesnt get stuck)
int lastBounce, bounceThresh;  
float ballRad; //keep track of the largest ballSize variable (for collisions)

void setup() {
  size(1920, 1080);
  c1 = color(200, 250, 250);
  c2 = color(250, 200, 200);
  c3 = color(50, 50, 50);
  c4 = color(240, 240, 240);
  ballColor = c3;
  
  lastBounce = 5;
  bounceThresh = 1;
  armFree = true;
  
  
  minim = new Minim(this);
  bounceSnd = minim.loadFile("38867__m-red__clock-tac.wav", 2048);
  hitSnd = minim.loadFile("Hit_Hurt26.wav", 2048);
  loseSnd = minim.loadFile("253174__suntemple__retro-you-lose-sfx.wav", 2048);
  if (mute){
    bounceSnd.mute();
    hitSnd.mute();
    loseSnd.mute();
  }
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
  mouseFDiff = 25;
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
  ball = new PVector(points[1].x, points[1].y - width/5);
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
  mouseForce.mult(mouseFDiff + 0);
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
  //rect(0, 0, width * value/5, 20); //top meter
  fill(c4);
  float txtSize = constrain(score * 10, 10, 600);
  textAlign(CENTER);
  if (!pause){
    textSize(txtSize);
    text("" + score, width/2, height/2);
  } else {
    textSize(400);
    text("[ PAUSED ]", width/2, height/2);
  }


  //draw paddle / clockhands/whatever
  fill(c3);
  beginShape();
  curveVertex(points[0].x, height* 0.98);
  for (int i = 0; i < points.length; i++) {
    curveVertex(points[i].x, points[i].y);
    ellipse(points[i].x, points[i].y, i * 20, i * 20); 
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

  fill(ballColor);
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
  
  
  points[0].set(mouseX, mouseY);
  points[1].add(gravity);


  if (debug) println();
}

void mousePressed() {
  movePos = true;
  mouse.set(mouseX, mouseY);
}



void keyPressed() {
  pause = !pause;
  
  if (pause){
    fill(c4 );
    textSize(300);
    text("[ PAUSED ]", width/2, height/1.3);
    noLoop();
  } else {
   loop(); 
  }
}