class Birb {
  PVector pos;
  PVector vel;
  boolean dead = false;
  Random initWeight = new Random();
  int hiddenNeuronNumber = 10;
  int firstInputs = 5;
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
  Birb() {
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

  void update(int watchPipe) {
    pos.y += vel.y;
    pos.x += vel.x;
    if (pos.y > 700) {
      pos.y = 680;
    }

    if (start) {
      vel.y += grav;
      if (pos.y > 680) {
        die();
      }
    }
    initInputs[0] = pipes.get(watchPipe).pos.x - this.pos.x;
    initInputs[1] = pipes.get(watchPipe).top - this.pos.y;
    initInputs[2] = (700 - (pipes.get(watchPipe).top + 150)) - this.pos.y;
    initInputs[3] = this.pos.x;
    initInputs[4] = this.pos.y;
  }

  void think() {
    if (start) {
      neuron[] outputLayer = new neuron[hiddenNeuronNumber];
      outputLayer = makeLayer(initInputs, testWeights, hiddenNeuronNumber);
      outputNeuron decision = new outputNeuron(outputLayer, testOutWeights.get(0));
      if (decision.output >= 0) {
        this.vel.y = -12;
      }
    }
  }

  void die() {
    this.dead = true;
    this.vel.x = -5;
  }
}
