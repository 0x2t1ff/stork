import 'dart:async';

import '../../../app/constants/route_names.dart';
import '../../../app/base_viewmodel.dart';
import '../../../app/locator.dart';
import '../../../services/navigation_service.dart';

class StartupViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  void handleStartupLogic() {
    Timer(Duration(seconds: 2), () {
      _navigationService.navigateTo(HomeViewRoute, true);
      notifyListeners();
    });
  }
}
