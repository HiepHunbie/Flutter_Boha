import 'package:boha/ui/splash/SplashView.dart';

class SplashPresenter{
}

class BasicSplashPresenter implements SplashPresenter{
  SplashView _splashView;

  BasicSplashPresenter(this._splashView) {
  }

  @override
  set splashView(SplashView value) {
    _splashView = value;
  }

}