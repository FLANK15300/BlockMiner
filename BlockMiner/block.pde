static class block {

  float x, y, durabity, max_durabity;
  int[] blockPos = new int[2];
  String type;
  boolean isHited = false;
  PVector absPos = new PVector();
  block me;
  static IntDict blockTypes = new IntDict();
  static ArrayList<ImageData> img = new ArrayList<ImageData>();
  static HashMap<String, SoundFile> SE = new HashMap<String, SoundFile>();
  final static float blockSize = 32;
  SoundFile test = new SoundFile(p, "data/sound/blocks/dirt.wav");
  static ImageData[] crack = new ImageData[4];
  main_game game; // Screen型のScreenの要素をmain_game型にキャストすることで、main_gameのメンバー変数を取得する

  static {


    blockTypes.set("grass", 0);
    blockTypes.set("dirt", 1);
    blockTypes.set("stone", 2);
    blockTypes.set("cobblestone", 3);
    blockTypes.set("iron", 4);
    blockTypes.set("gold", 5);

    blockTypes.set("topaz", 6);
    blockTypes.set("amethyst", 7);
    blockTypes.set("sapphire", 8);
    blockTypes.set("emerald", 9);
    blockTypes.set("ruby", 10);
    blockTypes.set("diamond", 11);
    blockTypes.set("bedrock", 12);

    img.add(new ImageData("texture/blocks/grass.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/dirt.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/stone.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/cobblestone.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/iron.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/gold.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/topaz.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/amethyst2.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/sapphire2.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/emerald2.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/ruby2.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/diamond2.png", blockSize, blockSize));
    img.add(new ImageData("texture/blocks/bedrock.png", blockSize, blockSize));
    crack[0] = (new ImageData("texture/misc/crack/1.png", blockSize, blockSize));
    crack[1] = (new ImageData("texture/misc/crack/2.png", blockSize, blockSize));
    crack[2] =(new ImageData("texture/misc/crack/3.png", blockSize, blockSize));
    crack[3] = (new ImageData("texture/misc/crack/4.png", blockSize, blockSize));

    SE.put("dirt", new SoundFile(p, "sound/blocks/dirt.wav"));
    SE.put("stone_hit1", new SoundFile(p, "sound/blocks/stone_hit1.ogg"));
    SE.put("stone_hit2", new SoundFile(p, "sound/blocks/stone_hit2.ogg"));
    SE.put("stone_dig", new SoundFile(p, "sound/blocks/stone_dig.ogg"));

    SE.put("stone_hit1", new SoundFile(p, "sound/blocks/stone_hit1.ogg"));
    SE.put("stone_hit2", new SoundFile(p, "sound/blocks/stone_hit2.ogg"));
    SE.put("stone_dig", new SoundFile(p, "sound/blocks/stone_dig.ogg"));
  
    SE.put("iron_hit1", new SoundFile(p, "sound/blocks/stone_hit1.ogg"));
    SE.put("iron_hit2", new SoundFile(p, "sound/blocks/stone_hit2.ogg"));
    SE.put("iron_dig", new SoundFile(p, "sound/blocks/stone_dig.ogg"));
  
    SE.put("gold_hit1", new SoundFile(p, "sound/blocks/stone_hit1.ogg"));
    SE.put("gold_hit2", new SoundFile(p, "sound/blocks/stone_hit2.ogg"));
    SE.put("gold_dig", new SoundFile(p, "sound/blocks/stone_dig.ogg"));
  
    SE.put("topaz_hit1", new SoundFile(p, "sound/blocks/stone_hit1.ogg"));
    SE.put("topaz_hit2", new SoundFile(p, "sound/blocks/stone_hit2.ogg"));
    SE.put("topaz_dig", new SoundFile(p, "sound/blocks/stone_dig.ogg"));

    SE.put("amethyst_hit1", new SoundFile(p, "sound/blocks/stone_hit1.ogg"));
    SE.put("amethyst_hit2", new SoundFile(p, "sound/blocks/stone_hit2.ogg"));
    SE.put("amethyst_dig", new SoundFile(p, "sound/blocks/stone_dig.ogg"));

    SE.put("sapphire_hit1", new SoundFile(p, "sound/blocks/stone_hit1.ogg"));
    SE.put("sapphire_hit2", new SoundFile(p, "sound/blocks/stone_hit2.ogg"));
    SE.put("sapphire_dig", new SoundFile(p, "sound/blocks/stone_dig.ogg"));

    SE.put("emerald_hit1", new SoundFile(p, "sound/blocks/stone_hit1.ogg"));
    SE.put("emerald_hit2", new SoundFile(p, "sound/blocks/stone_hit2.ogg"));
    SE.put("emerald_dig", new SoundFile(p, "sound/blocks/stone_dig.ogg"));

    SE.put("ruby_hit1", new SoundFile(p, "sound/blocks/stone_hit1.ogg"));
    SE.put("ruby_hit2", new SoundFile(p, "sound/blocks/stone_hit2.ogg"));
    SE.put("ruby_dig", new SoundFile(p, "sound/blocks/stone_dig.ogg"));

    SE.put("diamond_hit1", new SoundFile(p, "sound/blocks/stone_hit1.ogg"));
    SE.put("diamond_hit2", new SoundFile(p, "sound/blocks/stone_hit2.ogg"));
    SE.put("diamond_dig", new SoundFile(p, "sound/blocks/stone_dig.ogg"));
  }


  block(String type, float x, float y, float durabity, float blockPosx, float blockPosy, main_game game) {
    this.type = type;
    this.x = x;
    this.y = y;
    this.max_durabity = durabity;
    this.durabity = durabity;
    this.blockPos[0] = int(blockPosx);
    this.blockPos[1] = int(blockPosy);

    this.game = game;
  }


  void draw() {
    update();
    if (this.type == "air" || this.durabity <= 0) return;
    img.get(blockTypes.get(type)).draw(x, y);
    float durabity_rate = 1.0 - (this.durabity / this.max_durabity);
    if (durabity_rate < 1.0/5.0) {
    } else if (durabity_rate < 2.0/5.0) {
      crack[0].draw(x, y);
    } else if (durabity_rate < 3.0/5.0) {
      crack[1].draw(x, y);
    } else if (durabity_rate < 4.0/5.0) {
      crack[2].draw(x, y);
    } else if (durabity_rate < 5.0/5.0) {
      crack[3].draw(x, y);
    }
  }

  void update() {
    absPos = new PVector(int((this.x - 385) / blockSize), int((this.y - 200)/blockSize));
  }


  String hit(ball b, int arrayX, int arrayY) {
    float moment = game.ball.vec.y/4;
    float caledStrength = abs(game.ball.strength * game.ball.strength_magnification * moment);
    if (blockHitCheck(this.x, this.y, blockSize, blockSize, b.pos.x, b.pos.y, b.size, b.size, b.vec.x, b.vec.y) == 0 || this.durabity <= 0 || this.y < 200) return "";
    lastHit = this;
    lastHit_array[0] = arrayX;
    lastHit_array[1] = arrayY;
    SoundFile temp;
    switch (this.type) {
    case "dirt":
      SE.get("dirt").rate(p.random(0.5, 1.5));
      SE.get("dirt").play();
      break;
    case "stone":
      temp = SE.get("stone_hit" + str(int(p.random(1, 3))));
      temp.rate(p.random(0.75, 1.25));
      temp.play();
      break;
    case "iron":
      temp = SE.get("iron_hit" + str(int(p.random(1, 3))));
      temp.rate(p.random(0.75, 1.25));
      temp.play();
      break;
    case "gold":
      temp = SE.get("gold_hit" + str(int(p.random(1, 3))));
      temp.rate(p.random(0.75, 1.25));
      temp.play();
      break;
    case "topaz":
      temp = SE.get("topaz_hit" + str(int(p.random(1, 3))));
      temp.rate(p.random(0.75, 1.25));
      temp.play();
      break;
    case "amethyst":
      temp = SE.get("amethyst_hit" + str(int(p.random(1, 3))));
      temp.rate(p.random(0.75, 1.25));
      temp.play();
      break;
    case "sapphire":
      temp = SE.get("sapphire_hit" + str(int(p.random(1, 3))));
      temp.rate(p.random(0.75, 1.25));
      temp.play();
      break;
    case "emerald":
      temp = SE.get("emerald_hit" + str(int(p.random(1, 3))));
      temp.rate(p.random(0.75, 1.25));
      temp.play();
      break;
    case "ruby":
      temp = SE.get("ruby_hit" + str(int(p.random(1, 3))));
      temp.rate(p.random(0.75, 1.25));
      temp.play();
      break;
    case "diamond":
      temp = SE.get("diamond_hit" + str(int(p.random(1, 3))));
      temp.rate(p.random(0.75, 1.25));
      temp.play();
      break;
    }

    if (p.random(100) < b.onePunch && !b.onGround) {
      isHited = false;
      println("ワンパン！");
      this.durabity = 0;
      switch (this.type) {
      case "dirt":
        SE.get("dirt").rate(p.random(0.5, 1.5));
        SE.get("dirt").play();
        break;
      case "stone":
        temp = SE.get("stone_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "iron":
        temp = SE.get("iron_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "gold":
        temp = SE.get("gold_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "topaz":
        temp = SE.get("topaz_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "amethyst":
        temp = SE.get("amethyst_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "sapphire":
        temp = SE.get("sapphire_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "emerald":
        temp = SE.get("emerald_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "ruby":
        temp = SE.get("ruby_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "diamond":
        temp = SE.get("diamond_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      }
      return type;
    }

    if (this.durabity - caledStrength < 0) {
      isHited = false;
      b.vec.y *= 0.95;
      this.durabity = 0;
      switch (this.type) {
      case "dirt":
        SE.get("dirt").rate(p.random(0.5, 1.5));
        SE.get("dirt").play();
        break;
      case "stone":
        temp = SE.get("stone_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "iron":
        temp = SE.get("iron_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "gold":
        temp = SE.get("gold_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "topaz":
        temp = SE.get("topaz_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "amethyst":
        temp = SE.get("amethyst_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "sapphire":
        temp = SE.get("sapphire_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "emerald":
        temp = SE.get("emerald_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "ruby":
        temp = SE.get("ruby_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      case "diamond":
        temp = SE.get("diamond_dig");
        temp.rate(p.random(0.75, 1.25));
        temp.play();
        break;
      }
    return type;
    }
    
    
    this.durabity -= caledStrength;
    if (this.durabity > 0) return "";

    return type;
  }
}


  String randomBlockType(weightedItem... item) {

    float sumWeight = 0;

    for (weightedItem i : item) {
      sumWeight += i.weight;
    }

    float r = random(sumWeight);

    sumWeight = 0;
    for (weightedItem i : item) {
      sumWeight += i.weight;
      if (r < sumWeight) {
        return i.name;
      }
    }
    return "bedrock";
  }

  class weightedItem {

    String name;
    float weight;

    weightedItem(String name, float weight) {

      this.name = name;
      this.weight = weight;
    }
  }
