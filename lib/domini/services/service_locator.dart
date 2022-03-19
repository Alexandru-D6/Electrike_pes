import 'package:get_it/get_it.dart';
import 'package:sign_button/constants.dart';

final ServiceLocator = GetIt.instance;

void setUpLocator () {
  ServiceLocator.registerSingleton(ButtonType.google);
}