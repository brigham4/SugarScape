class SocialNetworkNode{
  boolean painted;
  Agent agent;
public SocialNetworkNode(Agent a){
  this.agent = a;
  this.painted = false;
}
public boolean painted(){
//returns true if this node has been painted.
if(painted == true){
  return true;
}
else{
  return false;
}
}
public void paint(){
//Sets the node to painted.
painted = true;
}
public void unpaint(){
 //Sets the node to unpainted.
 painted = false;
 }
public Agent getAgent(){
//Returns the agent stored at this node.
return agent; 
}
}