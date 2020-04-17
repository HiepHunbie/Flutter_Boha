import 'package:boha/ui/info/InfoView.dart';

class InfoPresenter{
}

class BasicInfoPresenter implements InfoPresenter{
  InfoView _splashView;

  BasicInfoPresenter(this._splashView) {
  }

  @override
  set splashView(InfoView value) {
    _splashView = value;
  }

}