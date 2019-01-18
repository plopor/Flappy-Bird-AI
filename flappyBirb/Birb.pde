class Birb{
  PVector pos;
  PVector vel;
  boolean dead = false;
  
  Birb(){
    pos = new PVector(100, 300);
    vel = new PVector(0, 0);
  }
  
  void show(){
    noStroke();
    image(birdIco, pos.x - 5, pos.y - 5, 30, 30);
  }
  
  void update(){
    pos.y += vel.y;
    pos.x += vel.x;
    if (pos.y > 700){
      pos.y = 680;
    }
    
    if(start) {
      vel.y += grav;
      if(pos.y > 680){
        die(); 
      }
    }
  }
  
  void die(){
    this.dead = true;
    this.vel.x = -5;
  }
}
