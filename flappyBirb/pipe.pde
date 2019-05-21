class pipe {
  PVector pos;
  PVector vel;
  int top = rand.nextInt(401) + 50;

  pipe() {
    pos = new PVector(1200, 0);
    vel = new PVector(-5, 0);
  }

  void show() {
    image(pipeTopIco, pos.x, pos.y, 100, top);
    image(pipeIco, pos.x, (top + 200), 100, (700 - (top + 200)));
  }

  void update() {
    pos.x += vel.x;
  }
}
