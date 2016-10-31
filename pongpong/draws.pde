

void drawHands() {

  //draw paddle / clockhands/whatever
  fill(c3);
  beginShape();
  curveVertex(points[0].x, height* 0.98);
  for (int i = 0; i < points.length; i++) {
    curveVertex(points[i].x, points[i].y);
  }
  curveVertex(points[points.length-1].x, height * 0.98);
  endShape();
  ellipse(points[1].x, points[1].y, 20, 20); 
  line(points[1].x, points[1].y, points[0].x, points[0].y);


  float currentAngle = PVector.angleBetween(points[1], points[0]);
  //divide angle by radius
  float handRad = dist(points[0].x, points[0].y, points[1].x, points[1].y);
  currentAngle = degrees(currentAngle) / handRad;

  println();
  println(" angle= " + angle + " currentAngle= " + currentAngle);
  if (degrees(angle) - degrees(currentAngle) < 2) {
    //angle = 0;
    println("adding ANGLE");
    angle = 0;
    angle -= currentAngle;
  } else {
    println("RESETtING ANGLE");
    angle = 0;
  }
  hourAngle = -angle/6;
  //}


  pushMatrix();
  translate(points[1].x, points[1].y);

  hourHand.set(50, -width/4); 
  float rota = map(sin(frameCount), -1, 1, 0, 360);
  if (debug) print(" degRot= " +rota);
  rotate(-hourAngle/60);
  //draw hour hand
  //fill(random(255), 255, 255);
  beginShape();
  curveVertex(hourHand.x, height/2);
  curveVertex(hourHand.x, hourHand.y);
  curveVertex(0, 0);
  //ellipse(hourHand.x, hourHand.y, 100, 100);
  //curveVertex(points[1].x, points[1].y);
  curveVertex(hourHand.x, height/2);
  endShape();

  line(0, 0, hourHand.x, hourHand.y);
  popMatrix();

  /* OLD HOUR HAND
   
   hourHand.set(points[1].x-5, points[1].y - width/4); 
   //draw hour hand
   //fill(random(255), 255, 255);
   beginShape();
   curveVertex(hourHand.x, height* 0.98);
   curveVertex(hourHand.x, hourHand.y);
   curveVertex(points[1].x, points[1].y);
   //ellipse(hourHand.x, hourHand.y, 100, 100);
   //curveVertex(points[1].x, points[1].y);
   line(points[1].x, points[1].y, hourHand.x, hourHand.y);
   curveVertex(hourHand.x, height * 0.98);
   endShape();
   
   */
}

void drawBall(boolean trail) {

  fill(ballColor);
  ellipse(ball.x, ball.y, ballSize.x, ballSize.y);

  if (trail) {
    float totSpeed = abs(ballSpeed.x) + abs(ballSpeed.y);
    totSpeed /= 10.0;
    //println("totSpeed = " + totSpeed);
    showTrail(totSpeed, 5, false);
  }
}


void drawClock(){
 
  //clock face attempt
  fill(bg);
  bg = 255;
  if (scoreMode == "circle" ) {
    strokeWeight(scaleStr);
    stroke(200, 250, 250);
    stroke(c3);
    fill(c2);
    //noFill(); //see through
    ellipse(points[1].x, points[1].y, width, width);
  } 
  
}

void drawScore(){
    noStroke();
  fill(0);
  //rect(0, 0, width * value/5, 20); //top meter
  fill(c4);
  float txtSize = constrain(score * 10, 10, 600);
  textAlign(CENTER);
  if (!pause) {
    textSize(txtSize);
    text("" + score, width/2, height/2);
  } else {
    textSize(400);
    text("[ PAUSED ]", width/2, height/2);
  }

}


void drawDebug(){
  
    int oldFill = g.fillColor;
    
    float totDist = abs(xyDist.x) + abs(xyDist.y);
    float bal = abs(xyDist.x) / totDist;
    
    //disregard if one of them is valued at 0
    if (dist(yInter.x, yInter.y, 0, 0) < 1){
      bal = 0;
    } 
    if (dist(xInter.x, xInter.y, 0, 0) < 1){
      bal = 1;
    }
    println();
    println();
    println(" bal= " + bal + " totDist= " + totDist);
    println();
    xyInter.set(lerp(xInter.x, yInter.x, bal ), lerp(xInter.y, yInter.y, bal));
    
    if (debug){
    //store and restore old color... display debug indicator of where intersection would be
    fill(0, 255, 0);
    ellipse(yInter.x, yInter.y, 50, 50);
    //}

    //if (xInter != new PVector(0,0)){
    fill(255, 0, 0);
    ellipse(xInter.x, xInter.y, 50, 50);
    //}
    
    fill(0, 0, 255);
    ellipse(xyInter.x, xyInter.y, 15, 15);
    fill(oldFill);
}
}