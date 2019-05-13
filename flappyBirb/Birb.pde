class Birb {
  PVector pos;
  PVector vel;
  boolean dead = false;
  double timeAlive = 0;
  double initTime = System.currentTimeMillis();
  Random initWeight = new Random();
  int hiddenNeuronNumber = 10;
  int firstInputs = 6;
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
    }
    return layer;
  }

  // initialize using this first
  Birb(int index) {
    myIndex = index;
    pos = new PVector(100, 300);
    vel = new PVector(0, 0);
    initInputs[0] = this.pos.x;
    initInputs[1] = this.pos.y;
    testWeights = this.initWeights (firstInputs, hiddenNeuronNumber);
    testOutWeights = this.initWeights (hiddenNeuronNumber, 1);
  }

  void show() {
    image(birdIco, pos.x - 5, pos.y - 5, 30, 30);
  }

  public void CollisionDetect(int[] numberDead, int[] parents, int[] parentIndex) {
    for (pipe j : pipes) {
      if ((pos.x >= j.pos.x)&&(pos.x <= (j.pos.x + 100))) {
        if ((pos.y <= (j.pos.y + j.top))||(pos.y >= (j.pos.y + j.top + 150))) {
          if (!this.dead) {
            die(numberDead, parents, parentIndex);
          }
        }
      }
    }
  }

  void update(int watchPipe, int[] numberDead, int[] parents, int[] parentIndex) {
    pos.y += vel.y;
    pos.x += vel.x;
    vel.y += grav;
    if (pos.y > 700) {
      pos.y = 680;
    }
    if (pos.y < 0) {
      pos.y = 0;
    }
    if (!this.dead) {
      if (pos.y == 680 || pos.y == 0) {
        die(numberDead, parents, parentIndex);
      }
    }
    initInputs[0] = pipes.get(watchPipe).pos.x - this.pos.x;
    initInputs[1] = pipes.get(watchPipe).top - this.pos.y;
    initInputs[2] = (700 - (pipes.get(watchPipe).top + 150)) - this.pos.y;
    initInputs[3] = this.pos.x;
    initInputs[4] = this.pos.y;
    initInputs[5] = this.vel.y;
  }

  void think() {
    if (!dead) {
      neuron[] outputLayer = new neuron[hiddenNeuronNumber];
      outputLayer = makeLayer(initInputs, testWeights, hiddenNeuronNumber);
      outputNeuron decision = new outputNeuron(outputLayer, testOutWeights.get(0));
      if (decision.output >= 0) {
        this.vel.y = -12;
      }
    }
  }

  void die(int[] numberDead, int[] parents, int[] parentIndex) {
    this.timeAlive = System.currentTimeMillis() - initTime;
    this.dead = true;
    this.vel.x = -5;
    numberDead[0]++;
    System.out.println("Subject #" + (this.myIndex + 1) + " stayed alive for " + this.timeAlive +". Dead count at " + numberDead[0]);
    if (numberDead[0] > (birbNum - TOP)) {
      parents[parentIndex[0]] = this.myIndex;
      //for (int i = 0; i < TOP; i++) {
      //  System.out.print(topSurvivors[i] + " ");
      //}
      //System.out.println();
      parentIndex[0]++;
    }
  }
}
