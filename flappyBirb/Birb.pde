class Birb{
  PVector pos;
  PVector vel;
  boolean dead = false;
  Random initWeight = new Random();
  
  ArrayList<double[]> initWeights (double[] inputs, int numberOfNeurons){
    ArrayList<double[]> neurons = new ArrayList<double[]>();
    for (int i = 0; i < numberOfNeurons; i++){
      double[] weights = new double[numberOfNeurons];
      for (int j = 0; j < (inputs.length); j++){
        weights[j] = -1 + (1 + 1) * initWeight.nextDouble();
      }
      neurons.add(weights);
    }
    return neurons;
  }
  
  Birb(){
    pos = new PVector(100, 300);
    vel = new PVector(0, 0);
  }
  
  void show(){
    image(birdIco, pos.x - 5, pos.y - 5, 30, 30);
  }
  
  void update(){
    pos.y += vel.y;
    pos.x += vel.x;
    if (pos.y > 700){
      pos.y = 680;
    }
    
    if(start) {
      vel.y += grav;
      if(pos.y > 680){
        die(); 
      }
    }
  }
  
  void think(){
    
  }
  
  void die(){
    this.dead = true;
    this.vel.x = -5;
  }
}
