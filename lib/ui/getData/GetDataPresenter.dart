import 'package:boha/ui/getData/GetDataView.dart';

class GetDataPresenter{
}

class BasicGetDataPresenter implements GetDataPresenter{
  GetDataView _splashView;

  BasicGetDataPresenter(this._splashView) {
  }

  @override
  set splashView(GetDataView value) {
    _splashView = value;
  }

}