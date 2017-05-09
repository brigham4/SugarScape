class Graph {
  int X, Y, HW, HT;
  String XLAB, YLAB;
  public Graph(int x, int y, int howWide, int howTall, String xlab, String ylab) {
    this.X = x;
    this.Y = y;
    this.HW = howWide;
    this.HT = howTall;
    this.XLAB = xlab;
    this.YLAB = ylab;
  }
  public void update(SugarGrid g) {
    fill(255);
    stroke(255);
    rect(X, Y, HW, HT);
    stroke(0);
    strokeWeight(1);
    line(X, Y+HT, X+HW, Y+HT);//x
    line(X, Y, X, Y+HT);//y
    fill(0);
    text(XLAB, (X+(HW/2)), (Y+HT+15));
    pushMatrix();
    translate(X-5, Y+90);
    rotate(-PI/2.0);
    text(YLAB, 0, 0);
    popMatrix();
  }
}

abstract class LineGraph extends Graph {
  int upd8calls;
  ArrayList<Coordinates> coords = new ArrayList<Coordinates>();

  public LineGraph(int x, int y, int howWide, int howTall, String xlab, String ylab) {
    super(x, y, howWide, howTall, xlab, ylab);
    upd8calls = 0;
  }
  public abstract int nextPoint(SugarGrid g);

  public void update(SugarGrid g) {
    //If the number of update class is 0, calls the superclass update method. 
    if (upd8calls == 0) {
      super.update(g);
    } else {
      super.update(g);
      coords.add(new Coordinates (X+upd8calls, nextPoint(g), 1, 1));
      for (int q = 0; q < coords.size(); q++) {
        coords.get(q).display();
      }
      //fill(0);
      //rect(upd8calls, nextPoint(g), 1, 1);
      if (upd8calls > HW) {
        upd8calls = 0;
        coords.clear();
      }
    }
    upd8calls++;
  }
}

class SurvivingAgents extends LineGraph {
  private int ancestors = -1;
  public SurvivingAgents(int x, int y, int howWide, int howTall, String xlab, String ylab) {
    super(x, y, howWide, howTall, xlab, ylab);
    //upd8calls = 0;
  }
  public int nextPoint(SugarGrid g) {
    if(ancestors == -1){
      ancestors = g.getAgents().size();
    }
    ArrayList<Agent> Survivors = new ArrayList<Agent>(g.getAgents());
    if (Survivors.size() == 0) {
      return 0;
    }
    /*if ((Survivors.size() % 3) ==0) {
      return Survivors.size() + (Y);
    } else if ((Survivors.size() % 3) ==1) {
      return Survivors.size() + (Y + (HT/3)*2);
    } else {
      return Survivors.size() + (Y + (HT/3)*1);
    }
  }
  
  //return Survivors.size() + (Y + (HT/3)*(Survivors.size() % 3));
  //when size = 3 => y
  //when size = 2 => y + 2*33
  //when size = 1 => y + 1*33
  */
  
  return HT/2 + int(Y +((1 - (Survivors.size() * 1.0 / ancestors)) * HT)/2);
}
  public void update(SugarGrid g) {
    super.update(g);
  }
}

class MeanAgentWealth extends LineGraph {
  private int numOGAgents = -1;
  private int totalSugar = 0;
  public MeanAgentWealth(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
  }
  public int nextPoint(SugarGrid g){
    if(numOGAgents == -1 ){
      numOGAgents = g.getAgents().size();
    }
    ArrayList<Agent> ags = g.getAgents();
    for(int n = 0; n < ags.size(); n++){
      totalSugar += ags.get(n).getSugarLevel();
  }
  if (ags.size() == 0){
    return 0;
  }
  int avg = totalSugar/ags.size();
  return (Y + HT) + int(Y - avg)/10000;
  }
 public void update(SugarGrid g) {
    super.update(g);
}
}

class DominantCulture extends LineGraph{
  private int numOGAgents = -1;
  public  DominantCulture(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
  }
  public int nextPoint(SugarGrid g){
    if(numOGAgents == -1){
      numOGAgents = g.getAgents().size();
    }
    ArrayList<Agent> ags = g.getAgents();
    int Trues = 0;
    for(int n= 0; n < ags.size(); n++){
      if(ags.get(n).getTribe()){
        Trues++;
      }
    }
    if(ags.size() == 0){
      return 0;
    }
    float proportion = (Trues * 100)/ags.size();
    return int(Y + (proportion));
  }
     public void update(SugarGrid g) {
    super.update(g);
  }
}


class AgentsVision extends LineGraph {
  public AgentsVision(int x, int y, int howWide, int howTall, String xlab, String ylab) {
    super(x, y, howWide, howTall, xlab, ylab);
    upd8calls = 0;
  }
  public int nextPoint(SugarGrid g) {
    ArrayList<Agent> Glasses = new ArrayList<Agent>(g.getAgents());
    int totalVision = 0;
    for (int n = 0; n < Glasses.size(); n++) {
      totalVision = totalVision + Glasses.get(n).getVision();
    }
    if (Glasses.size() == 0) {
      return 0;
    } else {
      return totalVision / Glasses.size() + (Y + (HT/3)*(Glasses.size() % 3));
    }
  }
}