class PollutionRule{
  int gp, ep;
  public PollutionRule(int gatheringPollution, int eatingPollution){
  gp = gatheringPollution;
  ep =eatingPollution;
  }
  
  public void pollute(Square s){
    if(s.getAgent() == null){
    return;
    }
    if(s.getAgent() != null){
      Agent var1 = s.getAgent();
      s.setPollution(s.getPollution() + (ep*var1.getMetabolism()) + (gp*s.getSugar()));
    }
    
  }
  
}