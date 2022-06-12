import 'package:get/get.dart';
import 'package:verydeli_commerce/app/modules/account/account_bindings.dart';
import 'package:verydeli_commerce/app/modules/account/account_page.dart';
import 'package:verydeli_commerce/app/modules/home/home_bindings.dart';
import 'package:verydeli_commerce/app/modules/home/home_page.dart';
import 'package:verydeli_commerce/app/modules/login/login_bindings.dart';
import 'package:verydeli_commerce/app/modules/login/login_page.dart';
import 'package:verydeli_commerce/app/modules/register/register_bindings.dart';
import 'package:verydeli_commerce/app/modules/register/register_page.dart';
import 'package:verydeli_commerce/app/modules/settings/settings_bindings.dart';
import 'package:verydeli_commerce/app/modules/settings/settings_page.dart';
import 'package:verydeli_commerce/app/modules/splash/splash_bindings.dart';
import 'package:verydeli_commerce/app/modules/splash/splash_page.dart';

part 'routes.dart';

abstract class Pages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => const SplashPage(), binding: SplashBindings()),
    GetPage(name: Routes.LOGIN, page: () => const LoginPage(), binding: LoginBindings()),
    GetPage(name: Routes.REGISTER, page: () => const RegisterPage(), binding: RegisterBindings()),
    GetPage(name: Routes.HOME, page: () => const HomePage(), binding: HomeBindings()),
    GetPage(name: Routes.SETTINGS, page: () => const SettingsPage(), binding: SettingsBindings()),
    GetPage(name: Routes.ACCOUNT, page: () => const AccountPage(), binding: AccountBindings()),
  ];
}
