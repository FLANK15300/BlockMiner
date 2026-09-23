// マウス全体の入力情報を管理するクラス
static class Mouse {

  // publicなフィールドとして各ボタンを持つ
  public MouseButton left;
  public MouseButton right;
  public MouseButton center;

  // 座標などの情報
  public float x, y, pre_x, pre_y;
  public boolean moving;
  // public int wheel; // スクロールもここに追加できる

  // コンストラクタ
  Mouse() {
    // 各ボタンを初期化
    this.left = new MouseButton(LEFT);
    this.right = new MouseButton(RIGHT);
    this.center = new MouseButton(CENTER);
  }

  // このメソッドをdraw()の最初に呼ぶだけでOK
  void update(PApplet p) {
    // 座標を更新
    this.pre_x = this.x;
    this.pre_y = this.y;
    this.x = p.mouseX;
    this.y = p.mouseY;

    // movingの判定を修正 (&& -> ||)
    this.moving = (this.x != this.pre_x || this.y != this.pre_y);

    // 各ボタンの状態を更新
    left.update();
    right.update();
    center.update();
  }
}

// シンプルで堅牢なMouseButtonクラス
static class MouseButton {

  // --- ユーザーが使う4つの状態 ---
  public boolean Down;     // 押された「瞬間」だけtrue
  public boolean Pressed;  // 押されている「間ずっと」true
  public boolean Released; // 離された「瞬間」だけtrue
  public boolean Up;       // 離されている「間ずっと」true
  public int holdTime = 0;
  public mstate state;

  enum mstate {

    Down,
    Pressed,
    Up,
    Released
  }

  private int buttonCode;
  private boolean wasPressedLastFrame = false; // 1フレーム前の状態だけ記憶

  MouseButton(int buttonCode) {
    this.buttonCode = buttonCode;
  }

  void update() {
    boolean isPressedThisFrame = p.mousePressed && (p.mouseButton == this.buttonCode);

    this.Pressed = isPressedThisFrame;
    this.Up = !isPressedThisFrame && wasPressedLastFrame;
    this.Down = isPressedThisFrame && !this.wasPressedLastFrame;
    this.Released = !isPressedThisFrame;

    this.wasPressedLastFrame = isPressedThisFrame; // 前フレームの状態

    if (this.Down) {
      this.state = mstate.Down;
    } else if (this.Pressed) {
      this.state = mstate.Pressed;
    } else if (this.Up) {
      this.state = mstate.Up;
    } else if (this.Released) {
      this.state = mstate.Released;
    }
    
    if(this.Pressed) {
      holdTime++;
      return;
    }
    holdTime = 0;
  }
}
