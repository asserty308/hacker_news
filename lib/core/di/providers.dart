import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hacker_news/core/ui/navigation/router.dart';
import 'package:hacker_news/core/domain/services/app_info_service.dart';

/// Provider for the app router configuration
final appRouterProvider = Provider((ref) => AppRouter.instance);

/// Provider for the app info service
final appInfoServiceProvider = Provider((ref) => AppInfoService());
