import 'package:boha/ui/addBohaer/AddBohaerView.dart';

class AddBohaerPresenter{
}

class BasicAddBohaerPresenter implements AddBohaerPresenter{
  AddBohaerView _splashView;

  BasicAddBohaerPresenter(this._splashView) {
  }

  @override
  set splashView(AddBohaerView value) {
    _splashView = value;
  }

}