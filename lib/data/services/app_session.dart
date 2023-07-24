import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

PackageInfo? appPackageInfo;

Future<void> setupSession() async {
  appPackageInfo = await PackageInfo.fromPlatform();

  await _initStorages();
}

Future<void> _initStorages() async {
  await Hive.initFlutter();
  await Hive.openBox('favorites');
}
