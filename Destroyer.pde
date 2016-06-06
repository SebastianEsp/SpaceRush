class Destroyer
{ 
  PImage model;
  float speed;
  int lives;
  PVector position;

  Destroyer(PImage model, float speed, int lives, int x, int y)
  {
    this.model = model;
    this.lives = lives;
    this.speed = speed;
    this.position = new PVector(x, y);
  }

  public void update()
  {
    position.y += speed;
    if ( position.y > 980)
    {
      if (position.x > 0 && position.x < 1920)
      {
        ship.lives -= 1;
      }
      position.y = (int)random(-200, -50);
      position.x = (int)random(200, 1770);
      speed = (int)random(1, 4);
      lives = (int)random(2, 4);
    }
  }

  public void render()
  {
    {
      model.resize(70, 90);
      pushMatrix();
      translate((float)position.x, (float)position.y);
      image(model, -50, -70);
      point(position.x, position.y);
      popMatrix();
    }
  }
}