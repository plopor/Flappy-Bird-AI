class Birb {
  PVector pos;
  PVector vel;
  boolean dead = false;
  double timeAlive = 0;
  double initTime = System.currentTimeMillis();
  Random initWeight = new Random();
  int myIndex = 0;
  double[] initInputs = new double[firstInputs];
  ArrayList<double[]> testWeights = new ArrayList<double[]>();
  ArrayList<double[]> testOutWeights = new ArrayList<double[]>();

  ArrayList<double[]> initWeights (int inputNumber, int numberOfNeurons) {
    ArrayList<double[]> allWeights = new ArrayList<double[]>();
    for (int i = 0; i < numberOfNeurons; i++) {
      double[] weights = new double[inputNumber];
      for (int j = 0; j < inputNumber; j++) {
        weights[j] = -1 + (1 + 1) * initWeight.nextDouble();
        //System.out.println("Init weights: " + weights[j]);
      }
      allWeights.add(weights);
    }
    return allWeights;
  }

  neuron[] makeLayer (double[] inputs, ArrayList<double[]> weights, int numberOfNeurons) {
    neuron[] layer = new neuron[numberOfNeurons];
    for (int i = 0; i < numberOfNeurons; i++) {
      neuron tempNeuron = new neuron(inputs, weights.get(i));
      layer[i] = tempNeuron;
      //System.out.println("Neuron output: " + tempNeuron.output);
    }
    return layer;
  }

  // initialize using this first
  Birb(int index, boolean gen1) {
    myIndex = index;
    pos = new PVector(100, 300);
    vel = new PVector(0, 0);
    if (gen1) {
      testWeights = initWeights (firstInputs, hiddenNeuronNumber);
      testOutWeights = initWeights (hiddenNeuronNumber, 1);
    }
  }

  void show() {
    image(birdIco, pos.x - 5, pos.y - 5, 30, 30);
  }

  public void CollisionDetect(int[] parents) {
    for (pipe j : pipes) {
      if ((pos.x >= j.pos.x)&&(pos.x <= (j.pos.x + 100))) {
        if ((pos.y <= (j.pos.y + j.top))||(pos.y >= (j.pos.y + j.top + 150))) {
          if (!dead) {
            die(parents);
          }
        }
      }
    }
  }

  void update(int watchPipe, int[] parents) {
    initInputs[0] = pipes.get(watchPipe).pos.x - pos.x;
    initInputs[1] = pipes.get(watchPipe).top + 100 - pos.y;
    //System.out.println("x diff: " + initInputs[0]);
    //System.out.println("y diff: " + initInputs[1]);
    pos.y += vel.y;
    pos.x += vel.x;
    vel.y += grav;
    if (pos.y > 700) {
      pos.y = 680;
    }
    if (pos.y < 0) {
      pos.y = 0;
    }
    if (!dead) {
      if (pos.y == 680 || pos.y == 0) {
        die(parents);
      }
    }
  }

  void think() {
    if (!dead) {
      neuron[] outputLayer = new neuron[hiddenNeuronNumber];
      outputLayer = makeLayer(initInputs, testWeights, hiddenNeuronNumber);
      outputNeuron decision = new outputNeuron(outputLayer, testOutWeights.get(0));
      if (decision.output > 0.5) {
        vel.y = -10;
      }
      //System.out.println("JUMP: " + decision.output);
    }
  }

  void die(int[] parents) {
    timeAlive = System.currentTimeMillis() - initTime;
    dead = true;
    vel.x = -5;
    numberDead++;
    System.out.println("Subject #" + myIndex + " stayed alive for " + timeAlive +". Dead count at " + numberDead);
    if (numberDead > (birbNum - TOP)) {
      parents[parentIndex] = myIndex;
      //for (int i = 0; i < TOP; i++) {
      //  System.out.print(topSurvivors[i] + " ");
      //}
      //System.out.println();
      parentIndex++;
    }
  }
}
