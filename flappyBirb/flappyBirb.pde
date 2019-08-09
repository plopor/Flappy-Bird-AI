import java.util.Random;

int TOP = 15;
int grid = 10, birbNum = 225;
int hiddenNeuronNumber = 6;
int firstInputs = 2; // if this is changed you must also add the nature of inputs in Birb class
boolean start = false;
float grav = .5;
ArrayList<pipe> pipes;
ArrayList<Birb> birbs;
PImage birdIco, pipeIco, pipeTopIco;
int numberDead = 0;
int parentIndex = 0;
int pipeIndex = 0, pipeAdder = 0;
int[] topSurvivors = new int[TOP];
Random rand = new Random();
int randomHolder = 0;
int mutationChance = 30;


void setup() {
  size(1200, 700);
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
  background(0);
  if (start) {      
    if (pipes.get(pipeAdder).pos.x < 600) {
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
      j.CollisionDetect(topSurvivors);
      j.update(pipeIndex, topSurvivors);
      j.think();
    }
    if (numberDead == birbNum) {
      System.out.println("End of generation");
      goNextGen();
    }
  }
}

Birb makeChild(int mom, int dad, ArrayList<Birb> birbs, int index) {
  Birb temp = new Birb(index, false);
  ArrayList<double[]> tempLayer = new ArrayList<double[]>();
  ArrayList<double[]> outLayer = new ArrayList<double[]>();
  double[] outWeights = new double[hiddenNeuronNumber];
  int outCounter = 0;
  int random = rand.nextInt(hiddenNeuronNumber);
  randomHolder = random;
  int mutate = rand.nextInt(99);
  int mutateAmount = rand.nextInt(3);
  //System.out.println("Original random: " + random);
  for (int i = 0; i < random; i++) {
    tempLayer.add(birbs.get(mom).testWeights.get(i));
    //System.out.println ("Mutate? " + mutate);
    if (mutate < mutationChance) {
      if (mutateAmount == 2) {
        tempLayer.get(outCounter)[1] = -1 + (1 + 1) * rand.nextDouble();
        //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[1]);
      } else {
        for (int j = 0; j < mutateAmount; j++) {
          tempLayer.get(outCounter)[j] = -1 + (1 + 1) * rand.nextDouble();
          //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[j]);
        }
      }
    }
    if (mutate < mutationChance) {
      outWeights[outCounter] = -1 + (1 + 1) * rand.nextDouble();
    } else {
      outWeights[outCounter] = birbs.get(mom).testOutWeights.get(0)[outCounter];
    }
    mutateAmount = rand.nextInt(3);
    mutate = rand.nextInt(99);
    outCounter++;
  }
  for (int i = 0; i < (hiddenNeuronNumber - random); i++) {
    tempLayer.add(birbs.get(dad).testWeights.get(i));
    //System.out.println ("Mutate? " + mutate);
    if (mutate < mutationChance) {
      if (mutateAmount == 2) {
        tempLayer.get(outCounter)[1] = -1 + (1 + 1) * rand.nextDouble();
        //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[1]);
      } else {
        for (int j = 0; j <= mutateAmount; j++) {
          tempLayer.get(outCounter)[j] = -1 + (1 + 1) * rand.nextDouble();
          //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[j]);
        }
      }
    }
    if (mutate < mutationChance) {
      outWeights[outCounter] = -1 + (1 + 1) * rand.nextDouble();
    } else {
      outWeights[outCounter] = birbs.get(dad).testOutWeights.get(0)[outCounter];
    }
    mutateAmount = rand.nextInt(3);
    mutate = rand.nextInt(99);
    outCounter++;
  }
  outLayer.add(outWeights);
  temp.testWeights = tempLayer;
  temp.testOutWeights = outLayer;
  return temp;
}

//Overloaded for keeping the same random value
Birb makeChild(int mom, int dad, ArrayList<Birb> birbs, int index, int random) {
  Birb temp = new Birb(index, false);
  ArrayList<double[]> tempLayer = new ArrayList<double[]>();
  ArrayList<double[]> outLayer = new ArrayList<double[]>();
  double[] outWeights = new double[hiddenNeuronNumber];
  int outCounter = 0;
  int mutate = rand.nextInt(99);
  int mutateAmount = rand.nextInt(3);
  //System.out.println("Same random: " + randomHolder);
  for (int i = 0; i < random; i++) {
    tempLayer.add(birbs.get(mom).testWeights.get(i));
    //System.out.println ("Mutate? " + mutate);
    if (mutate < mutationChance) {
      if (mutateAmount == 2) {
        tempLayer.get(outCounter)[1] = -1 + (1 + 1) * rand.nextDouble();
        //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[1]);
      } else {
        for (int j = 0; j < mutateAmount; j++) {
          tempLayer.get(outCounter)[j] = -1 + (1 + 1) * rand.nextDouble();
          //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[j]);
        }
      }
    }
    if (mutate < mutationChance) {
      outWeights[outCounter] = -1 + (1 + 1) * rand.nextDouble();
    } else {
      outWeights[outCounter] = birbs.get(mom).testOutWeights.get(0)[outCounter];
    }
    mutateAmount = rand.nextInt(3);
    mutate = rand.nextInt(99);
    outCounter++;
  }
  for (int i = 0; i < (hiddenNeuronNumber - random); i++) {
    tempLayer.add(birbs.get(dad).testWeights.get(i));
    //System.out.println ("Mutate? " + mutate);
    if (mutate < mutationChance) {
      if (mutateAmount == 2) {
        tempLayer.get(outCounter)[1] = -1 + (1 + 1) * rand.nextDouble();
        //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[1]);
      } else {
        for (int j = 0; j <= mutateAmount; j++) {
          tempLayer.get(outCounter)[j] = -1 + (1 + 1) * rand.nextDouble();
          //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[j]);
        }
      }
    }
    if (mutate < mutationChance) {
      outWeights[outCounter] = -1 + (1 + 1) * rand.nextDouble();
    } else {
      outWeights[outCounter] = birbs.get(dad).testOutWeights.get(0)[outCounter];
    }
    mutateAmount = rand.nextInt(3);
    mutate = rand.nextInt(99);
    outCounter++;
  }
  outLayer.add(outWeights);
  temp.testWeights = tempLayer;
  temp.testOutWeights = outLayer;
  return temp;
}

void repopulate(int[] parents, ArrayList<Birb> birbs) {
  int momIndex = 0;
  int dadIndex = TOP - 1;
  ArrayList<Birb> temp = new ArrayList<Birb>();
  for (int i = 0; i < birbNum; i++) {
    if (i < TOP) {
      birbs.get(parents[i]).myIndex = i;
      temp.add(birbs.get(parents[i]));
    } else if (momIndex != TOP - 1) {
      if (dadIndex == momIndex) {
        dadIndex = TOP - 1;
        momIndex++;
      }
      temp.add(makeChild (parents[momIndex], parents[dadIndex], birbs, i));
      i++;
      temp.add(makeChild (parents[dadIndex], parents[momIndex], birbs, i, randomHolder));
      dadIndex--;
    } else {
      break;
    }
  }
  for (int i = 0; i < birbNum; i++) {
    birbs.set(i, temp.get(i));
  }
  
  //WEIGHT TESTING
  /*for (Birb j : birbs) {
    System.out.println("Weights: ");
    for (int k = 0; k < hiddenNeuronNumber; k++) {
      for (int i = 0; i < firstInputs; i++) {
        System.out.print(j.testWeights.get(k)[i] + " ");
      }
      System.out.println("- with outweight of " + j.testOutWeights.get(0)[k]);
    }
  }*/
}

void goNextGen() {
  //WEIGHT TESTING
  /*for (Birb j : birbs) {
    System.out.println("Weights: ");
    for (int k = 0; k < hiddenNeuronNumber; k++) {
      for (int i = 0; i < firstInputs; i++) {
        System.out.print(j.testWeights.get(k)[i] + " ");
      }
      System.out.println("- with outweight of " + j.testOutWeights.get(0)[k]);
    }
  }*/
  //start = false;
  pipes = new ArrayList<pipe>();
  pipes.add(new pipe());
  numberDead = 0;
  parentIndex = 0;
  pipeIndex= 0;
  pipeAdder = 0;
  // unnecessary, just re-enit the parents
  for (Birb j : birbs) {
    j.pos = new PVector(100, 300);
    j.vel = new PVector(0, 0);
    j.dead = false;
    j.vel.x = 0;
    j.initTime = System.currentTimeMillis();
  }
  for (int i = 0; i < TOP; i++) {
    System.out.print(topSurvivors[i] + " ");
  }
  System.out.println();
  repopulate(topSurvivors, birbs);
  topSurvivors = new int[TOP];
  
  //Index testing
  /*for (int i = 0; i < birbNum; i++) {
    System.out.println(birbs.get(i).myIndex);
  }*/
}

void keyPressed() {
  for (Birb j : birbs) {
    if ((keyCode == 'W')&&(j.dead == false)) {
      //for (Birb j : birbs){
      //j.vel.y = -12;
      //}
      birbs.get(0).vel.y = -10;
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
