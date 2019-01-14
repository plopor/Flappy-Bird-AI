import java.util.Random;

int grid = 20;
boolean dead = false, start = false;
long lastTime;
float grav = .5;
ArrayList<pipe> pipes;
Birb birb;
Random rand = new Random();

void setup(){
  size(1200,700);
  birb = new Birb();
  pipes = new ArrayList<pipe>();
}

void draw(){
  background(0);
  if (start == true){
  birb.vel.y += grav;
  if (((System.currentTimeMillis() - lastTime) > 2000)&&(dead == false)){
    pipes.add(new pipe());
    System.out.println("and another one");
    lastTime = System.currentTimeMillis();
  }
  for (pipe i : pipes){
    i.show();
    if (dead == false){
    i.update();
    }
  }
  birb.update();
  if (birb.pos.y > 680){
    birb.die(); 
  }
  for (pipe i : pipes){
    if ((birb.pos.x >= i.pos.x)&&(birb.pos.x <= (i.pos.x + 100))){
      if ((birb.pos.y <= (i.pos.y + i.top))||(birb.pos.y >= (i.pos.y + i.top + 150))){
        birb.die();
      }
    }
  }
  }
  birb.show();
}

void keyPressed(){
  if ((keyCode == 'W')&&(dead == false)){
    birb.vel.y = -12;
  }
  if (keyCode == 'S'){
    start = true;
  }
}
