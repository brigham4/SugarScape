import java.util.List;

class ReplacementRule{
  int MNA, MXA;
  AgentFactory AF;
  public ReplacementRule(int minAge, int maxAge, AgentFactory fac){
  MNA = minAge;
  MXA = maxAge;
  AF = fac;
  }
  
  public boolean replaceThisOne(Agent a){
  //This method accepts an Agent a, and determines whether the agent should be replaced yet. a should be replaced if it is no longer alive. 
  //Further, if this is the first time ReplacementRule has been asked about Agent a, then generate a random integer between minAge and maxAge to 
  //represent the lifespan of a. Store this integer in a List as well as storing a reference to Agent a (you may want to make an additional class to 
  //facilitate this, or use two lists). In the future, when replaceThisOne(a) is called, check whether the age of a exceeds the randomly generated lifespan.
  //If it does, then return true regardless of whether a is alive or not and set the age of a to maxAge + 1. The last step ensures that function will return
  //a consistent value after an agent has gotten too old. If a is null, you may return any value.
  if(a.isAlive()== false){
      return true;
  }
  if(a.getLifespan() == 0){
    float rrr = random(MNA, MXA + 1);
    a.setLifespan(int(rrr));
    return false;
  }
  if(a.getAge() > a.getLifespan()){
    a.setAge(MXA + 1);
    return true;
  }
  else{
    return false;
  }
  }

  public Agent replace(Agent a, List<Agent> others){
    return AF.makeAgent();
  }


}
  