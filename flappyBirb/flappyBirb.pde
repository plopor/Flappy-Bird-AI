import java.util.Random;

int TOP = 15;
int grid = 20;
boolean start = false;
long lastTime;
float grav = .5, birbNum = 225;
ArrayList<pipe> pipes;
ArrayList<Birb> birbs;
PImage birdIco, pipeIco, pipeTopIco;
int[] numberDead = new int[1];
int[] parentIndex = new int[1];
int pipeIndex = 0;
int[] topSurvivors = new int[TOP];
Random rand = new Random();

void setup() {
  size(1200, 700);
  birbs = new ArrayList<Birb>();
  pipes = new ArrayList<pipe>();
  birdIco = loadImage("birb.png");
  pipeIco = loadImage("pipe.png");
  pipeTopIco = loadImage("pipeTop.png");
  for (int i = 0; i < birbNum; i++) {
    birbs.add(new Birb(i));
  }
}

void draw() {
  background(0);
  if (start) {      
    if ((System.currentTimeMillis() - lastTime) > 2000) {
      pipes.add(new pipe());
      lastTime = System.currentTimeMillis();
    }

    for (pipe i : pipes) {
      i.show();
      i.update();
      if (pipes.get(pipeIndex).pos.x < 100) {
        pipeIndex++;
      }
    }
    //System.out.println(pipeIndex);

    for (Birb j : birbs) {
      j.show();
      j.CollisionDetect(numberDead, topSurvivors, parentIndex);
      j.update(pipeIndex, numberDead, topSurvivors, parentIndex);
      j.think();
      //System.out.println(pipes.get(pipeIndex).pos.x);
    }
    if (numberDead[0] == birbNum) {
      System.out.println("End of generation");
      goNextGen();
    }
  }
}

Birb makeChild(int mom, int dad, ArrayList<Birb> birbs){
  return new Birb(69);
}

void repopulate(int[] parents, ArrayList<Birb> birbs) {
  int momIndex = 0;
  int dadIndex = TOP - 1;
  ArrayList<Birb> temp = new ArrayList<Birb>();
  for (int i = 0; i < birbNum; i++){
    if (i < TOP){
      temp.add(birbs.get(parents[i]));
    }
    else if (momIndex != TOP - 1){
      if (dadIndex == momIndex){
        dadIndex = TOP - 1;
        momIndex++;
      }
      temp.add(makeChild (parents[momIndex], parents[dadIndex], birbs));
      temp.add(makeChild (parents[dadIndex], parents[momIndex], birbs));
      dadIndex--;
    }
    else{
      break;
    }
  }
  birbs = temp;
  //for (int i = 0; i < birbNum; i++){
  //  System.out.println(birbs.get(i).myIndex);
  //}
}

void goNextGen() {
  start = false;
  pipes = new ArrayList<pipe>();
  numberDead[0] = 0;
  parentIndex[0] = 0;
  pipeIndex= 0;
  for (Birb j : birbs) {
    j.pos = new PVector(100, 300);
    j.vel = new PVector(0, 0);
    j.dead = false;
    j.vel.x = 0;
  }
  for (int i = 0; i < TOP; i++) {
    System.out.print(topSurvivors[i] + " ");
  }
  System.out.println();
  repopulate(topSurvivors, birbs);
}

void keyPressed() {
  for (Birb j : birbs) {
    if ((keyCode == 'W')&&(j.dead == false)) {
      //for (Birb j : birbs){
      //j.vel.y = -12;
      //}
      birbs.get(0).vel.y = -12;
    }
  }

  if (keyCode == 'S') {
    start = true;
  }
}
