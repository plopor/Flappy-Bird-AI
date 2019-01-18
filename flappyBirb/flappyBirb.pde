import java.util.Random;

int grid = 20;
boolean start = false;
long lastTime;
float grav = .5, birbNum = 1;
ArrayList<pipe> pipes;
public ArrayList<Birb> birbs;
PImage birdIco, pipeIco, pipeTopIco;
Random rand = new Random();

void setup(){
  size(1200,700);
  birbs = new ArrayList<Birb>();
  pipes = new ArrayList<pipe>();
  birdIco = loadImage("birb.png");
  pipeIco = loadImage("pipe.png");
  pipeTopIco = loadImage("pipeTop.png");
  for (int i = 0; i < birbNum; i++){
    birbs.add(new Birb());
  }
}

void draw(){
  background(0);
  if (start){      
    if ((System.currentTimeMillis() - lastTime) > 2000){
      pipes.add(new pipe());
      lastTime = System.currentTimeMillis();
    }
      
    for (pipe i : pipes){
      i.show();
      i.update();
      i.CollisionDetect();
    }
  }
        
  for (Birb j : birbs){
    j.show();
    j.update();
  }
}

void keyPressed(){
  for (Birb j : birbs){
    if ((keyCode == 'W')&&(j.dead == false)){
      //for (Birb j : birbs){
      //j.vel.y = -12;
      //}
      birbs.get(0).vel.y = -12;
    }
  }
  
  if (keyCode == 'S'){
    start = true;
  }
}
