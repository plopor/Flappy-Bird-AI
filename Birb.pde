class Birb{
  PVector pos;
  PVector vel;
  
  Birb(){
    pos = new PVector(100, 300);
    vel = new PVector(0, 0);
  }
  
  void show(){
    noStroke();
    fill(250, 20, 20);
    rect(pos.x, pos.y, grid, grid);
  }
  
  void update(){
    pos.y += vel.y;
    if (pos.y > 700){
      pos.y = 680;
    }
  }
  
  void die(){
    dead = true;
    
  }
}
