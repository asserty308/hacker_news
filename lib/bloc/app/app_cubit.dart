import 'package:cubit/cubit.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppTopStories());

  void showTopStories() => emit(AppTopStories());
  void showFavorites() => emit(AppFavorites());

  /// Shows a browser with the url.
  /// Does not emit a new state as the browser is just an overlay.
  void callUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    }
  }
}
