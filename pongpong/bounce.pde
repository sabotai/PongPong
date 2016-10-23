

void bounce(float xs, float ys, boolean scoring) {
  float pan = (ball.x-width/2) / (width/2); //pan the sound
  rewind(ballSpeed.x, ballSpeed.y);

  if (lastBounce > bounceThresh){// && (ball.dist(ballTrail[0]) > bounceThresh)) { //time since last bounce protection mechanism and more than 2 pixels apart from last loc
    if (debug) print(" BOUNCE");
    float vol = map(abs(ballSpeed.x) + abs(ballSpeed.y), 0, 50, 0, 5 );
    if (debug) print(" vol=" + vol);
    bounceSnd.setGain(-5);
    hitSnd.setGain(vol);
    lastBounce = 0;
    //bounceSnd.setPan(pan);   
    //bounceSnd
    //hitSnd.setPan(pan);
    bounceSnd.rewind();
    bounceSnd.play();
    
    
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
    
    ballSpeed.mult(0.9); //entropy/resistance upon impacts
    PVector randomDir = new PVector(random(0,100), random(0,100), 0);
    randomDir.normalize(); //make a direction
    randomDir.mult(0.1);
    randomDir.add(new PVector(1,1,1)); //make it 1% for mult
    println("");
    print("rando=" + randomDir);
    println("");
    xs *= randomDir.x;
    ys *= randomDir.y;
    
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