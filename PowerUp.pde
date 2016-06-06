class PowerUp
{
  Shot shot;
  PVector position;
  float speed = 2;
  float x, y;
  PImage model = loadImage("heart.png");

  PowerUp(float x, float y)
  {
    this.x = x;
    this.y = y;
    this.position = new PVector(x, y);
  }

  void update()
  {
    PVector v1 = PVector.sub(ship.position, position);
    float distance = v1.mag();

    if (distance < 50)
    {
      ship.lives++;
    }
  }

  void render()
  {
      model.resize(25, 30);
      pushMatrix();
      translate((float)position.x, (float)position.y);
      image(model, -25, -30);
      point(position.x, position.y);
      popMatrix();
  }
}