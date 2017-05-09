class AgentFactory{
 int minMetabolism, maxMetabolism, minVision, maxVision, minInitialSugar, maxInitialSugar;
 MovementRule m;
 public AgentFactory(int minMetabolism, int maxMetabolism, int minVision, int maxVision, int minInitialSugar, int maxInitialSugar, MovementRule m){
 this.minMetabolism = minMetabolism;
 this.maxMetabolism = maxMetabolism;
 this.minVision = minVision;
 this.maxVision = maxVision;
 this.minInitialSugar = minInitialSugar;
 this.maxInitialSugar = maxInitialSugar;
 this.m = m;
 }

 public Agent makeAgent(){
    float met, vizzier, initsug;
    met = random(this.minMetabolism, this.maxMetabolism + 1);
    vizzier = random(this.minVision, this.maxVision + 1);
    initsug = random(this.minInitialSugar, this.maxInitialSugar + 1);
    
    Agent Johnson = new Agent(int(met), int(vizzier), int(initsug), m);
    return Johnson;
 }
}