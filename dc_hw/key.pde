KeyInput keyinput;

public void keyPressed(java.awt.event.KeyEvent e) {
  //TODO: キーが押された時の処理を書いてください
  keyinput.keyPressed(e);
}

public void keyReleased(java.awt.event.KeyEvent e) {
  //TODO: キーが離された時の処理を書いてください
  keyinput.keyReleased(e);
}

public class KeyInput {
  //TODO: この位置に変数の宣言をしてください
  private boolean isUP   = false;
  private boolean isDOWN  = false;
  private boolean isLEFT  = false;
  private boolean isRIGHT = false;

  public KeyInput() {
  }

  public boolean isPressing(int iKeyCode) {
    switch (iKeyCode) {
    case java.awt.event.KeyEvent.VK_UP:
      return isUP;
    case java.awt.event.KeyEvent.VK_DOWN:
      return isDOWN;
    case java.awt.event.KeyEvent.VK_LEFT:
      return isLEFT;
    case java.awt.event.KeyEvent.VK_RIGHT:
      return isRIGHT;
    }
    return false;
  }
  public boolean isPressing(){
    return isUP||isDOWN||isLEFT||isRIGHT;
  }

  public void keyPressed(java.awt.event.KeyEvent e) {
    switch (e.getKeyCode()) {
    case java.awt.event.KeyEvent.VK_UP:
    println("UP");
      isUP = true;
      break;
    case java.awt.event.KeyEvent.VK_DOWN:
    println("DOWN");
      isDOWN = true;
      break;
    case java.awt.event.KeyEvent.VK_LEFT:
    println("LEFT");
      isLEFT = true;
      break;
    case java.awt.event.KeyEvent.VK_RIGHT:
    println("RIGHT");
      isRIGHT = true;
      break;
    }
  }

  public void keyReleased(java.awt.event.KeyEvent e) {
    switch (e.getKeyCode()) {
    case java.awt.event.KeyEvent.VK_UP:
      isUP = false;
      break;
    case java.awt.event.KeyEvent.VK_DOWN:
      isDOWN = false;
      break;
    case java.awt.event.KeyEvent.VK_LEFT:
      isLEFT = false;
      break;
    case java.awt.event.KeyEvent.VK_RIGHT:
      isRIGHT = false;
      break;
    }
  }
}

float wheel=0;

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  wheel+=e;
}

