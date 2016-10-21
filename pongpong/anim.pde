

void squeeze() {
  //print("go small ... ");
  float limit =70;
  //float diff = (100 - limit) / frameRate;
  float diff =  (ballSize.y - limit) / (frameRate/1.2); //now its how many pixels each frame for even split
  //diff *= 1.5;//; //get % of limit each frame
  PVector smBallSize = new PVector(130, limit);

  if (ballSize.y >= limit+5) {
    ballSize.lerp(smBallSize, diff);
    //println("diff = " + diff);
    //ballSize.y -= diff;
  } else {
    ballSize.y = limit;
    squee = false;
    squoo = true;
  }
}

void squooze() {
  //print("go big ... ");
  float limit = 100; 

  float diff = (limit - ballSize.y ) / (frameRate/1.2);
  //float diff =  (limit - 70) / (frameRate/60);
  //diff /= limit;
  //float diff = (frameRate/3) / (limit - 30) ;

  PVector lrgBallSize = new PVector(limit, limit);

  if (ballSize.y <= limit-5) {
    ballSize.lerp(lrgBallSize, diff);
    //ballSize.y+= diff;
    //print("diff = " + diff);
  } else {
    //print(" back to normal");
    ballSize.y = 100;
    squoo = false; 
    squee = false;
  }
  //println();
}


void showTrail(float frames, float a, boolean opt) {
  frames = min(frames, ballTrail.length);
  float count = 0;
  if (!opt){
    count = ballTrail.length;
  } else {
   count = frames; 
  }
  
  /*
  if (frames > ballTrail.length) {
    if (frameCount == 1)  println("showTrail: more frames requested than stored in memory");
    return;
  }
  */

  //print("balt ");
  //println(ballTrail);

  PVector[] temp = new PVector[ballTrail.length];
  /*
  temp[1] = ballTrail[0].copy();
   temp[2] = ballTrail[1].copy();
   temp[3] = ballTrail[2].copy();
   temp[4] = ballTrail[3].copy();
   temp[0] = ball;
   
   print("temp ");
   println(temp);
   //arrayCopy(ballTrail,0, temp, 1,4);
   ballTrail[0] = temp[0].copy();
   ballTrail[1] = temp[1].copy();
   ballTrail[2] = temp[2].copy();
   ballTrail[3] = temp[3].copy();
   ballTrail[4] = temp[4].copy();
   */

  for (int i = 0; i < count; i++) {
    if (i > 0) {
      temp[i] = ballTrail[i-1].copy();
    } else {
      temp[0] = ball;
    }
  }

  for (int i = 0; i < count; i++) {
    ballTrail[i] = temp[i].copy();

    if (i < frames) {
      fill(0, (frames/(i+1)) * a);
      ellipse(ballTrail[i].x, ballTrail[i].y, ballSize.x, ballSize.y);
    }
  }

  //print("temp ");
  //println(temp);


  //println();
}