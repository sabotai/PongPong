import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer bounceSnd, hitSnd, loseSnd, rumbleSnd;

PShader shader1;

PFont myFont;

//import processing.sound.*;


//SoundFile bounceSnd, hitSnd;

boolean debug = false;
boolean pause = false;
boolean mute = false;
boolean reset = false;

PVector ball, ballSpeed, ballSize;
PVector gravity;
PVector[] points = new PVector[2];
PVector hourHand = new PVector();
float angle, hourAngle;
boolean above, left;
int score = 0;
boolean angleUp;
float value = 0;
int scaleStr;
float clockDia;

boolean squee, squoo;
PVector mouseForce;
float mouseFDiff;

PVector ballTrail[] = new PVector[30];

float shakeTime;
boolean movePos;

PVector mouse;

String scoreMode = "circle";

float bg;

color c1, c2, c3, c4, c5, ballColor;

boolean armFree; //keep track of whether the arm is allowed to move (so ball doesnt get stuck)
int lastBounce, bounceThresh;  
float ballRad; //keep track of the largest ballSize variable (for collisions


PVector xInter = new PVector(0, 0);
PVector yInter = new PVector(0, 0);
PVector xyDist = new PVector(0, 0);
PVector xyInter = new PVector(0, 0); //xyinter represents the closest inter to the ball

PImage txtr;
float strokeDiff;

void setup() {
  size(1920, 1080, P2D);
  smooth(8); //may not work everywhere
  //frameRate(60);
    minim = new Minim(this);
  if (!reset) {
    rumbleSnd = minim.loadFile("57532__dolfeus__earthshake-7kick8.wav");
    bounceSnd = minim.loadFile("38867__m-red__clock-tac.wav", 2048);
    hitSnd = minim.loadFile("Hit_Hurt26.wav", 2048);    rumbleSnd.setGain(-9);
    txtr = loadImage("bricks.jpg");
    shader1 = loadShader("glow_static.frag");
    myFont = createFont("neuropol.ttf", 180);
    textMode(SHAPE);
    textFont(myFont);
  } else {
    loseSnd = minim.loadFile("253174__suntemple__retro-you-lose-sfx.wav", 2048);
    loseSnd.rewind();
    loseSnd.play(); 
  }
  if (mute) {
    bounceSnd.mute();
    hitSnd.mute();
    loseSnd.mute();
  }
  shader1.set("u_resolution", float(width), float(height));
  shader1.set("u_color", 0.1f, 0.75f);
  shader1.set("u_mouse", mouseX, mouseY);
  c1 = color(200, 250, 250); //0.784, 0.98, 0.98
  c2 = color(250, 200, 200); //0.98, 0.784, 0.784
  c3 = color(50, 50, 50);
  c4 = color(240, 240, 240);
  c5 = color(255, 255, 255);
  ballColor = c3;
  hourAngle = 1;
  clockDia = width;

  lastBounce = 5;
  bounceThresh = 1;
  armFree = true;
  if (debug) println("SETUP");

  bg = 250;
  //strokeCap(PROJECT);
  movePos = false;
  shakeTime = 0;
  squee = false;
  mouseFDiff = 25;
  strokeDiff = 15;
  //noStroke();
  gravity = new PVector(0, 0.4);

  for (int i = 0; i < ballTrail.length; i++) {
    ballTrail[i] = new PVector(i, i);
  }

  ballSpeed = new PVector(10, -10);
  ballSize = new PVector(100, 100);
  above = true;
  if (points[0] == null) {
    //for (int i = 0; i < points.length; i++) {
    //randomly on bottom half of screen
    points[0] = new PVector(random(0, width), random(height/2, height));
    points[1] = new PVector(width/2, height/1.3);
  ball = new PVector(points[1].x, points[1].y - width/5);
    //}
  } else {
    mouse.set(random(width/3, width/1.5), random(height/2, height));
    movePos = true;
    repose();
    ball = new PVector(mouse.x, mouse.y - width/5);
  }
  hourHand = new PVector(points[1].x, points[1].y - width/4); 
  scaleStr = 10;
  mouseForce = new PVector((mouseX - pmouseX), (mouseY - pmouseY));
  mouse = new PVector(mouseX, mouseY);
  reset = true;
}









void draw() {
  if (debug) { 
    ballSpeed.set(0, 0);
    gravity.set(0, 0);
    scaleStr = 10000;
    clockDia = 1000000;
    print(frameCount + " ");
  }
  background(c1);
  runShader(shader1);
  calcMForce();
  updateBall();
  drawClock();
  drawHands();
  drawScore();
  drawBall(true);
  repose(); //move clock

  if (mousePressed) {
    mouse.set(mouseX, mouseY);
  }

  updateClock();


  if (debug) println();

  /*
  fill(150);
   strokeWeight(150);
   //noStroke();
   //ellipse(mouseX, mouseY, 1000, 1000);
   textSize(200);
   fill(c2);
   stroke(c2);
   text("fr=" + (int)frameRate, width/2, height/2);
   */
}

void mousePressed() {
  movePos = true;
  mouse.set(mouseX, mouseY);
}




void keyPressed() {
  pause = !pause;

  if (pause) {
    fill(c4 );
    textSize(300);
    text("[ PAUSED ]", width/2, height/1.3);
  } else {
    loop();
  }
}