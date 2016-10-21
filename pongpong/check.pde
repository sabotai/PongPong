
void aboveLine(PVector b, PVector bS, PVector pt1, PVector pt2) {
  float w = pt2.x - pt1.x;
  value = int(abs(5 * (100/w)));
  //println(value);
  //if (w > 100){ //distance too great to make points
      fill(255-abs(w));
  //}
    
    
  if ((b.x > pt1.x && b.x < pt2.x) || (b.x > pt2.x && b.x < pt1.x)){
    float pct = (b.x - pt1.x) / w; //percent traveled along x axis of line
    //println("pct = " + pct);
    PVector inter = PVector.lerp(pt1, pt2, pct);
    if (inter.y - ballSize.y/2 > b.y){ //currently above the line
      if (!above){ //if just crossed from below
      println("just crossed from below");
       //ballSpeed.y *= -1; 
       //ball.y = inter.y - 100;
      }
     above = true; 
      //fill(200, 50, 50);
    } else {
      if (above){
      println("just crossed from above");
     
       ballSpeed.x *= 1.1;
      
       ballSpeed.y *= -1.05;  
       //ballSpeed.sub(gravity);
       score+= value;
       scaleStr+=10;
       println("scored! score=" + score);
       //ball.y = inter.y + 1;      
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
    ball.x = ballSize.x/2;
    ballSpeed.x *= -rem; 
    ballSpeed.y *= rem;
  }
  if (ball.x > width - ballSize.x/2) { //right wall
    ball.x = width- ballSize.x/2;
    ballSpeed.x *= -rem; 
    ballSpeed.y *= rem;
  }

  if (ball.y < ballSize.y/2) { //top
    ball.y = ballSize.y/2;
    ballSpeed.x *= rem; 
    ballSpeed.y *= -rem;
  }

  if (ball.y > height - ballSize.y/2) { //bottom
  /*
    ball.y = height - ballSize.y/2;
    ballSpeed.x *= rem; 
    ballSpeed.y *= -rem;
    */
    //score-= value;
    score = 0;
    println("lost 1... score=" + score);
    background(100);
    setup();
  }
}