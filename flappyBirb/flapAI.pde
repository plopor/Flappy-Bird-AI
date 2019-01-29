public class neuron{
  public long[] selfInput;
  public float[] currWeights;
  public double output;
  public neuron(long input[], float weights[]){
    selfInput = new long[input.length];
    currWeights = new float[weights.length];
    output = 0;
    for (int i = 0; i < weights.length; i++){
      currWeights[i] = weights[i];
    }
    for (int j = 0; j < input.length; j++){
      selfInput[j] = input[j];
    }
    for (int x = 0; x < input.length; x++){
      output += (input[x] * weights[x]);
    }
    output = 1 / (1 - Math.pow(Math.E, -output));
  }
}

public class outputNeuron{
  public neuron[] hiddenInput;
  public float[] currWeights;
  public double output;
  public outputNeuron(neuron hiddenLayer[], float weights[]){
    hiddenInput = new neuron[hiddenLayer.length];
    currWeights = new float[weights.length];
    output = 0;
    for (int i = 0; i < weights.length; i++){
      currWeights[i] = weights[i];
    }
    for (int j = 0; j < hiddenLayer.length; j++){
      hiddenInput[j] = hiddenLayer[j];
    }
    for (int x = 0; x < hiddenLayer.length; x++){
      output += (hiddenLayer[x].output * weights[x]);
    }
    output = 1 / (1 - Math.pow(Math.E, - output));
  }
}
