import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/core/data/services/app_info_service_impl.dart';
import 'package:hacker_news/core/domain/services/app_info_service.dart';

/// Provider for the app info service
final appInfoServiceProvider = Provider<AppInfoService>(
  (ref) => AppInfoServiceImpl(),
);
