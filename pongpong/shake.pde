

void shake(float mag){
    shakeTime = min(shakeTime, 1); //dont go too crazy with the time
  
    PVector originalPos = new PVector(0,0);
      
    if (shakeTime > 0f) {
      shakeTime -= (frameRate/60.0) * (1.0/60.0);
      //println("time = " + shakeTime);
      PVector newPos = originalPos.add(new PVector(1,0,0).mult(sin(millis()) * shakeTime * mag)); 
      translate(newPos.x, newPos.y);
      //println("newPos = " + newPos);
    } else {
      translate(originalPos.x, originalPos.y);
    }
    
}