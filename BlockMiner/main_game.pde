class main_game extends Screen { //////////メインゲーム画面子クラス

  int depth; // 現在の深さ(y座標)
  int generateDepth; // 地形生成時に使用する深さ(生成時は、プレイヤーが潜った深さより先の地形も生成するので)
  // block[][] blocks = new block[16][16];
  ArrayList<block[]> blocks = new ArrayList<block[]>();//ブロック配列
  ArrayList<block> gui = new ArrayList<block>(); // guiに使うブロック
  HashMap<String, SoundFile> SE = new HashMap<String, SoundFile>(); // 効果音
  int topline = 0; // 一番上の行
  // ブロック崩し関連
  boolean isTopOpened = false;
  float angle = 90; // ブロック発射角度
  boolean isShooted = false; //発射後か否か
  ArrayList<button> button = new ArrayList<button>(); // ボタン
  HashMap<String, Integer> timer = new HashMap<String, Integer>();
  float camera = 0;
  // グローバル変数として、地形の最下点を管理する変数を宣言
  float terrainBottomY;
  final float TILE_SIZE = 32;

  boolean animating = false;
  float dirt = 0, stone = 0, iron = 0, gold = 0, topaz = 0, amethyst = 0, sapphire = 0, emerald = 0, ruby = 0, diamond = 0;
  //////// 座標ごとの鉱石生成割合情報 (仮)
  terrainData y0 = new terrainData(new weightedItem("grass", 1));
  terrainData y1 = new terrainData(new weightedItem("dirt", 1));
  terrainData y4 = new terrainData(new weightedItem("dirt", 5), new weightedItem("stone", 3));
  terrainData y6 = new terrainData(new weightedItem("dirt", 5), new weightedItem("stone", 94), new weightedItem("iron", 1));
  terrainData y16 = new terrainData(new weightedItem("dirt", 5), new weightedItem("stone", 91), new weightedItem("iron", 4));
  terrainData y24 = new terrainData(new weightedItem("iron", 7), new weightedItem("gold", 3), new weightedItem("topaz", 0.1), new weightedItem("stone", 89));
  terrainData y32 = new terrainData(new weightedItem("iron", 10), new weightedItem("gold", 5), new weightedItem("topaz", 0.5), new weightedItem("stone", 83));
  terrainData y50 = new terrainData(new weightedItem("iron", 17), new weightedItem("gold", 7), new weightedItem("topaz", 1), new weightedItem("amethyst", 0.5), new weightedItem("stone", 70));
  terrainData y100 = new terrainData(new weightedItem("iron", 20), new weightedItem("gold", 10), new weightedItem("topaz", 2), new weightedItem("amethyst", 1), new weightedItem("stone", 67));
  terrainData y150 = new terrainData(new weightedItem("iron", 20), new weightedItem("gold", 14), new weightedItem("topaz", 4), new weightedItem("amethyst", 3), new weightedItem("sapphire", 1), new weightedItem("stone", 58));
  terrainData y200 = new terrainData(new weightedItem("iron", 20), new weightedItem("gold", 15), new weightedItem("topaz", 4), new weightedItem("amethyst", 3), new weightedItem("sapphire", 2), new weightedItem("stone", 56));
  terrainData y250 = new terrainData(new weightedItem("iron", 20), new weightedItem("gold", 15), new weightedItem("topaz", 4), new weightedItem("amethyst", 3), new weightedItem("sapphire", 2), new weightedItem("emerald", 0.5), new weightedItem("ruby", 0.1), new weightedItem("diamond", 0.05), new weightedItem("stone", 56));
  terrainData y300 = new terrainData(new weightedItem("iron", 15), new weightedItem("gold", 10), new weightedItem("topaz", 4), new weightedItem("amethyst", 4), new weightedItem("sapphire", 3), new weightedItem("emerald", 1.5), new weightedItem("ruby", 1), new weightedItem("diamond", 0.5), new weightedItem("stone", 56));
  terrainData y350 = new terrainData(new weightedItem("iron", 15), new weightedItem("gold", 10), new weightedItem("topaz", 4), new weightedItem("amethyst", 4), new weightedItem("sapphire", 4), new weightedItem("emerald", 2), new weightedItem("ruby", 1.5), new weightedItem("diamond", 1), new weightedItem("stone", 58.5));
  terrainData y400 = new terrainData(new weightedItem("iron", 15), new weightedItem("gold", 10), new weightedItem("topaz", 4), new weightedItem("amethyst", 4), new weightedItem("sapphire", 4), new weightedItem("emerald", 3), new weightedItem("ruby", 2), new weightedItem("diamond", 1.5), new weightedItem("stone", 55));
  terrainData y500 = new terrainData(new weightedItem("iron", 15), new weightedItem("gold", 10), new weightedItem("topaz", 4), new weightedItem("amethyst", 4), new weightedItem("sapphire", 4), new weightedItem("emerald", 4), new weightedItem("ruby", 4), new weightedItem("diamond", 4), new weightedItem("stone", 55));

  // ラケットクラス
  racket racket = new racket(width/2, 100, 50, 10, 0);
  //racket racket2 = new racket(width/2, 100, 50, 10, 30);

  arrow ballDirection = new arrow(racket.x, racket.y, 20, PI/4);

  ArrayList<ball> balls = new ArrayList<ball>();
  ArrayList<FloatingText> floatText = new ArrayList<FloatingText>();
  ball ball = new ball("normal", racket.x, racket.y, 1);
  main_game() {
    Input = new keyInput_main_game(this, SPACE, int(ENTER), int(UP), int(DOWN), BACK, int(LEFT), int(RIGHT), SHIFT, 49, 51, 52, 73, 48);
    init_terrain();
    //balls.add(new ball())

    gui.add(new block("dirt", 950 + 96 * 0.5, 100 + 48  * -1, 100000, 0, 0, this));

    gui.add(new block("stone", 950 + 96 * 0, 100 + 48  * 0, 100000, 0, 0, this));
    gui.add(new block("iron", 950 + 96 * 0, 100 + 48  * 1, 100000, 0, 0, this));
    gui.add(new block("gold", 950 + 96 * 0, 100 + 48  * 2, 100000, 0, 0, this));

    gui.add(new block("topaz", 950 + 96 * 1, 100 + 48  * 0, 100000, 0, 0, this));
    gui.add(new block("amethyst", 950 + 96 * 1, 100 + 48  * 1, 100000, 0, 0, this));
    gui.add(new block("sapphire", 950 + 96 * 1, 100 + 48  * 2, 100000, 0, 0, this));

    gui.add(new block("emerald", 950 + 96 * 2, 100 + 48  * 0, 100000, 0, 0, this));
    gui.add(new block("ruby", 950 + 96 * 2, 100 + 48  * 1, 100000, 0, 0, this));
    gui.add(new block("diamond", 950 + 96 * 2, 100 + 48  * 2, 100000, 0, 0, this));
    
    SE.put("shoot",new SoundFile(p, "sound/misc/shoot.wav"));
    SE.put("racket",new SoundFile(p, "sound/misc/racket.wav"));
    
    button.add(new button(50, 250, 64, 64, loadImage("texture/misc/shop.png"), new SoundFile(p, "sound/misc/cursor.wav"), null, "shop"));
    button.add(new button(120, 250, 64, 64, loadImage("texture/misc/bag.png"), new SoundFile(p, "sound/misc/cursor.wav"), new SoundFile(p, "sound/misc/bag.wav"), "bag"));
    button.add(new button(190, 250, 64, 64, "帰る", new SoundFile(p, "sound/misc/cursor.wav"), null, "home"));

   timer.put("sound.racket.delay", 30);
    
  }

  @Override
    void screen_update() { // 画面の更新
    background(0, 243, 255);
    textSize(104);
    text("", 20, 100);




    fill(0);

    int HitType = 0;
    int temp = 0;
    boolean isHited = false;
    for (int k = 0; k < blocks.size(); k++) {
      int index = 0;
      for (block b : blocks.get(k)) {
        if (topline == k) isTopOpened = (b.durabity <= 0) ? true : isTopOpened;
        if (!(b.y <= height)) continue;
        b.draw();
        String hitBlockType = "";
        
        if (b.durabity <= 0 || b.y < 200) continue;
        HitType = blockHitCheck(b.x, b.y, block.blockSize, block.blockSize, ball.pos.x, ball.pos.y, ball.size, ball.size, ball.vec.x, ball.vec.y);
        if (HitType != 0) {
          hitBlockType = b.hit(ball, index, k);
          if (hitBlockType != "") {
            breakBlock(hitBlockType);
            temp = 0;
            isHited = true;
          }
          if (isHited) continue;
          temp = (temp == 0) ? HitType : temp;
          isHited = true;
      }
        index++; // 処理中のインデっクスを取得
      }
    }

          switch (temp) {
          case 1:
            ball.vec.x *= -1;
            break;
          case 2:
            ball.vec.y *= -1;
            ball.pos.y += ball.vec.y;
            ball.vec.y = (abs(ball.vec.y) < 1)  ? 0 : ball.vec.y;
            ball.acceleration.y = (abs(ball.vec.y) < 1)  ? 0 : ball.acceleration.y;
            break;
          case 3:
            ball.vec.mult(-1);
            ball.pos.x += ball.vec.x;
            ball.pos.y += ball.vec.y;
            ball.vec.y = (abs(ball.vec.y) < 1)  ? 0 : ball.vec.y;
            ball.acceleration.y = (abs(ball.vec.y) < 1)  ? 0 : ball.acceleration.y;
            break;
          }

    noStroke();
    fill(0, 125);
    rect(640 - 32*8, 0, 32*16, 200);
    fill(0);
    rect(0, 0, 385, height);
    rect(895, 0, 385, height);
    stroke(0);

    // ラケットの描画と更新
    racket.main();
    //racket2.main();

    // ボール

if (isShooted) {
  ball.main(); // ball.update() の方が分かりやすいかも！

  if (ball.pos.y > 490) {
    // 1. このフレームでのスクロール量を計算
    float scrollAmount = ball.pos.y - 490;

    // 2. オブジェクトの位置を更新
    camera += scrollAmount; // カメラの総移動量を更新
    ball.pos.y = 490;       // ボールを基準線に戻す

    // 全てのブロックを、計算したスクロール量だけ上に動かす
    for (int k = 0; k < blocks.size(); k++) {
      for (block b : blocks.get(k)) {
        b.y -= scrollAmount;
      }
    }

    // 3. 新しい地形を生成（ブロック移動のループの外で！）
    // camera 変数を「地形生成の残りタスク量」として使う
    // whileループの方が自然かも
    final float TILE_SIZE = 32; // 「マジックナンバー」を定数にすると分かりやすい！
    while (camera >= TILE_SIZE) {
      generate_terrain();
      camera -= TILE_SIZE;
    }
  }
} else {
      ball.draw();
      ball.pos.x = racket.x - ball.size/2;
      ball.pos.y = racket.y + 2 + ball.size/2;
    }
    //
    ballDirection.main(racket.x, racket.y, (angle/360) * (2*PI));

    

    gui();

  }
  
  @Override
  void mousePressed(){
    block nearest = blocks.get(0)[0];
    float minDistance = BIGNUM;
    PVector mousePos = new PVector(mouse.x, mouse.y);
    PVector blockPos;
    float distance = 0;
    for (int k = 0; k < blocks.size(); k++) {
      for (block b : blocks.get(k)) {
        blockPos = new PVector(b.x + block.blockSize/2, b.y + block.blockSize/2);
        distance = PVector.dist(mousePos, blockPos);
        if(minDistance > distance) nearest = b;
        minDistance = min(minDistance, distance);
      }
    }    
    
    if (nearest.durabity == 0) return;
    nearest.durabity = 0;
    breakBlock(nearest.type);
    
  }

  void grid() {
  }

  @Override
    void handleAction(ActionResult result) {

    switch (result.action) {
    case init_terrain:
      init_terrain();
      return;
    case generate_terrain:
    isTopOpened = true;
    for(int k = 0; k < blocks.size(); k++){
      for(block b : blocks.get(k)){
        b.y -= 32;
      }
    }
      generate_terrain();
      return;
    case racket_left:
      generate_terrain();
      return;
    case ball_shoot:
      if (!isShooted) ball_shoot();
      return;
    case ball_back:
      isShooted = false;
      return;
    case test:
      ball.x = p.mouseX;
      ball.y = p.mouseY;
      return;
    case test2:
      dirt += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 0.5 + random(-16, 16), 120 + 50 * -1 + random(-16, 16) + 20));
      return;
    case test3:
      stone += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 0 + random(-16, 16), 120 + 50 * 0 + random(-16, 16) + 20));
      return;
    case test4:
      iron += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 0 + random(-16, 16), 120 + 50 * 1 + random(-16, 16) + 20));
      return;
    case test5:
      gold += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 0 + random(-16, 16), 120 + 50 * 2 + random(-16, 16) + 20));
      return;
    case test6:
      topaz += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 1 + random(-16, 16), 120 + 50 * 0 + random(-16, 16) + 20));
      return;
    case test7:
      amethyst += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 1 + random(-16, 16), 120 + 50 * 1 + random(-16, 16) + 20));
      return;
    case test8:
      sapphire += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 1 + random(-16, 16), 120 + 50 * 2 + random(-16, 16) + 20));
      return;
    case test9:
      emerald += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 2 + random(-16, 16), 120 + 50 * 0 + random(-16, 16) + 20));
      return;
    case test10:
      ruby += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 2 + random(-16, 16), 120 + 50 * 1 + random(-16, 16) + 20));
      return;
    case test11:
      diamond += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 2 + random(-16, 16), 120 + 50 * 2 + random(-16, 16) + 20));
      return;
    case test12:
      dirt += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 0.5 + random(-16, 16), 120 + 50 * -1 + random(-16, 16) + 20));
      stone += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 0 + random(-16, 16), 120 + 50 * 0 + random(-16, 16) + 20));
      iron += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 0 + random(-16, 16), 120 + 50 * 1 + random(-16, 16) + 20));
      gold += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 0 + random(-16, 16), 120 + 50 * 2 + random(-16, 16) + 20));
      topaz += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 1 + random(-16, 16), 120 + 50 * 0 + random(-16, 16) + 20));
      amethyst += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 1 + random(-16, 16), 120 + 50 * 1 + random(-16, 16) + 20));
      sapphire += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 1 + random(-16, 16), 120 + 50 * 2 + random(-16, 16) + 20));
      emerald += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 2 + random(-16, 16), 120 + 50 * 0 + random(-16, 16) + 20));
      ruby += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 2 + random(-16, 16), 120 + 50 * 1 + random(-16, 16) + 20));
      diamond += 50;
      floatText.add(new FloatingText("+50", 986 + 96 * 2 + random(-16, 16), 120 + 50 * 2 + random(-16, 16) + 20));
      return;
    case test13:
      for (int i = 0; i < 50; i++) {
        isTopOpened = true;
        generate_terrain();
      }
      return;
    default:
      super.handleAction(result);
    }
  }
  
  ArrayList<block[]> getBlock(){
    return this.blocks;
  }


  void keyHolding() {


    if (keyState.getOrDefault("SHIFT", false)) {

      ballDirection.init();
      if (keyState.getOrDefault("LEFT", false)) angle++;
      if (keyState.getOrDefault("RIGHT", false)) angle--;
      angle = constrain(angle %= 360, 22.5, 180 -22.5);

      return;
    }

    if (keyState.getOrDefault("LEFT", false)) racket.x -= 3;
    if (keyState.getOrDefault("RIGHT", false)) racket.x += 3;
    if (keyState.getOrDefault("UP", false)) racket.y -= 3;
    if (keyState.getOrDefault("DOWN", false)) racket.y += 3;
  }

  void init_terrain() {

    println("地形を再生成..");
    depth = 0;
    blocks.clear();
    //ArrayList<block>[] blocks;
    for (generateDepth = 0; generateDepth < 32; generateDepth++) {
      // (1 + Int(depth / 5)) * (1 + depth / 100)
      block[] line = new block[16];
      for (int i = -8; i < 8; i++) {
        if (generateDepth == 0) {
          line[i+8] = setBlock(y0, i+8, generateDepth*32);
        } else if (generateDepth < 4) {
          line[i+8] = setBlock(y1, i+8, generateDepth*32);
        } else if (generateDepth < 6) {
          line[i+8] = setBlock(y4, i+8, generateDepth*32);
        } else if (generateDepth < 16) {
          line[i+8] = setBlock(y6, i+8, generateDepth*32);
        } else if (generateDepth < 24) {
          line[i+8] = setBlock(y16, i+8, generateDepth*32);
        } else if (generateDepth < 32) {
          line[i+8] = setBlock(y24, i+8, generateDepth*32);
        } else if (generateDepth < 64) {
          line[i+8] = setBlock(y32, i+8, generateDepth*32);
        }
      }
      blocks.add(line);
    }
  }

  float setDurabityByBlockType(String type, int y) {

    float typeDurabity = 1;
    switch (type) {
    case "grass":
    case "dirt":
      typeDurabity = 1;
      break;
    case "stone":
      typeDurabity = 2;
      break;
    case "iron":
      typeDurabity = 10;
      break;
    case "gold":
      typeDurabity = 15;
      break;
    case "topaz":
      typeDurabity = 50;
      break;
    case "amethyst":
      typeDurabity = 70;
      break;
    case "sapphire":
      typeDurabity = 90;
      break;
    case "emerald":
      typeDurabity = 110;
      break;
    case "ruby":
      typeDurabity = 130;
      break;
    case "diamond":
      typeDurabity = 170;
      break;
    case "deepslate":
      typeDurabity = 30;
      break;
    } 
    return (typeDurabity + int(y / 5.0)) * (1.0 + y / 100.0);
  }


  block setBlock(terrainData random, float x, float y) {

    String type = randomBlockType(random.items);
    float durabity = setDurabityByBlockType(type, generateDepth);
    return new block(type, 640.0 + (x-8)*32, 200.0 + y, durabity, x, y/32, this);
    
  }

  void generate_terrain() {

    if (!isTopOpened) {
      return;
    }
    isTopOpened = false;
    topline = constrain(++topline, 0, 7);
    depth++;
    println();
    generateDepth = depth + 32;
    block[] line = new block[16];
    float enerateY = (blocks.get(blocks.size() - 1)[0].y+32);
    float generateY = blocks.get(blocks.size() - 1)[0].y-200+32;
    println(enerateY);
    int k = blocks.size();
    for (int i = -8; i < 8; i++) {
      if (generateDepth == 0) {
        line[i+8] = setBlock(y0, i+8, generateY);
      } else if (generateDepth < 4) {
        line[i+8] = setBlock(y1, i+8, generateY);
      } else if (generateDepth < 6) {
        line[i+8] = setBlock(y4, i+8, generateY);
      } else if (generateDepth < 16) {
        line[i+8] = setBlock(y6, i+8, generateY);
      } else if (generateDepth < 24) {
        line[i+8] = setBlock(y16, i+8, generateY);
      } else if (generateDepth < 32) {
        line[i+8] = setBlock(y24, i+8, generateY);
      } else if (generateDepth < 50) {
        line[i+8] = setBlock(y32, i+8, generateY);
      } else if (generateDepth < 100) {
        line[i+8] = setBlock(y50, i+8, generateY);
      } else if (generateDepth < 150) {
        line[i+8] = setBlock(y100, i+8, generateY);
      } else if (generateDepth < 200) {
        line[i+8] = setBlock(y150, i+8, generateY);
      } else if (generateDepth < 250) {
        line[i+8] = setBlock(y200, i+8, generateY);
      } else if (generateDepth < 300) {
        line[i+8] = setBlock(y250, i+8, generateY);
      } else if (generateDepth < 350) {
        line[i+8] = setBlock(y300, i+8, generateY);
      } else if (generateDepth < 400) {
        line[i+8] = setBlock(y350, i+8, generateY);
      } else if (generateDepth < 500) {
        line[i+8] = setBlock(y400, i+8, generateY);
      } else {
        line[i+8] = setBlock(y500, i+8, generateY);
      }
    }
    blocks.add(line);

    for (int i = 0; i < blocks.size(); i++) {
      for (block b : blocks.get(i)) {
        //b.y -= 32;
      }
    }

    if (ball.y > 200) //ball.pos.y -= 64;
    if (blocks.get(0)[0].y < -32) blocks.remove(0);
  }

  void ball_shoot() {
    
    //SE.get("shoot").play();
    isShooted = true;
    ball.shoot((angle/360) * (2*PI));
  }

  void gui() {

    for (block a : gui) {
      a.draw();
    }
    textAlign(LEFT);
    textSize(12);

    text(int(dirt), 986 + 96 * 0.5, 120 + 48  * -1);

    text(int(stone), 986 + 96 * 0, 120 + 48  * 0);
    text(int(iron), 986 + 96 * 0, 120 + 48  * 1);
    text(int(gold), 986 + 96 * 0, 120 + 48  * 2);

    text(int(topaz), 986 + 96 * 1, 120 + 48  * 0);
    text(int(amethyst), 986 + 96 * 1, 120 + 48  * 1);
    text(int(sapphire), 986 + 96 * 1, 120 + 48  * 2);

    text(int(emerald), 986 + 96 * 2, 120 + 48  * 0);
    text(int(ruby), 986 + 96 * 2, 120 + 48  * 1);
    text(int(diamond), 986 + 96 * 2, 120 + 48  * 2);
    if (floatText.size() > 0) {
      for (int i = floatText.size() - 1; i >= 0; i--) {
        floatText.get(i).main();
        if (!floatText.get(i).isAlive) floatText.remove(i);
      }
    }

    fill(255);
    textSize(20);
    textAlign(LEFT);
    noStroke();
    text("深さ: " + depth + "m", 100, 50);

    int textX = 50;
    fill(0);
    stroke(255);
    rect(textX - 10, 340, 300, 340);
    fill(255);
    textAlign(LEFT, TOP);
    text("採掘力: " + nf(ball.strength * ball.strength_magnification, 1, 2), textX, 350);
    text("基礎力: " + nf(ball.strength, 1, 2), textX, 380);
    text("力倍率: ×" + nf(ball.strength_magnification, 1, 2), textX, 410);
    text("サイズ: " + nf(ball.size * ball.size_magnification, 1, 2), textX, 440);
    text("すべての採掘量 +" + nf(ball.ex_all, 1, 1), textX, 470);
    text("鉱石採掘量 +" + nf(ball.ex_ore, 1, 1), textX, 500);
    text("宝石採掘量 +" + nf(ball.ex_jewel, 1, 1), textX, 530);
    text("一撃確立: " + nf(ball.onePunch, 1, 1) + "%", textX, 560);
  
    for (button b : button){
      b.main();
      
      if (!b.run) continue;
      switch (b.Tag){
        case "shop":
          Screens[screen_mode].handleAction(new ActionResult(Actions.ChangeScreen, 4));          
          break;
        case "bag":
          Screens[screen_mode].handleAction(new ActionResult(Actions.ChangeScreen, 3));          
          break;
        case "home":
          init_terrain();          
          break;
      
      }
    }
}

  void breakBlock(String type) {
    int offset = 20;
    switch (type) {
    case "grass":
    case "dirt":
      dirt += 1 + ball.ex_all;
      floatText.add(new FloatingText("+" + str(int(1 + ball.ex_all)), 986 + 96 * 0.5 + random(-16, 16), 120 + 50 * -1 + random(-16, 16) + offset));
      break;
    case "stone":
      stone += 1 + ball.ex_all;
      floatText.add(new FloatingText("+" + str(int(1 + ball.ex_all)), 986 + 96 * 0 + random(-16, 16), 120 + 48 * 0 + random(-16, 16) + offset));
      break;
    case "iron":
      iron += 1 + ball.ex_ore + ball.ex_all;
      floatText.add(new FloatingText("+" + str(int(1 + ball.ex_ore + ball.ex_all)), 986 + 96 * 0 + random(-16, 16), 120 + 48 * 1 + random(16, 20) + offset));
      break;
    case "gold":
      gold += 1 + ball.ex_ore + ball.ex_all;
      floatText.add(new FloatingText("+" + str(int(1 + ball.ex_ore + ball.ex_all)), 986 + 96 * 0 + random(-16, 16), 120 + 48 * 2 + random(-16, 16) + offset));
      break;
    case "topaz":
      topaz += 1 + ball.ex_jewel + ball.ex_all;
      floatText.add(new FloatingText("+" + str(int(1 + ball.ex_jewel + ball.ex_all)), 986 + 96 * 1 + random(-16, 16), 120 + 48 * 0 + random(-16, 16) + offset));
      break;
    case "amethyst":
      amethyst += 1 + ball.ex_jewel + ball.ex_all;
      floatText.add(new FloatingText("+" + str(int(1 + ball.ex_jewel + ball.ex_all)), 986 + 96 * 1 + random(-16, 16), 120 + 48 * 1 + random(-16, 16) + offset));
      break;
    case "sapphire":
      sapphire += 1 + ball.ex_jewel + ball.ex_all;
      floatText.add(new FloatingText("+" + str(int(1 + ball.ex_jewel + ball.ex_all)), 986 + 96 * 1 + random(-16, 16), 120 + 48 * 2 + random(-16, 16) + offset));
      break;
    case "emerald":
      emerald += 1 + ball.ex_jewel + ball.ex_all;
      floatText.add(new FloatingText("+" + str(int(1 + ball.ex_jewel + ball.ex_all)), 986 + 96 * 2 + random(-16, 16), 120 + 48 * 0 + random(-16, 16) + offset));
      break;
    case "ruby":
      ruby += 1 + ball.ex_jewel + ball.ex_all;
      floatText.add(new FloatingText("+" + str(int(1 + ball.ex_jewel + ball.ex_all)), 986 + 96 * 2 + random(-16, 16), 120 + 48  * 1 + random(-16, 16) + offset));
      break;
    case "diamond":
      diamond += 1 + ball.ex_jewel + ball.ex_all;
      floatText.add(new FloatingText("+" + str(int(1 + ball.ex_jewel + ball.ex_all)), 986 + 96 * 2 + random(-16, 16), 120 + 48  * 2 + random(-16, 16) + offset));
      break;
    }
  }

  class racket {

    float x, y, w, h;
    int delay;
    PVector pos = new PVector(0, 0);

    ArrayList<PVector> pos_history = new ArrayList<PVector>();

    racket(float x, float y, float w, float h, int delay) {
      this.x = x;
      this.y = y;
      pos.set(x, y);
      this.w = w;
      this.h = h;
      this.delay = delay;
    }

    void main() {
      this.draw();
      this.update();
    }

    void draw() {

      fill(255);
      rect(x - w/2, y - h/2, w, h);
    }

    void update() {

      hit();
      pos.x = this.x;
      pos.y = this.y;
      pos_history.add(0, new PVector(pos.x, pos.y)); // ラケット座標の履歴に関するArrayList
      if (pos_history.size() > 100) pos_history.remove(100);

      if (pos_history.size() < 2) return;
      if (!pos_history.get(0).equals(pos_history.get(1))) setRange();
    }

    void hit() {

      if (isOverlap(this.x - this.w/2, this.y - this.h/2, this.w, this.h, ball.pos.x, ball.pos.y + ball.vec.y, ball.size, ball.size)) {
        SE.get("racket").rate(random(0.5, 1.5));
        SE.get("racket").play();
        ball.vec.y = abs(ball.vec.y);
      }
    }

    void setRange() {

      if (racket.x - racket.w /2 < 640.0 - 8*32) racket.x = 640.0 - 8*32 + racket.w/2;
      if (racket.x + racket.w /2 > 640.0 + 8*32) racket.x = 640.0 + 8*32 - racket.w/2;
      if (racket.y + racket.h /2 > 160) racket.y = 160.0 - racket.h/2;
      if (racket.y - racket.h /2 < 20) racket.y = 20.0 + racket.h/2;

      pos_history.set(0, new PVector(racket.x, racket.y)); // ラケット座標の履歴に関するArrayList
    }
  }



  @Override
    void mouseMoved() {
  }

  @Override
    void mouseDragged() {
  }

  @Override
    void close() {
  }
}
