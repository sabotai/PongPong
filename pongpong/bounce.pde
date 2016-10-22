

void bounce(float xs, float ys, boolean scoring){
  float pan = (ball.x-width/2) / (width/2); //pan the sound

  bounceSnd.pan(pan);   
  bounceSnd.stop();
  bounceSnd.play();
        ballSpeed.x *= xs;
        ballSpeed.y *= ys;
  
       
       ballSpeed.add(mouseForce);
       
       if (scoring){
         //score+= value;
         if (value >= 0){
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