

void shake(float mag){
    shakeTime = min(shakeTime, 2); //dont go too crazy with the time
    PVector originalPos = new PVector(0,0);
      
    if (shakeTime > 0f) {
      points[1].y += 0.01; 
      shakeTime -= (frameRate/60.0) * (1.0/60.0);
      //println("time = " + shakeTime);
      PVector newPos = originalPos.add(new PVector(1,0,0).mult(sin(millis()) * shakeTime * mag)); 
      translate(newPos.x, newPos.y);
      //println("newPos = " + newPos);
    //rumbleSnd.loop();
    //if (!rumbleSnd.isPlaying()){
       //rumbleSnd.rewind(); 
    //} else {
    //}
    } else {
      translate(originalPos.x, originalPos.y);
      rumbleSnd.rewind();
      rumbleSnd.pause();
    }
    
}