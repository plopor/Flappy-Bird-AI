class pipe{
  PVector pos;
  PVector vel;
  int top = rand.nextInt(500) + 50;
  
  pipe(){
    pos = new PVector(1200, 0);
    vel = new PVector(-5, 0);
  }
  
  void show(){
    noStroke();
    fill(20, 250, 20);
    rect(pos.x, pos.y, 100, top);
    rect(pos.x, (top + 150), 100, (700 - (top + 150)));
  }
  
  void update(){
    pos.x += vel.x;
  }
}
