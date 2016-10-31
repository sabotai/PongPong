


void checkLine(PVector b, PVector bS, PVector pt1, PVector pt2, boolean doBounce) {
  float w = pt2.x - pt1.x; 
  float h = pt2.y - pt1.y;
  boolean justCross = false;
  value = int(abs(5 * (100/w))); //currently only showing based on x distances


  xInter.set(0, 0);
  yInter.set(0, 0);
  xyDist.set(0, 0);
  xyInter.set(0, 0); //xyinter represents the closest inter to the ball
  //println(value);
  //if (w > 100){ //distance too great to make points  //}

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


  if (dist(xInter.x, xInter.y, b.x, b.y) < dist(yInter.x, yInter.y, b.x, b.y)) {
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
  float colorBright = (280 - max(red(c3), 255-abs(currentDist))) / 255;
  ballColor = color(red(c1) * colorBright, green(c1) * colorBright, blue(c1) * colorBright); //the color c3 is monochromatic, so just trying to retrieve one of the values


  xyDist.set(xInter.y - b.y, yInter.x - b.x);

  if (!doBounce) drawDebug();
  xyDist = xyDist.normalize();

  print(" justCross=" + justCross);










  if (debug) print(" currentdist= "+ currentDist+ "  prevDist= " + prevDist);
  if (min(prevDist, currentDist) < ballRad) {
    if (justCross) {
      if (debug) print(" ATTEMPT LINE BOUNCE");

      print(" xyDist(neg)=" + xyDist);
      if (doBounce) bounce(xyDist.x, xyDist.y, true);
    }
  }
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
      rumbleSnd.loop(0);
      rumbleSnd.rewind();
      rumbleSnd.play();
  }
  if (ball.x > width - ballRad) { //right wall
    bounce(-rem, rem, false);
    ball.x = width- ballRad - 3;
    shakeTime+=0.5;
    if (debug) print(" ATTEMPT WALL BOUNCE");
      rumbleSnd.loop(0);
      rumbleSnd.rewind();
      rumbleSnd.play();
  }

  if (ball.y < ballRad) { //top
    bounce(rem, -rem, false);
    ball.y = ballRad + 3;
    shakeTime+=0.5;
    if (debug) print(" ATTEMPT WALL BOUNCE");
      rumbleSnd.loop(0);
      rumbleSnd.rewind();
      rumbleSnd.play();
  }

  if (ball.y > height - ballRad) { //bottom

    bounce(rem, -rem, false);
    ball.y = height - ballRad - 3;
    shakeTime+=0.3;
    if (debug) print(" ATTEMPT WALL BOUNCE");
      rumbleSnd.loop(0);
      rumbleSnd.rewind();
      rumbleSnd.play();


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
  float cirThresh = (clockDia/2) - ballRad*2;

  if (cirDist > cirThresh - scaleStr/3) {
    if (scoreMode.equals("circle")) {


      //scaleStr = 10; //debug to stop the game from ending
      if (scaleStr <= 0) {
        loseReset();
      } else {
        println(" STROKE= " + scaleStr);
        println(" STROKE= " + scaleStr);
        println(" STROKE= " + scaleStr);
        println(" STROKE= " + scaleStr);
        println(" STROKE= " + scaleStr);
        //score--;

        scaleStr -= strokeDiff;
        if (scaleStr <= 0) loseReset();
        
        //scaleStr = max(scaleStr, 0);


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
        hitSnd.rewind();
        hitSnd.play();
      }
    }
  }
}