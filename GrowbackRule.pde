public interface GrowthRule{
  public void growBack(Square s);
}

class GrowbackRule implements GrowthRule{
  private int gbr;
  public GrowbackRule(int rate){
    //Initializes a new GrowbackRule with the specified growth rate.
    gbr = rate;
  }
  public void growBack(Square s){
      for(int n=0; n < gbr; n++){
      if(s.getSugar() < s.getMaxSugar()){
        s.setSugar(s.getSugar() + 1);
      }
      }
  }
}

class SeasonalGrowbackRule implements GrowthRule{
    int A, B, G, Eq, NS,countdog; 
    boolean northSummer;
    public SeasonalGrowbackRule(int alpha, int beta, int gamma, int equator, int numSquares){
     A=alpha;
     B=beta;
     G=gamma;
     Eq=equator;
     NS=numSquares;
     northSummer = true;
     countdog=0;
   }
   public void growBack(Square s){
     countdog++;
     if((s.getY() <= Eq && northSummer == true) || (s.getY() > Eq && northSummer == false)){
       s.setSugar(s.getSugar() + A);
     }
     else if((s.getY() <= Eq && northSummer == false) || (s.getY() > Eq && northSummer == true)){
        s.setSugar(s.getSugar() + B);
     }
     if(countdog == G*NS){
       countdog = 0;
       if(northSummer == true){
         northSummer = false;
       }
       else { 
         northSummer = true; 
       }
     }
   }
   
   public boolean isNorthSummer(){
     if(northSummer == true){
     return true;
     }
     else{
       return false;
     }
   }
}