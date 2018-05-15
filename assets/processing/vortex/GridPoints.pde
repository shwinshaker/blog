class GridPoints extends PVector {

  PVector loc, vel; //vel -> velocity
  
  GridPoints(PVector loctemp) {
    loc = loctemp;
    vel = new PVector(0,0);
  }
  
  void update() {
    loc.add(vel);
    //point(loc.x, loc.y);
  }
}
