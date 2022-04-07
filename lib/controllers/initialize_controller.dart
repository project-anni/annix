import 'package:get/get.dart';

class InitializeController extends GetxController {
  Rx<bool> done = false.obs;

  InitializeController(List<Future> futures) {
    (() async {
      try {
        await Future.wait(futures);
      } finally {
        done.value = true;
      }
    })();
  }
}
