import 'package:hacker_news/core/domain/services/app_info_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoServiceImpl implements AppInfoService {
  PackageInfo? _packageInfo;

  @override
  Future<String> getAppVersion() async {
    final packageInfo = await _getPackageInfo();
    return packageInfo.version;
  }

  Future<PackageInfo> _getPackageInfo() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!;
  }
}
