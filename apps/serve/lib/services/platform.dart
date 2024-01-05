import 'dart:io';
import 'package:flutter/foundation.dart';

/// we always check web first because Platform is not supported on web and will
/// throw an exception if we try to use it while running on web.
bool isWeb() => kIsWeb;
bool isAndroid() => kIsWeb ? false : (Platform.isAndroid ? true : false);
bool isIOS() => kIsWeb ? false : (Platform.isIOS ? true : false);
