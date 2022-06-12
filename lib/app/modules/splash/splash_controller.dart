import 'package:get/get.dart';
import 'package:verydeli_commerce/app/data/enums/user_logged.dart';
import 'package:verydeli_commerce/app/routes/pages.dart';

class SplashController extends GetxController {
  final _logged = UserLogged.empty.obs;

  UserLogged get logged => _logged.value;

  @override
  void onReady() {
    ever<UserLogged>(_logged, _checkIsLogged);
    _checkLogin();
    super.onReady();
  }

  void _checkLogin() {
    _logged(UserLogged.unauthenticate);
    // TODO: Verificar se o usuario está logado
    // _logged(UserLogged.authenticate);
  }

  _checkIsLogged(UserLogged userLogged) {
    switch (userLogged) {
      case UserLogged.authenticate:
        Get.offAllNamed(Routes.HOME);
        break;
      case UserLogged.unauthenticate:
        Get.offAllNamed(Routes.LOGIN);
        break;
      case UserLogged.empty:
        break;
    }
  }
}
