
void aboveLine(PVector b, PVector bS, PVector pt1, PVector pt2) {
  float w = pt2.x - pt1.x;
  value = int(abs(5 * (100/w)));
  //println(value);
  //if (w > 100){ //distance too great to make points
  fill(255-abs(w));
  //}


  if ((b.x > pt1.x && b.x < pt2.x) || (b.x > pt2.x && b.x < pt1.x)) {
    float pct = (b.x - pt1.x) / w; //percent traveled along x axis of line
    //println("pct = " + pct);
    PVector inter = PVector.lerp(pt1, pt2, pct);
    if (inter.y - ballSize.y/2 > b.y) { //currently above the line
      if (!above) { //if just crossed from below
        println("just crossed from below");
        //ballSpeed.y *= -1; 
        //ball.y = inter.y - 100;
      }
      above = true; 
      //fill(200, 50, 50);
    } else {
      if (above) {
        println("just crossed from above");
        bounce(1.1, -1.05, true);
      }
      above = false; 
      // fill(50,200,50);
    }
    //println("above = " + above);
    //ellipse(inter.x, inter.y, 50, 50);
  } else {
    //fill(255);
  }
}

void checkWalls() {
  float rem = 0.9;

  if (ball.x < ballSize.x/2) { //left wall
    bounce(-rem, rem, false);
    ball.x = ballSize.x/2;
    //ballSpeed.x *= -rem; 
    //ballSpeed.y *= rem;

    shakeTime+=0.5;
  }
  if (ball.x > width - ballSize.x/2) { //right wall
    bounce(-rem, rem, false);
    ball.x = width- ballSize.x/2;
    shakeTime+=0.5;
  }

  if (ball.y < ballSize.y/2) { //top
    bounce(rem, -rem, false);
    ball.y = ballSize.y/2;
    shakeTime+=0.5;
  }

  if (ball.y > height - ballSize.y/2) { //bottom

    bounce(rem, -rem, false);
    ball.y = height - ballSize.y/2;


    if (!scoreMode.equals("circle")) {
      score = 0;
      hitSnd.stop();
      bounceSnd.stop();
      println("lost 1... score=" + score);
      background(100);
      setup();
    }
  }
}


void checkCircle() {

  float cirDist = ball.dist(points[1]);
  //println("cirdist = " + cirDist);
  float cirThresh = (width/2)-ballSize.x;

  if (cirDist > cirThresh) {
    if (scoreMode.equals("circle")) {


      if (scaleStr <= 0) {
        score = 0;
        println("lost 1... score=" + score);
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
        }
        if (findDir().equals("up") || findDir().equals("down")) {
          bounce(1, -1, false);
        }

        //find most recent ball position that was inside the circum
        int insidePt = 0;
        for (int i = 0; i < ballTrail.length; i++) {
          if (ballTrail[i].dist(points[1]) < cirThresh) {
            insidePt = i;
            println("using ballTrail " + i);
          }
        }
        //ball = ballTrail[3];
        bg = 220;
        //hitSnd.stop();
          hitSnd.play();
        
        
        println("BOUNCE");
      }
    }
  }
}