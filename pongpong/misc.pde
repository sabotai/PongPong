

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