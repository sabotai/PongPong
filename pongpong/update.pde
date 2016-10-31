


void updateBall(){
 
  
  ballRad = max(ballSize.x, ballSize.y) / 2;
  lastBounce++;
  shake((abs(ballSpeed.x) + abs(ballSpeed.y))/10);
  
  
  ballSpeed.add(gravity);//
  
  checkLine(ball, ballSize, points[1], points[0], true);
  PVector extPt = PVector.lerp(points[1], points[0], 1000000.0);
  checkLine(ball, ballSize, points[1], extPt, false);
  checkWalls();
  if (scoreMode.equals("circle")) checkCircle();
    updatePos();
  //animate the ball squish
  if (squee) squeeze(); 
  if (squoo) squooze(); 
  
}

void updateClock(){
 
  points[0].set(mouseX, mouseY);
  points[1].add(gravity); 
}