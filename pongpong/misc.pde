

String findDir(){
  String dir = "";
  
  if (abs(ballSpeed.x) > abs(ballSpeed.y)){ //is x axis speed faster than y
    if (ballSpeed.x > 0){
      dir = "right"; 
    } else {
     dir = "left"; 
    }
  } else {
   if (ballSpeed.y > 0){
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


void runShader(){
 
  float speeds = (millis()) / 100;
  shad.set("u_time", speeds);
  shad.set("u_contrast", 0.7, 0.75);
  PVector ccolor = new PVector(red(c1), green(c1), blue(c1));
  ccolor.div(255);
  shad.set("u_color", ccolor.x, ccolor.y, ccolor.z);
  shad.set("u_mouse", float(mouseX), float(mouseY));
  filter(shad);   
}