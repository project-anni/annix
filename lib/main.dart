import 'dart:io';

import 'package:annix/app.dart';
import 'package:annix/i18n/strings.g.dart';
import 'package:annix/providers.dart';
import 'package:annix/services/path.dart';
import 'package:f_logs/f_logs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:simple_audio/simple_audio.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FLog.getDefaultConfigurations().isDevelopmentDebuggingEnabled = true;

  final container = ProviderContainer();
  await PathService.init();
  await Future.wait([
    container.read(proxyProvider).start(),
    container.read(audioServiceProvider.future),
  ]);

  LocaleSettings.useDeviceLocale();

  FlutterError.onError = (final details) {
    FLog.error(
      text: 'Flutter error',
      className: details.library,
      exception: details.exception,
      stacktrace: details.stack,
    );

    FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (final error, final stack) {
    FLog.error(text: 'Root isolate error', exception: error, stacktrace: stack);
    return true;
  };

  await SimpleAudio.init(
    useMediaController: false,
    shouldNormalizeVolume: false,
    dbusName: 'rs.anni.annix',
  );

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    doWhenWindowReady(() {
      const initialSize = Size(1280, 800);
      appWindow.minSize = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }

  try {
    runApp(
      UncontrolledProviderScope(
        container: container,
        child: const AnnixApp(),
      ),
    );
  } catch (e) {
    FLog.error(text: 'Uncaught exception', exception: e);
  }
}
