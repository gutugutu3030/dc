boolean moveCamera=true;

boolean smoothCamera=true;
float speed=6;//キャラクタの移動速度　6
float acxy=speed/6;//カメラ移動の加速度 1



PImage t0, t1, haikei;

float hx=0, hy=0;
float cx=0, cy=0, dcx=0, dcy=0;

void setup() {
  size(1920, 1080, P3D);
  //size(800, 450, P3D);
  t0=loadImage("data/t0.png");
  t1=loadImage("data/t1.png");
  haikei=loadImage("data/haikei.png");
  initMap();
  keyinput = new KeyInput();
}

void draw() {
  background(120, 140, 200);
  drawMap1();
  if (!keyOperation()) {

    if (hx<cx) {
      if (dcx<0) {
        dcx=dcx+acxy;
      } else {
        cx=hx;
        dcx=0;
      }
    }
    if (cx<hx) {
      if (0<dcx) {
        dcx=dcx-acxy;
      } else {
        cx=hx;
        dcx=0;
      }
    }
    if (hy<cy) {
      if (dcy<0) {
        dcy=dcy+acxy;
      } else {
        cy=hy;
        dcy=0;
      }
    }
    if (cy<hy) {
      if (0<dcy) {
        dcy=dcy-acxy;
      } else {
        cy=hy;
        dcy=0;
      }
    }
  }

  cx=cx+dcx;
  cy=cy+dcy;
}

void drawMap1() {
  pushMatrix();
  {
    translate(width/2, height/3);
    scale(2);
    //image(t1,0,0,100,100);
    translate(0, 100, 0);
    //    rotateY((width/2-mouseX)*0.003);
    //    rotateX((height/2-mouseY)*0.003); 
    //    rotateY(wheel*0.015);
    setCamera();
    translate(0, 100, -200);
    if (smoothCamera) {
      translate(-cx, 0, -cy);
    }else{
      translate(-hx,0,-hy);
    }
    if (mousePressed) {
      ((PMatrix3D)getMatrix()).print();
    }
    pushMatrix();
    {
      translate(0, 0, -50);
      drawHome(200, 200, 200);
      pushMatrix();
      translate(300, 0, 0);
      drawHome(200, 200, 200);
      popMatrix();
      pushMatrix();
      translate(-300, 0, 0);
      drawHome(200, 200, 200);
      popMatrix();
      pushMatrix();
      translate(0, 0, 600);
      drawHome0(800, 50, 200);
      popMatrix();
    }
    popMatrix();
    pushMatrix();
    rotateX(PI/2);
    image(haikei, -1500, -200, 3000, 900);
    popMatrix();
    drawHuman(hx, hy, 100, /*2*/4.3);
  }
  popMatrix();
}

void drawHome0(int x, int y, int z) {
  drawHome(x, y, z, t0, t0);
}
void drawHome(int x, int y, int z) {
  drawHome(x, y, z, t0, t1);
}

void drawHome(int x, int y, int z, PImage t0, PImage t1) {
  pushMatrix();
  translate(0, 0, z/2);
  image(t1, -x/2, -y, x, y);
  popMatrix();
  pushMatrix();
  translate(0, 0, -z/2);
  image(t0, -x/2, -y, x, y);
  popMatrix();

  pushMatrix();
  translate(x/2, 0, 0);
  rotateY(PI/2);
  image(t0, -z/2, -y, z, y);
  popMatrix();
  pushMatrix();
  translate(-x/2, 0, 0);
  rotateY(PI/2);
  image(t0, -z/2, -y, z, y);
  popMatrix();


  pushMatrix();
  translate(0, -y, 0);
  rotateX(PI/2);
  image(t0, -x/2, -z/2, x, z);
  popMatrix();
}

void drawHuman(float x, float y/*z*/, int h, float n) {
  float n1=n-1;
  float r=h/n/2;
  float y1=h-r*2;
  pushMatrix();
  translate(x, -y1, y+200);
  sphere(r);
  translate(0, y1/2, 0);
  scale(20/n, y1, 20/n);
  box(1);
  popMatrix();
}

boolean keyOperation() {

  if (!keyinput.isPressing()) {
    return false;
  }

  if (keyinput.isPressing(java.awt.event.KeyEvent.VK_UP)) {
    hy-=speed;
  }
  if (keyinput.isPressing(java.awt.event.KeyEvent.VK_DOWN)) {
    hy+=speed;
  }
  if (keyinput.isPressing(java.awt.event.KeyEvent.VK_LEFT)) {
    hx-=speed;
  }
  if (keyinput.isPressing(java.awt.event.KeyEvent.VK_RIGHT)) {
    hx+=speed;
  }

  if (hx<cx) {
    dcx=max(dcx-acxy, -speed);
  }
  if (cx<hx) {
    dcx=min(dcx+acxy, speed);
  }


  if (hy<cy) {
    dcy=max(dcy-acxy, -speed);
  }
  if (cy<hy) {
    dcy=min(dcy+acxy, speed);
  }
  return true;
}

