
void checkLine(PVector b, PVector bS, PVector pt1, PVector pt2) {
    int oldFill = g.fillColor;
  float w = pt2.x - pt1.x; 
  float h = pt2.y - pt1.y;
  boolean justCross = false;
  value = int(abs(5 * (100/w))); //currently only showing based on x distances
  //println(value);
  //if (w > 100){ //distance too great to make points
  fill(max(red(c3), 255-abs(w+h))); //the color c3 is monochromatic, so just trying to retrieve one of the values
  //}
  PVector xInter = new PVector(0,0);
  PVector yInter = new PVector(0,0);
  PVector xyDist = new PVector(0,0);
    PVector xyInter = new PVector(0,0); //xyinter represents the closest inter to the ball
  if (debug) print(" balldir="+ findDir() + ",");

  if ((b.x > pt1.x && b.x < pt2.x) || (b.x > pt2.x && b.x < pt1.x)) {
    float pct = (b.x - pt1.x) / w; //percent traveled along x axis of line
    //println("pct = " + pct);
    xInter = PVector.lerp(pt1, pt2, pct);
    if (xInter.y - ballRad > b.y) { //currently above the line
      if (!above) { //if just crossed from below
        if (debug) print(" just hit from below");
        justCross = true;
      }
      above = true; 
    } else { //currently below
      if (above) {
        if (debug) print(" just hit from above");
      justCross = true;
      }
      above = false; 
    }
  } 

  if ((b.y > pt1.y && b.y < pt2.y) || (b.y > pt2.y && b.y < pt1.y)) {
    float pct = (b.y - pt1.y) / h; //percent traveled along y axis of line
    //println("pct = " + pct);
    yInter = PVector.lerp(pt1, pt2, pct);
    if (yInter.x - ballRad > b.x) { //currently above the line
      if (!left) { //if just crossed from below
        if (debug) print(" just hit from right?");
        justCross = true;
      }
      left = true;
    } else { //currently below
      if (left) {
       if (debug) print(" just hit from left?");
        justCross = true;
      }
      left = false;
    }
  }
    
    
    if (dist(xInter.x, xInter.y, b.x, b.y) < dist(yInter.x, yInter.y, b.x, b.y)){
      xyInter = xInter.copy();
      //print(" copying xInter");
    } else {
     xyInter = yInter.copy(); 
      //print(" copying yInter");
    }

    xyDist.set(xInter.dist(b), yInter.dist(b));
    PVector oldxyDist = new PVector(xInter.dist(ballTrail[1]), yInter.dist(ballTrail[1]));
    float currentDist = min(xyDist.x, xyDist.y);
    float prevDist = min(oldxyDist.x, oldxyDist.y);
    
    xyDist.set(xInter.y - b.y, yInter.x - b.x);
    xyDist = xyDist.normalize();
    print(" justCross=" + justCross);
    if (debug) print(" currentdist= "+ currentDist+ "  prevDist= " + prevDist);
    //if (currentDist < prevDist) {
      if (min(prevDist, currentDist) < ballRad) {
        if (justCross){
        //armFree = false;
        if (debug) print(" ATTEMPT LINE BOUNCE");

      //if (debug) print(" ballApproaching");
        //xyDist.mult(1.01); //multiply by some force
        print(" xyDist(neg)=" + xyDist);
        bounce(xyDist.x, xyDist.y, true);
     // }
      }
  } 
  if (debug) {
    
    //if (yInter != new PVector(0,0)){
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
  }
    fill(oldFill);
}

void checkWalls() {
  float rem = 0.9;

  if (ball.x < ballRad) { //left wall
    bounce(-rem, rem, false);
    ball.x = ballRad + 3;
    //ballSpeed.x *= -rem; 
    //ballSpeed.y *= rem;

    if (debug) print(" ATTEMPT WALL BOUNCE");
    shakeTime+=0.5;
  }
  if (ball.x > width - ballRad) { //right wall
    bounce(-rem, rem, false);
    ball.x = width- ballRad - 3;
    shakeTime+=0.5;
    if (debug) print(" ATTEMPT WALL BOUNCE");
  }

  if (ball.y < ballRad) { //top
    bounce(rem, -rem, false);
    ball.y = ballRad + 3;
    shakeTime+=0.5;
    if (debug) print(" ATTEMPT WALL BOUNCE");
  }

  if (ball.y > height - ballRad) { //bottom

    bounce(rem, -rem, false);
    ball.y = height - ballRad - 3;
    if (debug) print(" ATTEMPT WALL BOUNCE");


    if (scoreMode.equals("floor")) {
      score = 0;
      //hitSnd.stop();
      // bounceSnd.stop();
      if (debug) print(" lost 1... score=" + score);
      background(100);
      setup();
    }
  }
}


void checkCircle() {

  float cirDist = ball.dist(points[1]);
  //println("cirdist = " + cirDist);
  float cirThresh = (width/2)-ballRad*2;

  if (cirDist > cirThresh) {
    if (scoreMode.equals("circle")) {


      scaleStr = 10; //debug to stop the game from ending
      if (scaleStr <= 0) {
        score = 0;
        //println("lost 1... score=" + score);
        background(100);
        setup();
      } else {
        //score--;

        scaleStr-=10;
        scaleStr = max(scaleStr, 0);


        ball.sub(ballSpeed);
        ball.sub(ballSpeed);
        if (findDir().equals("left") || findDir().equals("right")) {
          bounce(-1, 1, false);

          if (debug) print(" ATTEMPT CIRCLE BOUNCE");
        }
        if (findDir().equals("up") || findDir().equals("down")) {
          bounce(1, -1, false);
          if (debug) print(" ATTEMPT CIRCLE BOUNCE");
        }

        //find most recent ball position that was inside the circum
        int insidePt = 0;
        for (int i = 0; i < ballTrail.length; i++) {
          if (ballTrail[i].dist(points[1]) < cirThresh) {
            insidePt = i;
            //println("using ballTrail " + i);
          }
        }
        //ball = ballTrail[3];
        bg = 220;
        //hitSnd.stop();
        // hitSnd.play();
      }
    }
  }
}