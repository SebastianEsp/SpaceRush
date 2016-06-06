import processing.core.*;
import java.util.Iterator;
import ddf.minim.*;

Minim minim;
AudioPlayer playExplosion;
AudioPlayer playMusic;
Destroyer[] destroyer = new Destroyer[5];
String[] enemies = new String[3];
Ship ship;
Shot shot;
PowerUp powerUp;
Destroyer dest;
PImage bg, earth, endZoneG, endZoneY, endZoneR;
boolean enter;

public void setup()
{
  fullScreen();
  background(0);
  frameRate(300);
  smooth();
  noStroke();
  imageMode(CENTER);
  rectMode(CENTER);
  bg = loadImage("bg\\corona_up.png");
  bg.resize(width, height);
  earth = loadImage("earth.png");
  earth.resize(120, 120);

  minim = new Minim(this);
  playExplosion = minim.loadFile("ex.wav");
  playMusic = minim.loadFile("music.mp3");
  playMusic.play();

  endZoneG = loadImage("endZoneG.png");
  endZoneG.resize(2000, 1080);
  endZoneY = loadImage("endZoneY.png");
  endZoneY.resize(2000, 1080);
  endZoneR = loadImage("endZoneR.png");
  endZoneR.resize(2000, 1080);

  enemies[0] = "enemies\\destroyer.png";
  enemies[1] = "enemies\\drone.png";
  enemies[2] = "enemies\\alienship.png";

  chooseShip("player\\redfighter0005.png");
  ship.playerModel.resize(70, 80);
  ship.shield.resize(100, 110);
  spawnDestroyer();
}

public void draw()
{    
  background(bg);
  image(endZoneG, width/2+20, height-400);
  if (ship.lives == 2)
  {
    image(endZoneY, width/2+20, height-400);
  } else if (ship.lives == 1)
  {
    image(endZoneR, width/2+20, height-400);
  }
  image(earth, width/2, height/2);
  ship.render();
  ship.update();
  for (Destroyer dest : destroyer)
  {
    dest.render();
    dest.update();
  }

  for (Iterator<Shot> shot = ship.shots.iterator(); shot.hasNext(); )
  {
    Shot shot2 = shot.next();
    shot2.update();
    shot2.render();
    shot2.explosion.resize(70, 70);
    if (shot2.hit() == true && shot2.position.y > 150)
    {
      playExplosion.play();
      shot.remove();
      playExplosion.rewind();
    }
    if (shot2.position.y < 150)
    {
      shot.remove();
    }
  }
  //powerUp.update();
  //powerUp.render();
  gameOver();
  gui();
}

public void chooseShip(String name) //Currently only one player modele exists, but allows for choice between several models in the future
{
  ship = new Ship(loadImage(name), 0.015, 200, 3, 1040, 1080);
}

public void spawnDestroyer()
{
  for (int i = 0; i < 5; i++)
  {
    destroyer[i] = new Destroyer(loadImage(enemies[(int)random(0, 3)]), (int)random(1, 4), (int)random(2, 4), (int)random(200, 1770), -50);
  }
}

public void gui()
{
  textSize(26);
  text("Health: " + ship.lives, 20, 40);
  text("Score:  " + ship.score, 20, 80);
  text("FPS:    " + (int)frameRate, 20, 120);
}

public void gameOver()
{
  if (ship.lives <=0)
  {
    textSize(46);
    text("GAME OVER", width/2-152, height/2);
    textSize(32);
    text("Final Score: " + ship.score, width/2-150, height/2+80);
    text("Press Start To Play Again", width/2-150, height/2+120);
    noLoop();
  }
}

void keyPressed() 
{
  switch(keyCode) 
  {
  case UP:
    ship.up = true;
    break;
  case LEFT:
    ship.left = true;
    break;
  case RIGHT:
    ship.right = true;
    break;
  case SHIFT:
    ship.shift = true;
    break;
  case ENTER:
    ship.lives = 3;
    ship.count = 0;
    ship.position.x = 1040;
    ship.position.y = 1080;
    for (int i = 0; i < 5; i++)
    {
      destroyer[i].position.y = (int)random(-200, -50);
      destroyer[i].position.x = (int)random(200, 1770);
      destroyer[i].speed = (int)random(1, 3);
      destroyer[i].lives = (int)random(2, 4);
    }
    playMusic.rewind();
    loop();
    break;
  }
}

void keyReleased() 
{
  switch(keyCode) 
  {
  case UP:
    ship.up = false;
    break;
  case LEFT:
    ship.left = false;
    break;
  case RIGHT:
    ship.right = false;
    break;
  case SHIFT:
    ship.shift = false;
    break;
  case ENTER:
    enter = false;
    break;
  }
}