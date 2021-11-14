import 'package:getx_state_management/models/data_model/user.dart';
import 'package:get/state_manager.dart';

class UserController extends GetxController {
  final user = User().obs;

  updateName(String name, int age, bool alive) {
    user.update((value) {
      value!.name = name;
      value.age = age;
      value.alive = alive;
    });

    user.value.name = name;
    user.value.age = age;
    user.value.alive = alive;
  }
}
