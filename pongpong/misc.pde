

String findDir() {
  String dir = "";

  if (abs(ballSpeed.x) > abs(ballSpeed.y)) { //is x axis speed faster than y
    if (ballSpeed.x > 0) {
      dir = "right";
    } else {
      dir = "left";
    }
  } else {
    if (ballSpeed.y > 0) {
      dir = "down";
    } else {
      dir = "up";
    }
  }

  /*
  if (ballSpeed.x > 0 && ballSpeed.y > 0)
   dir = "downright";
   
   if (ballSpeed.x < 0 && ballSpeed.y > 0)
   dir = "downleft";
   
   if (ballSpeed.x > 0 && ballSpeed.y < 0)
   dir = "upright";
   
   if (ballSpeed.x < 0 && ballSpeed.y < 0)
   dir = "upleft";
   */
  return dir;
}


void runShader(PShader shad) {
  float speeds = (millis()) / 100.0;
  //speeds = 1.0;
  shad.set("u_time", speeds);
  println("ballcolor = " + red(ballColor));
  //shad.set("u_bright", map(red(ballColor), 0.0, 255.0, 0.0, 0.5));
  shad.set("u_bright", dist(xyInter.x, xyInter.y, ball.x, ball.y)/100);
  //shad.set("u_resolution", float(width), float(height));
  shad.set("u_contrast", 0.8, 0.84);
  shad.set("u_size", 0.5);
  //colorMode(RGB, 1.0);
  PVector ccolor = new PVector(red(c3) + 0, green(c3) + 0, blue(c3) + 0);
  ccolor.div(255);
  shad.set("u_color", ccolor.x, ccolor.y, ccolor.z);
  PVector minColor = new PVector(red(c1) + 0, green(c1) + 0, blue(c1) + 0);
  minColor.div(255);
  shad.set("u_minColor", minColor.x, minColor.y, minColor.z);
  //colorMode(RGB, 255);
  PVector tempXY = new PVector(map(ball.x, 0, width, -0.5, 0.5), map(ball.y, 0, height, 0.5, -0.5));
  shad.set("u_mouse", tempXY.x, tempXY.y);
  filter(shad);
}


void calcMForce() {

  mouseForce.set(mouseX - pmouseX, mouseY - pmouseY);
  mouseForce.normalize();
  mouseForce.mult(mouseFDiff + 0);
  //println("mouseF = " + mouseForce);
}