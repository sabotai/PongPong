

void squeeze(){
  //print("go small ... ");
  float limit =70;
  //float diff = (100 - limit) / frameRate;
  float diff =  (ballSize.y - limit) / (frameRate/1.2); //now its how many pixels each frame for even split
  //diff *= 1.5;//; //get % of limit each frame
  PVector smBallSize = new PVector(130, limit);
  
  if (ballSize.y >= limit+5){
    ballSize.lerp(smBallSize, diff);
    //println("diff = " + diff);
    //ballSize.y -= diff;
  } else {
    ballSize.y = limit;
   squee = false;
   squoo = true;
  }
}

void squooze(){
  //print("go big ... ");
  float limit = 100; 
  
  float diff = (limit - ballSize.y ) / (frameRate/1.2);
  //float diff =  (limit - 70) / (frameRate/60);
  //diff /= limit;
  //float diff = (frameRate/3) / (limit - 30) ;
  
  PVector lrgBallSize = new PVector(limit, limit);
  
  if (ballSize.y <= limit-5){
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