

void bounce(float xs, float ys, boolean scoring){
  
        ballSpeed.x *= xs;
        ballSpeed.y *= ys;
  
       
       ballSpeed.add(mouseForce);
       
       if (scoring){
         //score+= value;
         if (value > 1){
          score++; 
         }
         
         scaleStr+=10;
         println("scored! score=" + score);
       }
       
       if (!squee){
         squee = true;
         squoo = false;
       } else { 
         squee = false;
         squoo = true;
       }
  
}