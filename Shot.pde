class Shot
{
  PImage model = loadImage("laser.png"), empty = loadImage("empty.png"), explosion = loadImage("explosion.png");
  float speedY2 = 10;
  PVector speedY = new PVector(0, -10);
  PVector position;
  float shotX2 = -72.5;
  float shotY2 = -100;
  float shotX = 1920;
  float shotY = 500;
  float x;
  float y;
  PowerUp powerUp;

  Shot(float x, float y)
  {
    this.x = x;
    this.y = y;
    this.position = new PVector(x, y);
  }

  public void render()
  {
    model.resize(100, 10);
    pushMatrix();
    translate(x, y);
    image(empty, position.x, position.y);
    image(model, shotX2, shotY2);
    popMatrix();
  }

  public void update()
  {
    if (position.y < 150)
    {
      position.x = 5000;
      shotX2 = 5000;
    }
    shotY2 -= speedY2;
    position.add(speedY);
  }

  boolean hit()
  {
    for (Destroyer dest : destroyer)
    {
      PVector v1 = PVector.sub(dest.position, position);
      float distance = v1.mag();
      if (distance < 50)
      {
        image(explosion, (int)random(dest.position.x-100, dest.position.x+50), (int)random(dest.position.y-100, dest.position.y+50));
        image(explosion, (int)random(dest.position.x-100, dest.position.x+50), (int)random(dest.position.y-50, dest.position.y+50));
        image(explosion, (int)random(dest.position.x-100, dest.position.x+50), (int)random(dest.position.y-50, dest.position.y+50));
        dest.lives -= 1;
        if (dest.lives <= 0)
        {
          dest.position.x = -1000;
          dest.position.y = 1070;
        }
        return true;
      }
    }
    return false;
  }
}