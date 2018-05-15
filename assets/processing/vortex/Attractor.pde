
class Attractor {

  float x, y, r; 
  String attractMode;
  float strength=100;  
  float ramp=0.9;    //// 0.01 - 0.99
  int signx=0, signy=0;
  
  Attractor(float locX, float locY, float radius, String Mode) {
    x = locX;
    y = locY;
    r = radius;
    attractMode = Mode;
  }

  void attract(GridPoints points) {
    // calculate distance
    float dx = x - points.loc.x;
    float dy = y - points.loc.y;
    float d = mag(dx, dy);
    if (d > 0 && d < r) {
      float s = pow(d / r, 1 / ramp);
      float f = - s * 9 * strength * (1 / (s + 1) + ((s - 3) / 4)) / d;
      switch(attractMode){
        case "ClockWise": 
          signx = -1; signy = 1;
          break;
        case "Counter": 
          signx = 1; signy = -1;
          break;
        case "Slash": 
          signx = -1; signy = -1;
          break;
        case "BackSlash": 
          signx = 1; signy = 1;
          break;
      }
      points.vel.x = signx * dy * f;
      points.vel.y = signy * dx * f;
    }
  }
}
