import 'dart:io';
import 'package:flutter/foundation.dart';

late String _platform;

void setPlatform() =>
    _platform = kIsWeb ? 'web' : (Platform.isAndroid ? 'android' : 'ios');

String getPlatform() => _platform;

bool isWeb() => _platform == 'web';
bool isAndroid() => _platform == 'android';
bool isIOS() => _platform == 'ios';
