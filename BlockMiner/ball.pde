static class ball {

  float x, y;
  float strength;
  float ex_ore = 0, ex_jewel = 0, ex_all = 0;
  float size_magnification = 1;
  float strength_magnification = 1;
  float onePunch = 0;
  static float gravity;
  static int blockPos[] = new int[4];
  PVector pos = new PVector(0, 0);   // 位置
  PVector vec;   // 速度
  PVector acceleration; // 加速度
  PVector baseAcceleration; // 初期加速度
  String type;
  static ArrayList<ImageData> img = new ArrayList<ImageData>();
  float dx, dy, speed;
  boolean isShooted = false;
  boolean onGround = false;
  static float defaultSize = 10;
  float size = 10;
  



  ball(String type, float x, float y, float strength) {
    this.type = type;
    this.x = x;
    this.y = y;
    this.strength = strength;
    vec = new PVector(0, 0);
    baseAcceleration = new PVector(0, 0.1);
    this.speed = 2;
    gravity = 1;
  }


  void shoot(float angle){
    acceleration = baseAcceleration.copy();
    this.vec = new PVector(cos(angle), sin(angle)).mult(this.speed);
  }
  
  void main(){
    
    //if (this.pos.y + size < 0) return;
    this.update();
    this.draw();
    
  }
  
  void draw() {
    p.fill(255);
    p.rect(this.pos.x, this.pos.y, size, size);
  
  }
  
  void update(){
    
    //接地判定
    onGround = false;
    main_game s = (Screens[2] instanceof main_game) ? s = (main_game) Screens[2] : null;
    boolean temp = false;
    ArrayList<block[]> _b = s.getBlock();
    for (int k = 0; k < _b.size(); k++) {
      for (block b : _b.get(k)) {
        if (!(b.y <= p.height) || b.durabity <= 0 || b.y < 200) continue;
        if (temp) continue;
           temp = (blockHitCheck(b.x, b.y, block.blockSize, block.blockSize, this.pos.x, this.pos.y + 2, this.size, this.size, this.baseAcceleration.x, 0.1) != 0 && this.vec.y < 1) ? true : false;
      }
    }
    onGround = temp;
    if(!onGround) acceleration = baseAcceleration.copy();
    // 1. 速度に加速度を加える（重力でだんだん速くなる）21
    vec.add(acceleration.mult(gravity));
    vec.y *= 0.99;
    
    
    vec.x *= (onGround) ? 0.95 : 1;
  
    // 2. 位置に速度を加える（現在の速度で移動する）
    PVector div_vec = vec.copy().mult(1.0/10.0);
    for(int i = 0; i < 10; i++){

      pos.add(div_vec);
    }
    this.x = pos.x;
    this.y = pos.y;
    this.dx = vec.x;
    this.dy = vec.y;
    
    blockPos[0] = int((x - 400) / block.blockSize);
    blockPos[1] = int((y - 220) / block.blockSize);
    blockPos[2] = int((x - 400 + dx) / block.blockSize);
    blockPos[3] = int((y - 220 + dy) / block.blockSize);
    
    vec.x = (pos.x < 385 || pos.x + size > 385 + 16 * 32) ? -vec.x : vec.x;
    vec.y = (pos.y + size > p.height) ? -vec.y : vec.y;
    size = defaultSize * size_magnification;
    
    
    
    
  }
}
