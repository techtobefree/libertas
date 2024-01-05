import 'dart:io';
import 'package:flutter/foundation.dart';

bool isWeb() => kIsWeb;
bool isAndroid() => kIsWeb ? false : (Platform.isAndroid ? true : false);
bool isIOS() => kIsWeb ? false : (Platform.isIOS ? true : false);
