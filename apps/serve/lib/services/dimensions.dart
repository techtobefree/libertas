class Percentages {
  static const double appBarHeight = 56 / 760;
  static const double largeAppBarHeight = 192 / 760;
  static const double padding = 16 / 760;
}

class Dimensions {
  double width;
  double height;
  double statusBarHeight;
  double visibleHeight;
  double padding;
  double appBarHeight;
  double largeAppBarHeight;

  Dimensions._internal({
    required this.width,
    required this.height,
    required this.statusBarHeight,
    required this.visibleHeight,
    required this.padding,
    required this.appBarHeight,
    required this.largeAppBarHeight,
  });

  static Dimensions? _instance;

  factory Dimensions.init({
    required double height,
    required double width,
    required double statusBarHeight,
  }) {
    _instance ??= Dimensions._internal(
      width: width,
      height: height,
      statusBarHeight: statusBarHeight,
      visibleHeight: height - statusBarHeight,
      padding: height * Percentages.padding,
      appBarHeight: height * Percentages.appBarHeight,
      largeAppBarHeight: height * Percentages.largeAppBarHeight,
    );
    return _instance!;
  }

  static Dimensions get instance {
    if (_instance == null) {
      throw Exception('Dimensions must be initialized first');
    }
    return _instance!;
  }

  void resize({
    required double height,
    required double width,
    required double statusBarHeight,
  }) {
    width = width;
    height = height;
    statusBarHeight = statusBarHeight;
    visibleHeight = height - statusBarHeight;
    padding = height * Percentages.padding;
    appBarHeight = height * Percentages.appBarHeight;
    largeAppBarHeight = height * Percentages.largeAppBarHeight;
  }
}

Dimensions get dimensions => Dimensions.instance;
