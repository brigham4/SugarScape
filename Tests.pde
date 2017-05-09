class SquareTester {
  void test() {
    Square s = new Square(7, 10, 0, 0);//SL=7, MS =10
    assert(s.getSugar() == 7);
    assert(s.getMaxSugar()==10);
    for (int n = 0; n < 10; n++) {
      s.setSugar(n);
      assert(s.getSugar() == n);
    }
    for (int n = 0; n < 10; n++) {
      s.setSugar(-n);
      assert(s.getSugar() == 0);
    }
    for (int n = 0; n < 7; n++) {
      s.setSugar(n+10);
      assert(s.getSugar() == 10);
      assert(s.getMaxSugar() == 10);
    }
  }
}

class GraphTest {
  void test() {
    Graph shoe = new Graph(50, 50, 350, 200, "Amt. Shoes", "Amt. Laces");
    shoe.update( new SugarGrid (40, 40, 40, new SeasonalGrowbackRule(1, 1, 1, 1, 1)));
  }
}

class VisualizationTest {
  public ArrayList<Agent> test() {
    int x = 500;
    int y = 400;
    int radius = 300;
    int agcount =8;
    AgentFactory AF = new AgentFactory(1, 1, 1, 1, 1, 1, new SugarSeekingMovementRule());
    ArrayList<Agent> ag = new ArrayList<Agent>();
    for (int n =0; n < agcount; n++) {
      ag.add(AF.makeAgent());
    }
    noFill();
    ellipse(x, y, 600, 600);
    for (int k = 0; k < ag.size(); k++) {
      if (k==0) {
        ag.get(k).display(x, y-radius, 20);
      }
      if (k==1) {
        ag.get(k).display(-87 + x+radius*sq(2)/4, 87 + y-radius*sq(2)/4, 20);
      }
      if (k==2) {
        ag.get(k).display(x+radius, y, 20);
      }
      if (k==3) {
        ag.get(k).display(-87 + x + radius*sq(2)/4, -87 + y+ radius*sq(2)/4, 20);
      }
      if (k==4) {
        ag.get(k).display(x, y+radius, 20);
      }
      if (k==5) {
        ag.get(k).display(87 + x-radius*sq(2)/4, -87 + y+radius*sq(2)/4, 20);
      }
      if (k==6) {
        ag.get(k).display(x-radius, y, 20);
      }
      if (k==7) {
        ag.get(k).display(87 + x-radius*sq(2)/4 , 87 + y-radius*sq(2)/4, 20);
      }
    }
    return ag;
  }
}