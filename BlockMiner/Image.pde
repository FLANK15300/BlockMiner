static class ImageData {

  String path;
  float scale = 1, w_pixel, h_pixel;
  PImage img;
  boolean isImgLoaded = true;


  // this()で呼び出せるメインのコンストラクタ
  ImageData(String path, float scale, float w_pixel, float h_pixel) {

    this.path = path;
    this.scale = scale;
    this.w_pixel = w_pixel;
    this.h_pixel = h_pixel;

    load();
  }

  ImageData(String path, float scale) {

    this(path, scale, 0, 0);
  }

  ImageData(String path, float w_pixel, float h_pixel) {

    this(path, 0, w_pixel, h_pixel);
  }

  ImageData(String path) {

    this(path, 1, 0, 0);
  }
  void load() {

    img = p.loadImage(path);
    isImgLoaded = img != null;
    if (!isImgLoaded) {
      println(path + "の読み込みに失敗しました。画像ファイルを確認してください");
      errorType = 1;
    } else println(path + "の読み込みに成功しました。");
    img.resize(int(img.width * scale + w_pixel), int(img.height * scale + h_pixel));
  }

  void draw(float x, float y) {

    if (!isImgLoaded || this.img == null) return;

    p.image(img, x, y);
  }
}




void loadingTextureError() {


  screen_mode = 0;
  int x, y, w, h;

  w = 500;
  h = w * 720/1280;
  x = (width-w)/2;
  y = (height-h)/2;

  background(0);
  rect(x, y, w, h);
  textSize(20);
  fill(0);
  text("画像データの読み込みに失敗しました。", x + 10, y + h/2 - 25);
  fill(255);
}
