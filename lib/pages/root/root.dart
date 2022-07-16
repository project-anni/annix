import 'package:annix/controllers/player_controller.dart';
import 'package:annix/i18n/i18n.dart';
import 'package:annix/pages/root/albums.dart';
import 'package:annix/pages/root/home.dart';
import 'package:annix/pages/root/playlists.dart';
import 'package:annix/pages/root/server.dart';
import 'package:annix/pages/root/tags.dart';
import 'package:annix/widgets/bottom_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RootScreenController());
  }
}

class RootScreenController extends GetxController {
  static RootScreenController get to => Get.find();

  var currentIndex = 0.obs;

  final pages = <String>['/home', '/albums', '/playlists', '/server'];

  void changePage(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
      Get.toNamed(pages[index], id: 1);
    }
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/home')
      return GetPageRoute(
        settings: settings,
        page: () => HomeView(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      );

    if (settings.name == '/albums')
      return GetPageRoute(
        settings: settings,
        page: () => AlbumsView(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      );

    if (settings.name == '/tags')
      return GetPageRoute(
        settings: settings,
        page: () => TagsView(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      );

    if (settings.name == '/playlists')
      return GetPageRoute(
        settings: settings,
        page: () => PlaylistsView(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      );

    if (settings.name == '/server')
      return GetPageRoute(
        settings: settings,
        page: () => ServerView(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
      );

    return null;
  }
}

class RootScreen extends GetView<RootScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Navigator(
            key: Get.nestedKey(1),
            initialRoute: '/home',
            onGenerateRoute: controller.onGenerateRoute,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: GetBuilder<PlayerController>(
              builder: (player) =>
                  player.playing != null ? BottomPlayer() : Container(),
            ),
          ),
        ],
      ),
      floatingActionButton: GetBuilder<PlayerController>(builder: (player) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: player.playing != null ? 56.0 : 0.0,
          ),
          child: FloatingActionButton(
            child: Icon(Icons.search),
            onPressed: () {
              Get.toNamed('/search');
            },
            isExtended: true,
          ),
        );
      }),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.casino_outlined),
              label: I18n.HOME.tr,
            ),
            NavigationDestination(
              icon: Icon(Icons.album_outlined),
              label: I18n.ALBUMS.tr,
            ),
            NavigationDestination(
              icon: Icon(Icons.queue_music_outlined),
              label: I18n.PLAYLISTS.tr,
            ),
            NavigationDestination(
              icon: Icon(Icons.dns_outlined),
              label: I18n.SERVER.tr,
            ),
          ],
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changePage,
        ),
      ),
    );
  }
}
