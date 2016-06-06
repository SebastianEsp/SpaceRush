class Ship {
  ArrayList<Shot> shots = new ArrayList<Shot>();
  PImage playerModel, laser = loadImage("laser.png"), shield = loadImage("shield.png");
  float speed;
  float angle;
  PVector position;
  int lives;
  int originX = width/2;
  int originY = height/2;
  int score;
  int count = 0;
  float lastM = 0;
  float lastMove = 0;
  float shotDelay;
  float moveDelay = 100;
  boolean up, right, left, shift; 
  AudioPlayer playLaser = minim.loadFile("laser_sound.mp3");

  Ship(PImage playerModel, float speed, float shotDelay, int lives, float x, float y)
  {
    this.playerModel = playerModel;
    this.speed = speed;
    this.shotDelay = shotDelay;
    this.lives = lives;
    this.position = new PVector(x, y);
    playLaser.setGain(-10);
  }

  public void update()
  {
    score = count/60;
    count++;

    if (left && position.x > 150)
    {
      //x = originX + cos((float)count)*1200;
      //y = originY + sin((float)count)*550;
      position.x -= 12;
      //count += speed;
    } else if (right && position.x < 1920)
    {
      //x = originX + cos((float)count)*1300;
      //y = originY + sin((float)count)*550;
      //count -= speed;
      position.x+=12;
    }
    if (up)
    {
      if (millis() > lastM + shotDelay)
      {
        playLaser.play();
        shots.add(new Shot(position.x, position.y));
        lastM = millis();
        playLaser.rewind();
      }
    }
  }

  public void render()
  {
    if (keyPressed && keyCode == UP)
    { 
      pushMatrix();
      translate(position.x, position.y);
      //rotate(-angle);
      image(ship.playerModel, -70, -80);
      popMatrix();
    }
    pushMatrix();
    translate(position.x, position.y);
    //rotate(-angle);
    image(ship.playerModel, -70, -80);
    popMatrix();

    if (keyPressed && keyCode == SHIFT)
    {
      pushMatrix();
      translate(position.x, position.y);
      //rotate(-angle);
      image(shield, -70, -80);
      popMatrix();
    }
  }
}