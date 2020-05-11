import java.util.Random;

int TOP = 10;
int grid = 10, birbNum = 100;
boolean start = false;
float grav = .8;
ArrayList<Birb> birbs;
ArrayList<pipe> pipes;
int hiddenNeuronNumber = 6;
PImage birdIco, pipeIco, pipeTopIco, bg;
int numberDead = 0;
int parentIndex = 0;
int pipeIndex = 0, pipeAdder = 0;
int[] topSurvivors = new int[TOP];
Random rand = new Random();
int randomHolder = 0;
int mutationChance = 20;
double gameTime = System.currentTimeMillis();


void setup() {
  bg = loadImage("bg.png");
  size(1000, 700);
  birbs = new ArrayList<Birb>();
  pipes = new ArrayList<pipe>();
  birdIco = loadImage("birb.png");
  pipeIco = loadImage("pipe.png");
  pipeTopIco = loadImage("pipeTop.png");
  for (int i = 0; i < birbNum; i++) {
    birbs.add(new Birb(i, true));
  }
  pipes.add(new pipe());
}

void draw() {
  background(bg);
  if (start) {      
    if (pipes.get(pipeAdder).pos.x < 500) {
      pipes.add(new pipe());
      pipeAdder++;
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
      j.CollisionDetect(topSurvivors, pipes.get(pipeIndex));
      j.update(pipeIndex, topSurvivors);
      j.think();
    }
    if (numberDead == birbNum) {
      double trialDuration = System.currentTimeMillis() - gameTime;
      System.out.println("End of generation after: " + trialDuration);
      goNextGen(trialDuration > 1000);
    }
  }
}

void keyPressed() {
  for (Birb j : birbs) {
    if ((keyCode == 'W')&&(j.dead == false)) {
      //for (Birb j : birbs){
      //j.vel.y = -12;
      //}
      birbs.get(0).vel.y = -8;
    }
  }

  if (keyCode == 'S') {
    start = true;
  }
}

// Notes: Fitness is currently defined by time alive
//        *Try to separate the weights for each neuron in first layer
//        *Try to reevaluate the way the weights are distributed to children as function of parent fitness
//        *Try to filter the parent group for more fit individuals
