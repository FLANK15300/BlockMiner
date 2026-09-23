import java.util.Map;
import processing.sound.*;
SoundFile SE;

static HashMap<String, Boolean> keyState = new HashMap<String, Boolean>();
//HashMap<ScreenType, Screen> Screens = new HashMap<ScreenType, Screen>();

final static public int BIGNUM = 1000000000;
static int screen_mode = 0;
color cl_sky = color(0, 243, 255);
static Screen[] Screens = new Screen[0];
static boolean command = false;
static main_game game; // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する


int debugMode = 0;
static block lastHit;
static int lastHit_array[] = new int[2];
PFont F_pixel, Default;
static int errorType;
int frame, time_sec;
boolean timer;
Mouse mouse;
static PApplet p;
//キーコードの宣言(使いやすくしたい)
    final int key_a = 'A';
  final int key_f = 'F';
  final int key_d = 'D';
  final int key_j = 'J';
  final int key_k = 'K';
  final int BACK = 8;
  final int SPACE = 32;
final int mosue_left = 37;
final int mosue_right = 39;
final int mosue_wheel = 3;
final int f = 3;

void setup() {
  size(1280, 720);
  p = this;
  
  init();
  mouse = new Mouse();
  frameRate(120);
  game = (main_game) Screens[2];
}

void draw(){
   //<>// //<>// //<>// //<>//
  if(errorType != 0) {
      error();
      
      return;
  }
  
  fill(255);
  Screen();
  Screens[screen_mode].keyHolding();
  if (debugMode != 0) debugInfo(); // debug表示

  mouse.update(this);

  if (command) Command.run();
}

// メインスケッチのkeyPressed()
void keyPressed() {
  
  if (keyCode == 47) command = true;
  if (keyCode == 27) command = false;
  
  if(command){
    Command.input(keyCode, key);
    return;
  }
  key = (key == ESC) ? 0 : key;
  
//  println(keyCode); //キーコード取得用
  if (keyCode == SHIFT) frameRate = 30; //<>// //<>//
  // HashMapを使って"keyCode"要素が押されていることを保存(trueに変更)
  String keyStr;
  if (key == CODED) keyStr = CODEDtoString(); 
  else keyStr = str(key).toLowerCase();
  keyState.put(keyStr, true);
  
  
  if (Screens.length > screen_mode) { //<>// //<>//
    // 現在のスクリーンのkeyPressedを呼び出し、遷移先のIDを受け取る //<>// //<>//
    ActionResult result = Screens[screen_mode].keyPressed(); 
    
    Screens[screen_mode].handleAction(result);
    }
    
    if(key == '"') debugMode++; // 2キーでデバッグ切り替え

    debugMode %= 3;
}

void keyReleased(){
  

  String keyStr;
  if (key == CODED) keyStr = CODEDtoString(); 
  else keyStr = str(key).toLowerCase();
  // HashMapを使って"keyCode"要素が押されていない状態に変更(falseに変更)
  // fun fact: keyCodeの内容はキー入力時に入力されたキーが代入されるのはみんな知ってると思うけど、キーが離されるkeyReleaseイベント時にも、離されたキーが代入される。
  keyState.put(keyStr, false);
  
  
}

void mousePressed(){
  
  Screens[screen_mode].mousePressed();
  
}
void mouseMoved(){
  
  Screens[screen_mode].mouseMoved();
  
}

void mouseDragged(){
  
 // Screens[screen_mode].mouseDragged();
  
}




/*



*/
