class keyInput { //<>// //<>//

  int Key[];
  int Key_num;
  Screen screen;
  // 可変長引数
  keyInput(Screen screen, int... keys) {
    this.Key = keys;
    this.Key_num = keys.length;
    this.screen = screen;
  }


  ActionResult keyPressed() {

    ex();
    boolean trueKey = true;

    if (!trueKey) return new ActionResult(Actions.NoAction);
    return action(); // actionの戻り値をそのまま返す
  }

  void keyReleased() {
  }

  void ex() {

    //println("何らかのボタンが押された！");
    // 追加処理用(ボタンが違くても実行される)
  }

  // keyInputクラスのactionメソッドの戻り値をvoidからintに変更
  ActionResult   action() {
    println(key+"ボタンが押された！");
    return new ActionResult(Actions.NoAction); // デフォルトではスクリーン遷移しない
  }
}


class keyInput_title extends keyInput {
  keyInput_title(Screen screen, int... keys) {

    super(screen, keys);
  }

  // keyInput_titleクラスの修正
  @Override
    ActionResult action() {
    if (keyCode == ENTER) {
      return new ActionResult(Actions.ChangeScreen, 1); // 次のスクリーンID（main_menu）を返す
    }
    return new ActionResult(Actions.NoAction); // それ以外のキーでは遷移しない
  }
}

class keyInput_main_menu extends keyInput {
  keyInput_main_menu(Screen screen, int... keys) {

    super(screen, keys);
  }

  // keyInput_main_menuクラスの修正
  @Override
    ActionResult action() {
    switch (keyCode) {
    case RIGHT:
      return new ActionResult(Actions.ChangeScreen, 2); // main_gameのIDを返す
    case DOWN:
      return new ActionResult(Actions.ChangeScreen, 3); // InventoryのIDを返す    
    case BACK:
      return new ActionResult(Actions.ChangeScreen, 0); // TitleScreenのIDを返す
    }
    return new ActionResult(Actions.NoAction);
  }
}

class keyInput_main_game extends keyInput {
  keyInput_main_game(Screen screen, int... keys) {

    super(screen, keys);
  }

  @Override
    ActionResult action() {
 //<>// //<>//
    switch (keyCode) {
    case CONTROL:
      return new ActionResult(Actions.init_terrain);
    case ENTER:
      return new ActionResult(Actions.generate_terrain);
    case BACK:
      return new ActionResult(Actions.ChangeScreen, 1);
    case SPACE:
      return new ActionResult(Actions.ball_shoot);
    case SHIFT:
      return new ActionResult(Actions.ball_back);
    case 49:
      return new ActionResult(Actions.test2);
    case 50:
      return new ActionResult(Actions.test3);
    case 51:
      return new ActionResult(Actions.test4);
    case 52:
      return new ActionResult(Actions.test5);
    case 53:
      return new ActionResult(Actions.test6);
    case 54:
      return new ActionResult(Actions.test7);
    case 55:
      return new ActionResult(Actions.test8);
    case 56:
      return new ActionResult(Actions.test9);
    case 57:
      return new ActionResult(Actions.test10);
    case 48:
      return new ActionResult(Actions.test11);
    case 45:
      return new ActionResult(Actions.test12);
    case 98:
      return new ActionResult(Actions.test13);
    case 73:
      return new ActionResult(Actions.ChangeScreen, 3);
    case 83:
      return new ActionResult(Actions.ChangeScreen, 4);
    }
    return new ActionResult(Actions.NoAction);
  }
}

class keyInput_main_inventory extends keyInput {
  keyInput_main_inventory(Screen screen, int... keys) {

    super(screen, keys);
  }

  @Override
    ActionResult action() {

    switch (keyCode) {
    case CONTROL:
      return new ActionResult(Actions.init_terrain);
    case ENTER:
      return new ActionResult(Actions.generate_terrain);
    case UP:
    case BACK:
      return new ActionResult(Actions.ChangeScreen, 1);
    case SPACE:
      return new ActionResult(Actions.ball_shoot);
    case SHIFT:
      return new ActionResult(Actions.ball_back);
    case 73:
      return new ActionResult(Actions.ChangeScreen, 2);
    case 66:
      return new ActionResult(Actions.test);
    case 84:
      return new ActionResult(Actions.test2);
    case 65:
      return new ActionResult(Actions.test3);
    case 83:
      return new ActionResult(Actions.test4);
    case 69:
      return new ActionResult(Actions.test5);
    case 82:
      return new ActionResult(Actions.test6);
    case 68:
      return new ActionResult(Actions.test7);
      }
    return new ActionResult(Actions.NoAction);
  }
}
/*
class ScreenChange extends keyInput {
 
 int targetScreen;
 int change_mode;
 
 ScreenChange() {
 }
 }
 */
