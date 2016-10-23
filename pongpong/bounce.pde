

void bounce(float xs, float ys, boolean scoring) {
  float pan = (ball.x-width/2) / (width/2); //pan the sound
  rewind(ballSpeed.x, ballSpeed.y);

  if (lastBounce > bounceThresh){// && (ball.dist(ballTrail[0]) > bounceThresh)) { //time since last bounce protection mechanism and more than 2 pixels apart from last loc
    if (debug) print(" BOUNCE");
    lastBounce = 0;
    //bounceSnd.pan(pan);   
    //bounceSnd.stop();
    //bounceSnd.play();
    
    
    //attempt at correcting weird problem which would reverse the ys after being passed in
    switch(findDir()){ 
     case "down": if (ballSpeed.y > 0) ys = abs(ys) * -1; 
      break;
     case "up": if (ballSpeed.y < 0) ys = abs(ys) * -1; 
      break;
      
     case "left": if (ballSpeed.x < 0 && scoring) xs = abs(xs) * -1; 
      break;
     case "right": if (ballSpeed.x > 0 && scoring) ys = abs(ys) * -1; 
      break;
      
    }
    
    
    if (debug) print(" oldSpeed=" + ballSpeed);
    ballSpeed.x *= xs;
    ballSpeed.y *= ys;
    if (debug) print(" newSpeed=" + ballSpeed);


    if (scoring) {
      //score+= value;
      ballSpeed.add(mouseForce);
      if (value >= 0) {
        score++;
      }

      scaleStr+=10;
      //println("scored! score=" + score);
    }

    updatePos();
    if (!squee) {
      squee = true;
      squoo = false;
    } else { 
      squee = false;
      squoo = true;
    }
    
    println("");
    print("    finPos=" + ball);
  } else {
    if (debug) print(" bouncing is for suckas");
    //rewind(xs*15, ys*15);
    if (scoring) {
      ballSpeed.add(mouseForce);
    }//only use mouseSpeed when it hits the arm
    updatePos();
    ballSpeed.mult(1.01);
    //ball.sub(ballSpeed); //move back from frame to prevent ball from getting stuck
  }
}