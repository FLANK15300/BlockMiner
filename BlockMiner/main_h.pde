void init() { //<>// //<>// //<>//

  // フォントの設定
  F_pixel = createFont("font/PixelMplus10-Regular.ttf", 1);
  Default = createFont("Meiryo", 18);
  textFont(F_pixel);


  // 画像の読み込み
  checkTexture();

  screen_mode = 0; // タイトル画面
  screen_mode = 2; // メインゲーム画面






  //スクリーンの宣言  //<>// //<>//
  Screeninit();
  
}



void checkTexture() {

  new ImageData("texture/blocks/grass.png");
  new ImageData("texture/blocks/dirt.png");
  new ImageData("texture/blocks/stone.png");
  new ImageData("texture/blocks/cobblestone.png");
  new ImageData("texture/blocks/iron.png");
  new ImageData("texture/blocks/gold.png");
  new ImageData("texture/blocks/topaz.png");
  new ImageData("texture/blocks/amethyst.png");
  new ImageData("texture/blocks/sapphire.png");
  new ImageData("texture/blocks/emerald.png");
  new ImageData("texture/blocks/ruby.png");
  new ImageData("texture/blocks/diamond.png");
  new ImageData("texture/blocks/bedrock.png");
}


///// データクラス





// 地形生成の鉱石の分布に関するデータ
// 比率で求める
class terrainData {

  weightedItem[] items = new weightedItem[13];

  terrainData(weightedItem... itemData) {

    for (int i = 0; i < 13; i++) { // ハードコーディングだけど許せ！（だってブロック追加する予定ないんだもん）
      if (i >= itemData.length) {
        items[i] = new weightedItem("bedrock", 0);
        continue;
      }
      items[i] = itemData[i];
    }
  }
}



// キー入力の結果を格納するクラス
static class ActionResult {
  Actions action; // どのアクションか
  int targetScreenId; // CHANGE_SCREENの場合の遷移先ID

  // コンストラクタ (アクションのみ指定)
  ActionResult(Actions action) {
    this.action = action;
    this.targetScreenId = -1; // 画面遷移ではないので-1
  }

  // コンストラクタ (アクションと遷移先IDを指定)
  ActionResult(Actions action, int targetScreenId) {
    this.action = action;
    this.targetScreenId = targetScreenId;
  }
}

// その他未分類関数
String CODEDtoString() { // keyCodeをStringで返すことでマジックナンバーを使わずに、可読性を上げる(keyCodeわかりにくすぎんねんな)

  switch (keyCode) {
  case UP:
    return "UP";
  case LEFT:
    return "LEFT";
  case RIGHT:
    return "RIGHT";
  case DOWN:
    return "DOWN";
  case ENTER:
    return "ENTER";
  case SHIFT:
    return "SHIFT";
  case CONTROL:
    return "CTRL";
  case ALT:
    return "ALT";
  }
  return null; // どれにも該当しない場合、nullを返す(これがないとエラーは吐かれるのうざい)
}

// テキスト演出クラス

class FloatingText {

  PVector pos;
  String message;

  float alpha = 255;
  float speed = 1.0;

  long startTime;
  long duration = 1500;
  color textColor = color(255);
  boolean isAlive = true;

  FloatingText(String message, float x, float y) {
    this.message = message;
    this.pos = new PVector(x, y);
    this.startTime = millis(); // 生成された瞬間の時刻を記録
  }
  
  FloatingText(String message, float x, float y, color textColor) {
    this.message = message;
    this.pos = new PVector(x, y);
    this.startTime = millis(); // 生成された瞬間の時刻を記録
    this.textColor = textColor;
  }
  
  void main(){
    this.update();
    this.draw();
  }
  
  
  void update() {
    speed *= map(alpha, 255, 0, 1.0, 0.1);
    pos.y -= speed;

    long elapsedTime = millis() - startTime;
    // map関数で経過時間のプログレスを0～255に変換
    alpha = map(elapsedTime, 0, duration, 255, 0);

    if (elapsedTime > duration) {
      isAlive = false;
    }
  }

  void draw() {
//    textAlign(CENTER);
//    textSize(18);    
//    fill(0, 0, 0, alpha);
//    for(int x = -1; x < 2; x++){
//      text(message, pos.x + x, pos.y);
//      text(message, pos.x, pos.y + x);
//    }
    fill(textColor, alpha);
    textAlign(CENTER);
    textSize(18);

    text(message, pos.x, pos.y);
    strokeWeight(1);
  }
}






class arrow {

  float startX, startY, targetX, targetY, length, angle, alpha;

  arrow(float x, float y, float length, float angle) {

    this.startX = x;
    this.startY = y;
    this.length = length;
    this.angle = angle;
  }

  void main(float x, float y, float angle) {

    this.startX = x;
    this.startY = y;
    this.angle = angle;
    this.draw();
    this.alpha = (this.alpha > 0) ? --alpha : 0;
  }

  void main() {

    this.draw();
    this.alpha = (this.alpha > 0) ? --alpha : 0;
  }

  void draw() {

    stroke(0);
    strokeWeight(3);
    stroke(0, 0, 0, alpha);
    line(this.startX, this.startY, this.startX + this.length * cos(this.angle), this.startY + this.length * sin(this.angle));
    line(this.startX + this.length * cos(this.angle), this.startY + this.length * sin(this.angle),
      this.startX + this.length * cos(this.angle) + this.length * 0.4 * cos(this.angle + PI + PI/4), this.startY + this.length * sin(this.angle) + this.length * 0.4 * sin(this.angle + PI + PI/4));
    line(this.startX + this.length * cos(this.angle), this.startY + this.length * sin(this.angle),
      this.startX + this.length * cos(this.angle) + this.length * 0.4 * cos(this.angle + PI - PI/4), this.startY + this.length * sin(this.angle) + this.length * 0.4 * sin(this.angle + PI - PI/4));
    strokeWeight(1);
    stroke(255, alpha);
    line(this.startX, this.startY, this.startX + this.length * cos(this.angle), this.startY + this.length * sin(this.angle));
    line(this.startX + this.length * cos(this.angle), this.startY + this.length * sin(this.angle),
      this.startX + this.length * cos(this.angle) + this.length * 0.4 * cos(this.angle + PI + PI/4), this.startY + this.length * sin(this.angle) + this.length * 0.4 * sin(this.angle + PI + PI/4));
    line(this.startX + this.length * cos(this.angle), this.startY + this.length * sin(this.angle),
      this.startX + this.length * cos(this.angle) + this.length * 0.4 * cos(this.angle + PI - PI/4), this.startY + this.length * sin(this.angle) + this.length * 0.4 * sin(this.angle + PI - PI/4));
  }

  void init() {

    this.alpha = 255;
  }
}
