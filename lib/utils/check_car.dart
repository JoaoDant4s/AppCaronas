import 'package:caronas/models/app_user.dart';

bool checkUserCar(AppUser user) {
  return user.car != null ? true : false;
}
