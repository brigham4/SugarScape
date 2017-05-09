SugarGrid aGrid;
Graph ShoeAndLace;
SurvivingAgents walkingbread;
AgentsVision sad;
VisualizationTest seeme;
SocialNetwork sn;
ArrayList<Agent> a;
MeanAgentWealth sadboys;
DominantCulture mazzetti;

void setup(){
  size(1300,800);
  aGrid = new SugarGrid(40,40,20, new GrowbackRule(1));
  aGrid.addSugarBlob(15,15,5,5);
  aGrid.addSugarBlob(30,30,5,5);
  /*Agent a1 = new Agent(3, 1, 6, new SugarSeekingMovementRule());
  Agent a2 = new Agent(3, 2, 6, new SugarSeekingMovementRule());
  Agent a3 = new Agent(3, 3, 6, new SugarSeekingMovementRule());
  aGrid.placeAgent(a1,10,30);
  aGrid.placeAgent(a2,20,20);
  aGrid.placeAgent(a3,10,10);
  walkingbread = new SurvivingAgents(800,600, 150, 100, "Time", "Agents Alive");
  sad = new AgentsVision(800,450, 150, 100, "Time", "Average Vision");
  aGrid.display();
  frameRate(2);*/
  for (int n = 0; n < 150; n++){
    Agent johnson = new Agent(1, 1, 5, new CombatMovementRule(5));
    aGrid.addAgentAtRandom(johnson);
  }
  walkingbread = new SurvivingAgents(850,0, 400, 200, "Time", "Agents Alive");
  sadboys = new MeanAgentWealth(850, 500, 400, 200, "Time", "Average Wealth");
  mazzetti = new DominantCulture(850,250,400,200, "Time", "Dominant Culture");
  /*a= new ArrayList<Agent>();
  for(int n = 0; n < seeme.test().size(); n++){
    a.add(seeme.test().get(n));
  }
  for(int m = 0; m < a.size(); m++){
    aGrid.addAgentAtRandom(a.get(m));
  }
  
  sn = new SocialNetwork(aGrid);
  */
  aGrid.display();
  frameRate(10);
}

void draw(){
  aGrid.update();
  fill(255);
  aGrid.display();
  //seeme.test();
  //aGrid.display();
  walkingbread.update(aGrid);
  sadboys.update(aGrid);
  mazzetti.update(aGrid);
  //sad.update(aGrid);
  
}

void keyPressed(){
  if(key == 'c'){
    aGrid.colour = "culture";
  }
}