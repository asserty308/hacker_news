import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService {
  PackageInfo? _packageInfo;

  Future<String> getAppVersion() async {
    final packageInfo = await _getPackageInfo();
    return packageInfo.version;
  }

  Future<PackageInfo> _getPackageInfo() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!;
  }
}
