class TrigButton {
  
  float ax, ay, bx, by, cx, cy;
  TrigButton(float axt, float ayt, float bxt, float byt, float cxt, float cyt) {
    ax = axt;
    ay = ayt;
    bx = bxt;
    by = byt;
    cx = cxt;
    cy = cyt;
  }
  
  // Determine whether point P in triangle ABC
  boolean inside(float mx, float my) {
    
    PVector a = new PVector(ax, ay);
    PVector b = new PVector(bx, by);
    PVector c = new PVector(cx, cy);
    PVector p = new PVector(mx, my);

    float signOfTrig = (b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x);
    float signOfAB = (b.x - a.x)*(p.y - a.y) - (b.y - a.y)*(p.x - a.x);
    float signOfCA = (a.x - c.x)*(p.y - c.y) - (a.y - c.y)*(p.x - c.x);
    float signOfBC = (c.x - b.x)*(p.y - c.y) - (c.y - b.y)*(p.x - c.x);

    boolean d1 = (signOfAB * signOfTrig > 0);
    boolean d2 = (signOfCA * signOfTrig > 0);
    boolean d3 = (signOfBC * signOfTrig > 0);

    return d1 && d2 && d3;
  }
}
