public class neuron {
  public double[] selfInput;
  public double[] currWeights;
  public double output;
  public neuron(double input[], double weights[]) {
    selfInput = new double[input.length];
    currWeights = new double[weights.length];
    output = 0;
    for (int i = 0; i < weights.length; i++) {
      currWeights[i] = weights[i];
    }
    for (int j = 0; j < input.length; j++) {
      selfInput[j] = input[j];
    }
    for (int x = 0; x < input.length; x++) {
      output += (input[x] * weights[x]);
    }
    output = 1 / (1 + Math.pow(Math.E, -output));
  }
}

public class outputNeuron {
  public neuron[] hiddenInput;
  public double[] currWeights;
  public double output;
  public outputNeuron(neuron hiddenLayer[], double weights[]) {
    hiddenInput = new neuron[hiddenLayer.length];
    currWeights = new double[weights.length];
    output = 0;
    for (int i = 0; i < weights.length; i++) {
      currWeights[i] = weights[i];
    }
    for (int j = 0; j < hiddenLayer.length; j++) {
      hiddenInput[j] = hiddenLayer[j];
    }
    for (int x = 0; x < hiddenLayer.length; x++) {
      output += (hiddenLayer[x].output * weights[x]);
    }
    output = 1 / (1 + Math.pow(Math.E, -output));
  }
}
