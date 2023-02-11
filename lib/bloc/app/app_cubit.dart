import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppTopStories());

  void showTopStories() => emit(AppTopStories());
  void showFavorites() => emit(AppFavorites());

  /// Shows a browser with the url.
  /// Does not emit a new state as the browser is just an overlay.
  void callUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    }
  }
}
