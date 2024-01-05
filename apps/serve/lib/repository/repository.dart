import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

/// this layer is the caching layer, but not caching only, it also holds the
/// logic of calling the backend (for images only right now). it is the
/// repository of images and perhaps someday other data as well.

/// a simple singleton to call and get data from the backend or cache
/// does not save to disk, merely in memory.
class Repository {
  final cache = ImageCache();
  final caller = ImageCaller();

  Repository._internal();

  static Repository? _instance;

  factory Repository.init() {
    _instance ??= Repository._internal();
    return _instance!;
  }

  static Repository get instance {
    if (_instance == null) {
      throw Exception('Repository must be initialized first');
    }
    return _instance!;
  }

  /// if this url is in our cache, return it, otherwise call for it and save it to cache
  Future<Uint8List> getImage(String url, {Map<String, String>? headers}) async {
    var img = cache.get(url);
    if (img != null) {
      return img;
    }
    img = await caller.downloadImage(url, headers: headers);
    cache.put(url, img);
    return img;
  }

  Widget image(
    String url, {
    Key? key,
    double scale = 1.0,
    Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,
    Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    FilterQuality filterQuality = FilterQuality.low,
    bool isAntiAlias = false,
    Map<String, String>? headers,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    if (url.isEmpty) {
      return const SizedBox.shrink();
    }
    Image compile(img) => Image.memory(
          img,
          scale: scale,
          frameBuilder: frameBuilder,
          errorBuilder: errorBuilder,
          semanticLabel: semanticLabel,
          excludeFromSemantics: excludeFromSemantics,
          width: width,
          height: height,
          color: color,
          opacity: opacity,
          colorBlendMode: colorBlendMode,
          fit: fit,
          alignment: alignment,
          repeat: repeat,
          centerSlice: centerSlice,
          matchTextDirection: matchTextDirection,
          gaplessPlayback: gaplessPlayback,
          filterQuality: filterQuality,
          isAntiAlias: isAntiAlias,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
        );

    var img = cache.get(url);
    if (img != null) {
      return compile(img);
    }
    return FutureBuilder<Uint8List>(
      future: getImage(url, headers: headers),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return compile(snapshot.data);
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          return loadingBuilder?.call(context, const SizedBox.shrink(), null) ??
              const CircularProgressIndicator();
        }
      },
    );
  }
}

/// a simple cache for images
class ImageCache {
  final Map<String, Uint8List> images = {};
  ImageCache();

  bool containsKey(String key) => images.containsKey(key);

  Uint8List? get(String key) => images[key];
  Uint8List? put(String key, Uint8List bytes) => images[key] = bytes;
}

/// a simple way to call for images
class ImageCaller {
  Future<Uint8List> downloadImage(
    String url, {
    Map<String, String>? headers,
  }) async {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image.');
    }
  }

  /// wouldn't that be nice.
  //Uint8List downloadImageNow(String url) {
  //  return downloadImage(url).then((value) => value);
  //}

  Image network(
    String url, {
    Key? key,
    double scale = 1.0,
    Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,
    Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    FilterQuality filterQuality = FilterQuality.low,
    bool isAntiAlias = false,
    Map<String, String>? headers,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.network(
      url,
      scale: scale,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
      isAntiAlias: isAntiAlias,
      headers: headers,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }
}

Repository get repository => Repository.instance;
Repository get repo => repository;
