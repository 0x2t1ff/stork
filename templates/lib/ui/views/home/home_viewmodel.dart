import '../../../app/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
