class main_inventory extends Screen { //////////インベントリー画面クラス

  ArrayList<ImageData> img = new ArrayList<ImageData>();
  int lv_ball = 1, lv_topaz = 0, lv_amethyst = 0, lv_sapphire = 0, lv_emerald = 0, lv_ruby = 0, lv_diamond = 0;
  ArrayList<FloatingText> effect = new ArrayList<FloatingText>();
  ArrayList<button> Button = new ArrayList<button>();
  ArrayList<SoundFile> SE = new ArrayList<SoundFile>();
  color levelUP = color(25, 207, 49);

  main_game gameScreen; // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する

  main_inventory() {

    Input = new keyInput_main_inventory(this, SPACE, int(ENTER), UP, DOWN, BACK, LEFT, RIGHT, SHIFT, 73, 76);
    int itemSize = 40;
    img.add(new ImageData("texture/items/topaz.png", itemSize, itemSize));
    img.add(new ImageData("texture/items/amethyst.png", itemSize, itemSize));
    img.add(new ImageData("texture/items/sapphire.png", itemSize, itemSize));
    img.add(new ImageData("texture/items/emerald.png", itemSize, itemSize));
    img.add(new ImageData("texture/items/ruby.png", itemSize, itemSize));
    img.add(new ImageData("texture/items/diamond.png", itemSize, itemSize));

    Button.add(new button(150, 300, 80, 40, "ボールを強化", new SoundFile(p, "sound/misc/cursor.wav"), null, "ball"));
    Button.add(new button(300, 300, 80, 40, "守護を強化", new SoundFile(p, "sound/misc/cursor.wav"), null, "topaz"));
    Button.add(new button(450, 300, 80, 40, "守護を強化", new SoundFile(p, "sound/misc/cursor.wav"), null, "amethyst"));
    Button.add(new button(600, 300, 80, 40, "守護を強化", new SoundFile(p, "sound/misc/cursor.wav"), null, "sapphire"));
    Button.add(new button(750, 300, 80, 40, "守護を強化", new SoundFile(p, "sound/misc/cursor.wav"), null, "emerald"));
    Button.add(new button(900, 300, 80, 40, "守護を強化", new SoundFile(p, "sound/misc/cursor.wav"), null, "ruby"));
    Button.add(new button(1050, 300, 80, 40, "守護を強化", new SoundFile(p, "sound/misc/cursor.wav"), null, "diamond"));
    
    Button.add(new button(20, 20, 64, 64, loadImage("texture/misc/back.png"), new SoundFile(p, "sound/misc/cursor.wav"), null, "back"));
    
    SE.add(new SoundFile(p, "sound/misc/fail.wav"));
    SE.add(new SoundFile(p, "sound/misc/level up.wav"));
    
    SE.get(0).amp(0.25);
    
    gameScreen = (main_game)Screens[2];
    
  }

  void screen_update() {
    background(210, 215, 247);
    textAlign(CENTER);
    fill(0);
    textSize(50);
    text("インベントリー", width/2, 60);


    gui();
  }

    void handleAction(ActionResult result) {

    switch (result.action) {
    case test:
      this.debug("ball", 50);
      return;
    case test2:
      this.debug("topaz", 50);
      return;
    case test3:
      this.debug("amethyst", 50);
      return;
    case test4:
      this.debug("sapphire", 50);
      return;
    case test5:
      this.debug("emerald", 50);
      return;
    case test6:
      this.debug("ruby", 50);
      return;
    case test7:
      this.debug("diamond", 50);
      return;
    default:
      super.handleAction(result);
    }
    }
      
  void gui() {
    stroke(0);
    int frameSize = 80;
    int x_offset = 50;
    strokeWeight(1);
    fill(200);
    rect(100 + x_offset, 150, frameSize, frameSize);
    rect(250 + x_offset, 150, frameSize, frameSize);
    rect(400 + x_offset, 150, frameSize, frameSize);
    rect(550 + x_offset, 150, frameSize, frameSize);
    rect(700 + x_offset, 150, frameSize, frameSize);
    rect(850 + x_offset, 150, frameSize, frameSize);
    rect(1000 + x_offset, 150, frameSize, frameSize);

    textSize(20);

    fill(255);
    int item_offset = 22;
    int textX;
    strokeWeight(2);
    rect(100 + x_offset + item_offset, 150 + item_offset, 35, 35);

    fill(0);
    textAlign(CENTER);

    textX = 100 + x_offset + 40;
    text("ボール", textX, 120);
    textSize(15);
    text("レベル: " + lv_ball, textX, 140);

    textSize(15);
    text("力: " + gameScreen.ball.strength, textX, 270);
    textSize(20);
    ///////
    fill(255);
    strokeWeight(2);
    img.get(0).draw(250 + x_offset + item_offset, 150 + item_offset);

    fill(0);
    textAlign(CENTER);
    text("トパーズ", 250 + x_offset + 40, 120);
   
    textSize(15);
    text("守護レベル: " + lv_topaz, 250 + x_offset + 40, 140);
    textSize(20);
    
    textX = 100 + x_offset + 40 + 150 * 1;
    textSize(15);
    text("力 × " + nf(gameScreen.ball.strength_magnification, 1, 2), textX, 270);
    textSize(20);
    ///////
    fill(255);
    strokeWeight(2);
    img.get(1).draw(400 + x_offset + item_offset, 150 + item_offset);

    fill(0);
    textAlign(CENTER);
    text("アメジスト", 400 + x_offset + 40, 120);
    textSize(15);
    text("守護レベル: " + lv_amethyst, 400 + x_offset + 40, 140);
    textSize(20);
    
    textX = 100 + x_offset + 40 + 150 * 2;
    textSize(13);
    text("ボールサイズ × " + nf(gameScreen.ball.size_magnification, 1, 2), textX, 270);
    textSize(20);    ///////
    fill(255);
    strokeWeight(2);
    img.get(2).draw(550 + x_offset + item_offset, 150 + item_offset);

    fill(0);
    textAlign(CENTER);
    text("サファイア", 550 + x_offset + 40, 120);
    textSize(15);
    text("守護レベル: " + lv_sapphire, 550 + x_offset + 40, 140);
    textSize(20);
    
    textX = 100 + x_offset + 40 + 150 * 3;
    textSize(15);
    text("鉱石採掘量 +" + nf(gameScreen.ball.ex_ore, 1, 1), textX, 270);
    textSize(20);    
    ///////
    fill(255);
    strokeWeight(2);
    img.get(3).draw(700 + x_offset + item_offset, 150 + item_offset);

    fill(0);
    textAlign(CENTER);
    text("エメラルド", 700 + x_offset + 40, 120);
    textSize(15);
    text("守護レベル: " + lv_emerald, 700 + x_offset + 40, 140);
    textSize(20);    

    textX = 100 + x_offset + 40 + 150 * 4;
    textSize(15);
    text("宝石採掘量 +" + nf(gameScreen.ball.ex_jewel, 1, 1), textX, 270);
    textSize(20);    
///////
    fill(255);
    strokeWeight(2);
    img.get(4).draw(850 + x_offset + item_offset, 150 + item_offset);

    fill(0);
    textAlign(CENTER);
    text("ルビー", 850 + x_offset + 40, 120);
    textSize(15);
    text("守護レベル: " + lv_ruby, 850 + x_offset + 40, 140);
    textSize(20);    

    textX = 100 + x_offset + 40 + 150 * 5;
    textSize(15);
    text("すべての採掘量 +" + nf(gameScreen.ball.ex_all, 1, 1), textX, 270);
    textSize(20);    
    ///////
    fill(255);
    strokeWeight(2);
    img.get(5).draw(1000 + x_offset + item_offset, 150 + item_offset);

    fill(0);
    textAlign(CENTER);
    text("ダイヤモンド", 1000 + x_offset + 40, 120);
    textSize(15);
    text("守護レベル: " + lv_diamond, 1000 + x_offset + 40, 140);
    textSize(20);

    textX = 100 + x_offset + 40 + 150 * 6;
    textSize(15);
    text("一撃確率: " + nf(gameScreen.ball.onePunch, 1, 1) + "%", textX, 270);
    textSize(20);
    
    fill(0 ,0 ,0);
    stroke(255, 255, 255);
    
    //text("TEST", 100, 500);
    for (button b : Button) {
      b.main();
    }
    
    for (button b : Button) {
          if (b.isMouseOnButton) {
        String temp = "";
        switch (b.Tag) {
        case "ball":
          temp = (lv_ball >= 15) ? "\n鉄 × " + str((lv_ball - 14) * 3) : "";
          detail("---必要素材---\n 石 × " + lv_ball * 3 + temp);
          break;
        case "diamond":
          detail("---必要素材---\n ダイヤモンド × " + (lv_diamond+1) * 5 + temp);
          break;
        case "topaz":
          detail("---必要素材---\n トパーズ × " + (lv_topaz+1) * 5 + temp);
          break;
        case "amethyst":
          detail("---必要素材---\n アメジスト × " + (lv_amethyst+1) * 5 + temp);
          break;
        case "emerald":
          detail("---必要素材---\n エメラルド × " + (lv_emerald+1) * 5 + temp);
          break;
        case "ruby":
          detail("---必要素材---\n ルビー × " + (lv_ruby+1) * 5 + temp);
          break;
        case "sapphire":
          detail("---必要素材---\n サファイア × " + (lv_sapphire+1) * 5 + temp);
          break;


        default:
          break;
        }
      }


      if (!b.run) continue;
      switch (b.Tag) {
      case "ball":
        ballLevelUP();
        break;
      case "topaz":
        topazLevelUP();
        break;
      case "amethyst":
        amethystLevelUP();
        break;
      case "sapphire":
        sapphireLevelUP();
        break;
      case "emerald":
        emeraldLevelUP();
        break;
      case "ruby":
        rubyLevelUP();
        break;
      case "diamond":
        diamondLevelUP();
        break;
      case "back":
        Screens[screen_mode].handleAction(new ActionResult(Actions.ChangeScreen, 2));
        break;
      default:
        break;
      }
    }

    // エフェクト的テキスト処理
    if (effect.size() > 0) {
      for (int i = effect.size() - 1; i >= 0; i--) {
        effect.get(i).main();
        if (!effect.get(i).isAlive) effect.remove(i);
      }
    }

    // ボタン押下時処理
    //Button
  }

  void ballLevelUP() {

    
     // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する

    int stone_needed = lv_ball * 3;
    int iron_needed  = (lv_ball >= 15) ? (lv_ball - 14) * 3: 0;

    println("必要素材: 石" + stone_needed + "個 鉄" + iron_needed + "個");
    println("所持素材: 石" + gameScreen.stone + "個 鉄" + gameScreen.iron + "個");

    if (stone_needed > gameScreen.stone || iron_needed > gameScreen.iron) {
      effect.add(new FloatingText("素材が足りない!", mouseX, mouseY, color(255, 0, 0)));
      SE.get(0).play();
    } else {
      // レベルアップ処理
      SE.get(1).play();
      effect.add(new FloatingText("LEVEL UP!", mouseX, mouseY, levelUP));
      lv_ball++;
      gameScreen.ball.strength += +1;
      gameScreen.stone -= stone_needed;
      gameScreen.iron -= iron_needed;
    }
  }

  void topazLevelUP() {

     // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する

    int topaz_needed  = 5 + lv_topaz * 5;
    
    if (topaz_needed > gameScreen.topaz) {
      effect.add(new FloatingText("素材が足りない!", mouseX, mouseY, color(255, 0, 0)));
      SE.get(0).play();
    } else {
      // レベルアップ処理
      SE.get(1).play();
      effect.add(new FloatingText("LEVEL UP!", mouseX, mouseY, levelUP));
      lv_topaz++;
      gameScreen.ball.strength_magnification += 0.01;
      gameScreen.topaz -= topaz_needed;
    }
  }
  
  void amethystLevelUP() {

     // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する

    int amethyst_needed  = 5 + lv_amethyst * 5;
    
    if (amethyst_needed > gameScreen.amethyst) {
      effect.add(new FloatingText("素材が足りない!", mouseX, mouseY, color(255, 0, 0)));
      SE.get(0).play();
    } else {
      // レベルアップ処理
      SE.get(1).play();
      effect.add(new FloatingText("LEVEL UP!", mouseX, mouseY, levelUP));
      lv_amethyst++;
      gameScreen.ball.size_magnification += 0.01;
      gameScreen.ball.update();
      gameScreen.amethyst -= amethyst_needed;
    }
  }
  
  void sapphireLevelUP() {

     // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する

    int sapphire_needed  = 5 + lv_sapphire * 5;
    
    if (sapphire_needed > gameScreen.sapphire) {
      effect.add(new FloatingText("素材が足りない!", mouseX, mouseY, color(255, 0, 0)));
      SE.get(0).play();
    } else {
      // レベルアップ処理
      SE.get(1).play();
      effect.add(new FloatingText("LEVEL UP!", mouseX, mouseY, levelUP));
      lv_sapphire++;
      gameScreen.ball.ex_ore += 0.1;
      gameScreen.sapphire -= sapphire_needed;
    }
  }
  
  void emeraldLevelUP() {

     // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する

    int emerald_needed  = 5 + lv_emerald * 5;
    
    if (emerald_needed > gameScreen.emerald) {
      effect.add(new FloatingText("素材が足りない!", mouseX, mouseY, color(255, 0, 0)));
      SE.get(0).play();
    } else {
      // レベルアップ処理
      SE.get(1).play();
      effect.add(new FloatingText("LEVEL UP!", mouseX, mouseY, levelUP));
      lv_emerald++;
      gameScreen.ball.ex_jewel += 0.1;
      gameScreen.emerald -= emerald_needed;
    }
  }
  
  void rubyLevelUP() {

     // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する

    int ruby_needed  = 5 + lv_ruby * 5;
    
    if (ruby_needed > gameScreen.ruby) {
      effect.add(new FloatingText("素材が足りない!", mouseX, mouseY, color(255, 0, 0)));
      SE.get(0).play();
    } else {
      // レベルアップ処理
      SE.get(1).play();
      effect.add(new FloatingText("LEVEL UP!", mouseX, mouseY, levelUP));
      lv_ruby++;
      gameScreen.ball.ex_all += 0.1;
      gameScreen.ruby -= ruby_needed;
    }
  }  
  void diamondLevelUP() {

     // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する

    int diamond_needed  = 5 + lv_diamond * 5;
    
    if (diamond_needed > gameScreen.diamond) {
      effect.add(new FloatingText("素材が足りない!", mouseX, mouseY, color(255, 0, 0)));
      SE.get(0).play();
    } else {
      // レベルアップ処理
      SE.get(1).play();
      effect.add(new FloatingText("LEVEL UP!", mouseX, mouseY, levelUP));
      lv_diamond++;
      gameScreen.ball.onePunch += 0.1;
      gameScreen.diamond -= diamond_needed;
    }
  }
  
  void debug(String type, int level) {
     // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する

      SE.get(1).play();
    switch (type){
      case "ball":
        lv_ball += level;
        gameScreen.ball.strength += 1 * level;    
        break;
      case "topaz":
        lv_topaz += level;
        gameScreen.ball.strength_magnification += 0.01 * level;    
        break;
      case "amethyst":
        lv_amethyst += level;
        gameScreen.ball.size_magnification += 0.01 * level;    
        break;
      case "sapphire":
        lv_sapphire += level;
        gameScreen.ball.ex_ore += 0.1 * level;    
        break;
      case "emerald":
        lv_emerald += level;
        gameScreen.ball.ex_jewel += 0.1 * level;    
        break;
      case "ruby":
        lv_ruby += level;
        gameScreen.ball.ex_all += 0.1 * level;    
        break;
      case "diamond":
        lv_diamond += level;
        gameScreen.ball.onePunch += 0.1 * level;    
        break;
    }

      // レベルアップ処理
      effect.add(new FloatingText("LEVEL UP!", mouseX, mouseY, levelUP));
  }

  void detail(String text) {
    String[] line_split = text.split("\n");
    int max_length = 0;
    int line = line_split.length;
    for (String temp : line_split){
      max_length = max(max_length, temp.length());
    }
    
    int textSize = 10;
    int boxw =  max_length * textSize, boxh = line * (textSize * 2);
    noStroke();
    fill(0, 200);
    rect(mouse.x, mouse.y, boxw, boxh);
    textAlign(LEFT, TOP );
    textSize(textSize);
    fill(255);
    text(text, mouse.x, mouse.y + 3);
    
  }
}
