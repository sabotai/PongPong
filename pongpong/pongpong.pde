PVector ball, ballSpeed, ballSize;
PVector gravity;
PVector[] points = new PVector[2];
boolean above;
int score = 0;
boolean angleUp;
float value = 0;
float scaleStr;

boolean squee, squoo;
PVector mouseForce;
float mouseFDiff;

PVector ballTrail[] = new PVector[30];

void setup() {
  println("SETUP");
  size(1920, 1080);
  strokeCap(PROJECT);
  squee = false;
  mouseFDiff = 10;
  //noStroke();
  gravity = new PVector(0, 0.4);
  ball = new PVector(random(width), height/5);
  
  for (int i = 0; i < ballTrail.length; i++){
    ballTrail[i] = new PVector(i,i);
    
    println(ballTrail);
  }
  
  
 // if (ballSpeed == null){ //dont reset speed unless first time
    ballSpeed = new PVector(10, -10);
 // }
  ballSize = new PVector(100, 100);
  above = true;
  if (points[0] == null){
    for (int i = 0; i < points.length; i++) {
      //randomly on bottom half of screen
      
      points[i] = new PVector(random(0, width), random(height/2, height));
    }
  }
  scaleStr = 100;
  mouseForce = new PVector((mouseX - pmouseX), (mouseY - pmouseY));
  frameRate(60);
}









void draw() {
  //println("fr = " + frameRate);
  background(255);
  //fill(255, 200);
  //rect(0,0,width,height);
  fill(255,0, 0, 0);
  mouseForce.set(mouseX - pmouseX, mouseY - pmouseY);
  mouseForce.normalize();
  mouseForce.mult(mouseFDiff);
  //println("mouseF = " + mouseForce);
  
  //rect(0, 0, width, height); 
  //clock face attempt
  fill(255, 100);
  strokeWeight(scaleStr);
  stroke(255,0,0);
  ellipse(points[1].x, points[1].y, width, width);
  noStroke();
  fill(0);
  rect(0, 0, width * value/5, 20);
  fill(255,0,0);
  textSize(max(10, score));
  textAlign(CENTER);
  text("SCORE: " + score, width/2, height/2);
  
  points[0].set(mouseX,mouseY);
  points[1].add(gravity);

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
  fill(200,50,50);
  beginShape();
  curveVertex(points[0].x, height* 0.98);
  for (int i = 0; i < points.length; i++) {
    curveVertex(points[i].x, points[i].y);
    ellipse(points[i].x, points[i].y, 10, 10); 
    if (i>0) {
      line(points[i].x, points[i].y, points[i-1].x, points[i-1].y);
      aboveLine(ball, ballSize, points[i], points[i-1]);
    }
  }
  curveVertex(points[points.length-1].x, height * 0.98);
  endShape();
  
  if (squee) squeeze(); 
  if (squoo) squooze();
  
  ball.add(ballSpeed);
  ballSpeed.add(gravity);//
  checkWalls();
  //fill(0,100);
  ellipse(ball.x, ball.y, ballSize.x, ballSize.y);
  
  showTrail(10, 5);
  //if (mousePressed) setup(); //reset
  
  if (mousePressed) {
    PVector mouse = new PVector(mouseX, mouseY);
    points[1] = PVector.lerp(points[1], mouse, 0.1);
    //points[1].set(mouseX, mouseY);
  }
}