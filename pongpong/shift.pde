

void repose() {
  //move the central circle border
  
  float threshh = 10;
  if (mouse.dist(points[1]) < threshh) {
    movePos = false;
  } else {
    
    points[1] = PVector.lerp(points[1], mouse, 0.1);
  if (scoreMode.equals("circle")) checkCircle();
    //points[1].set(mouseX, mouseY);
  }
}