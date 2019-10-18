Birb makeChild(int mom, int dad, ArrayList<Birb> birbs, int index) {
  Birb temp = new Birb(index, false);
  ArrayList<double[]> tempLayer = new ArrayList<double[]>();
  ArrayList<double[]> outLayer = new ArrayList<double[]>();
  double[] outWeights = new double[hiddenNeuronNumber];
  int outCounter = 0;
  int random = rand.nextInt(hiddenNeuronNumber);
  randomHolder = random;
  int mutate = rand.nextInt(99);
  //int mutateAmount = rand.nextInt(3);
  //System.out.println("Original random: " + random);
  for (int i = 0; i < random; i++) {
    tempLayer.add(birbs.get(mom).testWeights.get(i));
    for (int j = 0; j < 2; j++){ // this 3 should be initInputs, which is not available in this scope. fix
      if (mutate < mutationChance){
        tempLayer.get(outCounter)[j] = -1 + 2 * rand.nextDouble();
        mutate = rand.nextInt(99);
      }
    }
    //System.out.println ("Mutate? " + mutate);
    /*
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
    }*/
    if (mutate < mutationChance) {
      outWeights[outCounter] = -1 + (1 + 1) * rand.nextDouble();
    } else {
      outWeights[outCounter] = birbs.get(mom).testOutWeights.get(0)[outCounter];
    }
    //mutateAmount = rand.nextInt(3);
    mutate = rand.nextInt(99);
    outCounter++;
  }
  for (int i = 0; i < (hiddenNeuronNumber - random); i++) {
    tempLayer.add(birbs.get(dad).testWeights.get(i));
    for (int j = 0; j < 2; j++){ // this 3 should be initInputs, which is not available in this scope. fix
      if (mutate < mutationChance){
        tempLayer.get(outCounter)[j] = -1 + 2 * rand.nextDouble();
        mutate = rand.nextInt(99);
      }
    }
    //System.out.println ("Mutate? " + mutate);
    /*
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
    }*/
    if (mutate < mutationChance) {
      outWeights[outCounter] = -1 + (1 + 1) * rand.nextDouble();
    } else {
      outWeights[outCounter] = birbs.get(dad).testOutWeights.get(0)[outCounter];
    }
    //mutateAmount = rand.nextInt(3);
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
  //int mutateAmount = rand.nextInt(3);
  //System.out.println("Same random: " + randomHolder);
  for (int i = 0; i < random; i++) {
    tempLayer.add(birbs.get(mom).testWeights.get(i));
    //System.out.println ("Mutate? " + mutate);
    for (int j = 0; j < 2; j++){ // this 3 should be initInputs, which is not available in this scope. fix
      if (mutate < mutationChance){
        tempLayer.get(outCounter)[j] = -1 + 2 * rand.nextDouble();
        mutate = rand.nextInt(99);
      }
    }
    /*if (mutate < mutationChance) {
      if (mutateAmount == 2) {
        tempLayer.get(outCounter)[1] = -1 + (1 + 1) * rand.nextDouble();
        //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[1]);
      } else {
        for (int j = 0; j < mutateAmount; j++) {
          tempLayer.get(outCounter)[j] = -1 + (1 + 1) * rand.nextDouble();
          //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[j]);
        }
      }
    }*/
    if (mutate < mutationChance) {
      outWeights[outCounter] = -1 + (1 + 1) * rand.nextDouble();
    } else {
      outWeights[outCounter] = birbs.get(mom).testOutWeights.get(0)[outCounter];
    }
    //mutateAmount = rand.nextInt(3);
    mutate = rand.nextInt(99);
    outCounter++;
  }
  for (int i = 0; i < (hiddenNeuronNumber - random); i++) {
    tempLayer.add(birbs.get(dad).testWeights.get(i));
    //System.out.println ("Mutate? " + mutate);
    for (int j = 0; j < 2; j++){ // this 3 should be initInputs, which is not available in this scope. fix
      if (mutate < mutationChance){
        tempLayer.get(outCounter)[j] = -1 + 2 * rand.nextDouble();
        mutate = rand.nextInt(99);
      }
    }
    /*if (mutate < mutationChance) {
      if (mutateAmount == 2) {
        tempLayer.get(outCounter)[1] = -1 + (1 + 1) * rand.nextDouble();
        //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[1]);
      } else {
        for (int j = 0; j <= mutateAmount; j++) {
          tempLayer.get(outCounter)[j] = -1 + (1 + 1) * rand.nextDouble();
          //System.out.println("Mutated weight: " + tempLayer.get(outCounter)[j]);
        }
      }
    }*/
    if (mutate < mutationChance) {
      outWeights[outCounter] = -1 + (1 + 1) * rand.nextDouble();
    } else {
      outWeights[outCounter] = birbs.get(dad).testOutWeights.get(0)[outCounter];
    }
    //mutateAmount = rand.nextInt(3);
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
    birbs = new ArrayList<Birb>();
    birbs.add(temp.get(i));
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

void goNextGen(Boolean validTrial) {
  //WEIGHT TESTING
  /*for (Birb j : birbs) {
    System.out.println("Weights: ");
    for (int k = 0; k < hiddenNeuronNumber; k++) {
      for (int i = 0; i < 3; i++) {
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
  gameTime = System.currentTimeMillis();
  // unnecessary, just re-enit the parents
  for (Birb j : birbs) {
    j.pos = new PVector(200, 300);
    j.vel = new PVector(0, 0);
    j.dead = false;
    j.vel.x = 0;
    j.initTime = System.currentTimeMillis();
  }
  System.out.println("Top Survivors: ");
  for (int i = 0; i < TOP; i++) {
    System.out.print(topSurvivors[i] + " ");
  }
  System.out.println();
  if (validTrial){
    repopulate(topSurvivors, birbs);
  }
  topSurvivors = new int[TOP];
  
  //Index testing
  /*for (int i = 0; i < birbNum; i++) {
    System.out.println(birbs.get(i).myIndex);
  }*/
}
