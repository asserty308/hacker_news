import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/core/config/router.dart';
import 'package:hacker_news/core/services/app_info_service.dart';

final appRouterProvider = Provider((ref) => appRouter);

/// Provider for the app info service
final appInfoServiceProvider = Provider((ref) => AppInfoService());
