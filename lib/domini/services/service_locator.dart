import 'package:flutter_project/domini/services/google_login_adpt.dart';
import 'package:flutter_project/domini/services/google_maps_adpt.dart';
import 'package:get_it/get_it.dart';

final ServiceLocator = GetIt.instance;

void setUpLocator () {
  ServiceLocator.registerLazySingleton<GoogleMapsAdpt>(() => (GoogleMapsAdpt()));
  ServiceLocator.registerFactory<GoogleLoginAdpt>(() => GoogleLoginAdpt());
}

GoogleMapsAdpt get getMapsService {
  return ServiceLocator<GoogleMapsAdpt>();
}

GoogleLoginAdpt get getLoginService {
  return ServiceLocator<GoogleLoginAdpt>();
}
