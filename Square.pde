class Square {
  int SL, MS, xPos, yPos, Pol;
  Agent smith;  
  public Square(int sugarLevel, int maxSugarLevel, int x, int y) {
    //initializes a new Square with the specified initial and maximum sugar 
    //levels, and the specified x and y coordinates. The square should be unoccupied.
    SL = sugarLevel;
    MS = maxSugarLevel;
    xPos = x;
    yPos = y;
    Pol = 0;
  }

  public int getSugar() { //returns the current sugar level
    return SL;
  }

  public int getMaxSugar() { 
    // returns the maximum amount of sugar that can be stored here.
    return MS;
  }

  public int getX() {
    //returns the X coordinate of the square
    return xPos;
  }

  public int getY() {
    //returns the Y coordinate of the square
    return yPos;
  }

  public int getPollution() {
    return Pol;
  }

  public void setSugar(int howMuch) {
    if (howMuch < 0) {
      SL = 0;
    } else if (howMuch > MS) {
      SL=MS;
    } else {
      SL= howMuch;
    }
  }
  public void setMaxSugar(int howMuch) {
    if (howMuch < 0) {
      MS = 0;
    } else {
      MS=howMuch;
    }
    if (SL>MS) {
      SL=MS;
    }
  }

  public Agent getAgent() {
    return smith;
  }
  public void setAgent(Agent a) {
    if (a != null && smith != null && a != smith) {
      //assert(1==0);
    } else {
      this.smith = a;
    }
  }

  public void setPollution(int level) {
    Pol = level;
  }

  public void display(int size, String colour) {
    //Draws a Square. Not tested visually by the autograder. 
    //The Square should be drawn as a size*size square at position 
    //(size*xOffset, size*yOffset). The square should have a while boarder 4 pixels wide. 
    //The square should be colored as a function of its Sugar Levels. 
    //An example color scheme is to use shades of yellow: (255, 255, 255 - sugarLevel/6.0*255). 
    strokeWeight(4);
    stroke(255);
    fill(255, 255, 255 - SL/6.0*255);
    rect(size*xPos, size*yPos, size, size);
    if (smith != null) {
      //smith.display(size*xPos +size/2, size*yPos + size/2, size);
      smith.displaynot(size*xPos +size/2, size*yPos + size/2, size, colour);
    }
  }
}