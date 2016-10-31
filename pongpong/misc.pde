
PVector findQuad(PVector obj, PVector parent, float diam){
  PVector quad = new PVector(0,0);
  if (obj.x < parent.x){
      quad.x = -1; 
  } else {
     quad.x = 1; 
  }
  if (obj.y < parent.y){
    quad.y = -1;
  } else {
     quad.y = 1; 
  }
  
  println();
  print(" QUAD=(");
  if (quad.x == -1){
    print("LEFT-");
  } else if (quad.x == 1){
   print("RIGHT-"); 
  }
  if (quad.y == -1){
    print("TOP ");
  } else if (quad.y == 1){
    print("BOTTOM ");
  }
  println();
  
  return quad;
  
}

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
  shad.set("u_bright", dist(xyInter.x, xyInter.y, ball.x, ball.y)/10000);
  //shad.set("u_resolution", float(width), float(height));
  shad.set("u_contrast", 0.4, 100);
  
  float speedSize = (abs(ballSpeed.x) + abs(ballSpeed.y)) * 0.1f;
  println("speedSize = " + speedSize);
  shad.set("u_size", speedSize); //.02
  //colorMode(RGB, 1.0);
  PVector ccolor = new PVector(red(c1) + 0, green(c1) + 0, blue(c1) + 0);
  ccolor.div(255);
  shad.set("u_color", ccolor.x, ccolor.y, ccolor.z);
  PVector minColor = new PVector(red(c3) + 0, green(c3) + 0, blue(c3) + 0);
  minColor.div(255);
  shad.set("u_minColor", minColor.x, minColor.y, minColor.z);
  //colorMode(RGB, 255);
  PVector tempXY = new PVector(map(ball.x, 0, width, -0.5, 0.5), map(ball.y, 0, height, 0.5, -0.5));
  PVector tempXY2 = new PVector(map(points[1].x, 0, width, -0.5, 0.5), map(points[1].y, 0, height, 0.5, -0.5));
  shad.set("u_ball", tempXY.x, tempXY.y, 0.02);
  shad.set("u_mouse", tempXY2.x, tempXY2.y, 0.15);
  filter(shad);
}


void calcMForce() {

  mouseForce.set(mouseX - pmouseX, mouseY - pmouseY);
  mouseForce.normalize();
  mouseForce.mult(mouseFDiff + 0);
  //println("mouseF = " + mouseForce);
}

void loseReset(){
  score = 0;
        //loseSnd.play();
        println("LOSELOSELOSELOSELOSELOSELOSELOSELOSELOSELOSE");
        println("LOSELOSELOSELOSELOSELOSELOSELOSELOSELOSELOSE");
        println("LOSELOSELOSELOSELOSELOSELOSELOSELOSELOSELOSE");
        println("LOSELOSELOSELOSELOSELOSELOSELOSELOSELOSELOSE");
        println("LOSELOSELOSELOSELOSELOSELOSELOSELOSELOSELOSE");
        println("LOSELOSELOSELOSELOSELOSELOSELOSELOSELOSELOSE");
        ball.set(width/2, height/2); //prevent collision glitch before restarting
        background(100);
        setup();
}