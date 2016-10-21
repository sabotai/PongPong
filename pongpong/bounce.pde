

void bounce(){
  
       ballSpeed.x *= 1.1;
      
       ballSpeed.y *= -1.05;  
       
       ballSpeed.add(mouseForce);
       //ballSpeed.div(1.5);
       //ballSpeed.sub(gravity);
       score+= value;
       scaleStr+=10;
       println("scored! score=" + score);
       //ball.y = inter.y + 1;      
       
       if (!squee){
         squee = true;
         squoo = false;
       } else { 
         squee = false;
         squoo = true;
       }
  
}