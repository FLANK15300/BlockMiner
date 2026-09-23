// スクリーン関係処理 //<>// //<>// //<>//
// スクリーン遷移関数の宣言など
static class Screen {

  static int screenCount = 0;
  int Screen_id;
  int mode = 0;
  keyInput Input;


  Screen() {

    this.Screen_id = screenCount;
    screenCount++;
  }


  void main() {

    screen_update();
    
  }

  // ScreenクラスのkeyPressed()も戻り値を受け取るようにする
  ActionResult keyPressed() {
    if (Input != null) {
      return this.Input.keyPressed();
    }
    return new ActionResult(Actions.NoAction);
  }

  void mouseMoved() {
    // マウス移動時の処理
    // スクリーンごとにオーバーライドして実装してね
  }
  
  void mousePressed() {
    // マウス入力時の処理
    // スクリーンごとにオーバーライドして実装してね
  }
  void mouseDragged() {
    // マウスドラッグの処理
    // スクリーンごとにオーバーライドして実装してね
  }

  void mouseWheel() {
    // マウスホイール時の処理
    // スクリーンごとにオーバーライドして実装してね
  }

  void keyHolding() {
    // キー長押し処理(drawやupdateから常時呼び出す)
  }
  void screen_update() {

    //画面入力処理差分
  }

  void handleAction(ActionResult result) {
    switch (result.action) {
    case NoAction:
      return;
    case ChangeScreen:
      screen_mode = result.targetScreenId;
      this.close();
      return;
    default:
      return;
    }
  }

  void close() {
    // 画面終了時初期化処理
  }
}


/////////// 子クラス

class TitleScreen extends Screen { /////////// タイトルスクリーン、画面表示処理と入力処理呼び出し
  //@オーバーライド

  TitleScreen() {
    Input = new keyInput_title(this, SPACE, int(ENTER), int(UP), int(DOWN));
  }

  void screen_update() {

    background(0, 243, 255);
    textSize(104);
    text("TITLE", 20, 100);
  }
}


// スクリーンクラスの配置
void Screeninit() {

  //Screens.put(ScreenTTitle, new TitleScreen());
  Screens = (Screen[]) append(Screens, new TitleScreen());
  Screens = (Screen[]) append(Screens, new main_menu());
  Screens = (Screen[]) append(Screens, new main_game());
  Screens = (Screen[]) append(Screens, new main_inventory());
  Screens = (Screen[]) append(Screens, new main_shop());
  //Screens = (Screen[]) append(Screens, new test());
}
