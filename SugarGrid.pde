class SugarGrid {
  Square [] [] sgrid;
  int Width, Height, SL;
  Agent smith;
  GrowthRule grbr;
  FertilityRule fyru;
  ReplacementRule rtre;
  CombatMovementRule ctmtre;
  AgentFactory atfy;
  Map<Character, Integer[]> childbearing =  new HashMap<Character, Integer[]>();
  Map<Character, Integer[]> climacteric = new HashMap<Character, Integer[]>();
  Integer[] xandybegin = new Integer[2];
  Integer[] xend = new Integer[2];
  Integer[] yend = new Integer[2];
  String colour;
  public SugarGrid(int w, int h, int sideLength, GrowthRule g) { 
    //initializes a new SugarGrid object with a w*h grid of Squares, a sideLength for the squares (used for drawing
    //purposes only) of the specified value, and a sugar growback rule g. Initialize the Squares in the grid to have 0
    //initial and 0 maximum sugar.
    xandybegin[0] = 12;
    xandybegin[1] = 15;
    xend[0] = 40;
    xend[1] = 50;
    yend[0] = 60;
    yend[1] = 75;
    childbearing.put('X', xandybegin);
    childbearing.put('Y', xandybegin);
    climacteric.put('X', xend);
    climacteric.put('Y', yend);
    this.fyru = new FertilityRule(childbearing, climacteric);
    this.ctmtre = new CombatMovementRule(5);
    this.atfy = new AgentFactory(1, 2, 2, 8, 4, 8, ctmtre);
    //min met, max met, min viz, vax viz, min IS, max IS
    this.rtre = new ReplacementRule(60, 100, atfy);
    
    grbr = g;
    Width = w;
    Height = h;
    SL = sideLength;
    colour = "grey";
    sgrid = new Square [Width] [Height];
    for (int n = 0; n < Width; n++) {
      for (int k = 0; k < Height; k++) {
        sgrid [n] [k] = new Square(0, 0, n, k);
      }
    }
  }
  public int getWidth() {
    return Width;
  }

  public int getHeight() {
    return Height;
  }

  public int getSquareSize() {
    return SL;
  }

  public int getSugarAt(int i, int j) {
    return sgrid[i][j].getSugar();
  }

  public int getMaxSugarAt(int i, int j) {
    return sgrid[i][j].getMaxSugar();
  }

  public Agent getAgentAt(int i, int j) {
    return sgrid[i][j].getAgent();
  }

  public double euclidianDistance(Square a, Square b) {
    float DELTAX = min(abs(a.getX() - b.getX()), Width- abs(a.getX()- b.getX()));
    float DELTAY = min(abs(a.getY() - b.getY()), Height - abs(a.getY()-b.getY()));
    return Math.sqrt(Math.pow(DELTAX, 2) + Math.pow(DELTAY, 2));
  }

  public void addSugarBlob(int x, int y, int radius, int max) {
    Square cent = sgrid[x][y];
    for (int n = 0; n < Width; n++) {
      for (int k = 0; k < Height; k++) {
        Square something = sgrid[n][k]; 
        double howfar = euclidianDistance(cent, something);
        if (howfar <= radius) {
          if (howfar == 0) {
            if (cent.getMaxSugar() < max) {
              cent.setMaxSugar(max);
              cent.setSugar(max);
            } else {
              cent.setSugar(cent.getMaxSugar());
            }
          } else {
            if (something.getMaxSugar() < max -1) {
              something.setMaxSugar(max -1);
              something.setSugar(max -1);
            } else {
              something.setSugar(something.getMaxSugar());
            }
          }
        }
        for (int m =2; m < max; m++) {
          if (howfar <= m*radius && howfar > radius) {
            if (something.getMaxSugar() < max - m) {
              something.setMaxSugar(max - m);
              something.setSugar(max - m);
            } else {
              something.setSugar(something.getMaxSugar());
            }
          }
        }
      }
    }
  }

  public void placeAgent(Agent a, int x, int y) {
    sgrid[x][y].setAgent(a);
  }

  public LinkedList<Square> generateVision (int x, int y, int radius) {
    LinkedList<Square> viz = new LinkedList<Square>();
    int ox;
    int oy;
    if (radius == 0) {
      viz.add(sgrid[x][y]);
      return viz;
    }
    for (int n=1; n<= radius; n++) {
      if ( x >= Width || x < 0 || y >= Height || y < 0 || radius < 0) {
        assert(1==0);
      } else {
        viz.add(sgrid[x][y]);
        if (x + n >= Width) {
          ox= (x+n) - Width;
          viz.add(sgrid[ox][y]);
        } else {
          ox= x+n;
          viz.add(sgrid[ox][y]);
        }
        if (y+n >= Height) {
          oy = (y+n) - Height;
          viz.add(sgrid[x][oy]);
        } else {
          oy=y+n;
          viz.add(sgrid[x][oy]);
        }
        if (x - n < 0) {
          ox= Width - abs(x-n);
          viz.add(sgrid[ox][y]);
        } else {
          ox = x-n;
          viz.add(sgrid[ox][y]);
        }
        if (y-n < 0) {
          oy = Height - abs(y-n);
          viz.add(sgrid[x][oy]);
        } else {
          oy = y-n;
          viz.add(sgrid[x][oy]);
        }
      }
    }
    return viz;
  }

  /*viz.add(sgrid[x+n][y]);
   viz.add(sgrid[x][y+n]);
   viz.add(sgrid[x-n][y]);
   viz.add(sgrid[x][y-n]);
   }
   }
   
   return viz;
   }*/

  public void addAgentAtRandom(Agent a) {
    //inserts agent a at a randomly selected position on the grid. Make sure not to put the agent at a position 
    //that is already occupied! You may use any method you like to determine where the agent is placed, 
    //but it must place the agent at a different location each time, and it must be possible for the agent to 
    //be placed at any unoccupied location.
    LinkedList<Square> adder = new LinkedList<Square>();
    for (int n = 0; n < Width; n++) {
      for (int k = 0; k < Height; k++) {
        if (sgrid[n][k].getAgent() == null) {
          adder.add(sgrid[n][k]);
        }
      }
    }  
    float randnum = random(0, adder.size()-1);
    adder.get(int(randnum)).setAgent(a);
  }
  
  public void update() {
    for (int n = 0; n < Width; n++) {
      for (int k = 0; k < Height; k++) {
        smith = sgrid[n][k].getAgent();
        grbr.growBack(sgrid[n][k]);
        if (smith != null) {
          Square to_be_eaten = smith.getMovementRule().move(generateVision(n, k, smith.getVision()), this, sgrid[n][k]);
          smith.move(sgrid[n][k], to_be_eaten);
          placeAgent(smith, to_be_eaten.getX(), to_be_eaten.getY());
          smith.step();
          if (smith.isAlive() && !(rtre.replaceThisOne(smith))) {
            smith.eat(sgrid[n][k]);
            if(fyru.isFertile(smith)){
              LinkedList<Square> partner = generateVision(n, k, 1);
              for(int j = 0; j< partner.size(); j++){
                Square m8ing = partner.get(j);
                if(m8ing.getAgent() != null && m8ing.getAgent() != smith){
                  fyru.breed(smith, m8ing.getAgent(), partner, generateVision(m8ing.getX(), m8ing.getY(), 1));
                }
              }
            }
          } else {
            sgrid[n][k].setAgent(null);
            //placeAgent(rtre.replace(smith, new LinkedList<Agent>()), n, k);
          }
        }
      }
    }
  }

  public void display() {
    for (int n = 0; n < Width; n++) {
      for (int k = 0; k < Height; k++) {
        sgrid[n][k].display(SL, colour);
      }
    }
  }
  
  public ArrayList<Agent> getAgents(){
  //returns a list of all agents on the SugarGrid at present
  ArrayList<Agent> guys =  new ArrayList<Agent>();
  for (int n = 0; n < Width; n++) {
     for (int k = 0; k < Height; k++) {
        if(sgrid[n][k].getAgent() != null){
          guys.add(sgrid[n][k].getAgent());
        }
     }
  }
  return guys;
  }
  public void killAgent(Agent a){
    a.IS = 0;
    println("dead agent");
    fyru.isFertile(a);
  }
}