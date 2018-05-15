class Button{
  float Cx, Cy, Radius;
  String type;
  Button(float x, float y, float R, String t) {
    Cx = x;
    Cy = y;
    Radius = R;
    type = t;
  }
  
  boolean inside(float mx, float my){
    boolean finside = false;
    switch(type){
      case "CIRCLE":
        finside = ((pow(mx-Cx,2)+pow(my-Cy,2))<pow(Radius,2));
        break;
      case "SQUARE":
        finside = (abs(mx-Cx)<Radius) && (abs(my-Cy)<Radius);
        break;
      }
    return finside;
  }
}
