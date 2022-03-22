import 'package:annix/controllers/playing_controller.dart';
import 'package:annix/controllers/playlist_controller.dart';
import 'package:annix/pages/album_list.dart';
import 'package:annix/pages/setup.dart';
import 'package:annix/services/global.dart';
import 'package:annix/views/search.dart';
import 'package:annix/widgets/draggable_appbar.dart';
import 'package:annix/widgets/repeat_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnixApp extends StatelessWidget {
  const AnnixApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(primarySwatch: Colors.blueGrey);
    final darkTheme = ThemeData(brightness: Brightness.dark);

    return GetBuilder<GetMaterialController>(
      init: Get.rootController,
      initState: (_) {
        Get.config(
          enableLog: Get.isLogEnable,
          defaultTransition: Get.defaultTransition,
          defaultOpaqueRoute: Get.isOpaqueRouteDefault,
          defaultPopGesture: Get.isPopGestureEnable,
          defaultDurationTransition: Get.defaultTransitionDuration,
        );
      },
      builder: (_) {
        return MaterialApp(
          theme: _.theme ?? theme,
          darkTheme: _.darkTheme ?? darkTheme,
          themeMode: _.themeMode,
          scaffoldMessengerKey: _.scaffoldMessengerKey,
          home: AnnixMain(),
        );
      },
    );
  }
}

class AnnixMain extends StatelessWidget {
  const AnnixMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PlayingController(service: Global.audioService));
    Get.put(Global.annil);
    Get.put(PlaylistController(service: Global.audioService));

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Light / Dark Theme"),
              onTap: () {
                Get.changeThemeMode(
                  Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                );
              },
            )
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (Get.key.currentState?.canPop() ?? false) {
            Get.back();
            return false;
          }

          return true;
        },
        child: Navigator(
          key: Get.key,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            if (settings.name == '/') {
              return GetPageRoute(page: () => AnnixHome());
            } else {
              return GetPageRoute(page: () => Container());
            }
          },
        ),
      ),
      bottomNavigationBar: BottomPlayer(),
    );
  }
}

class AnnixHome extends StatelessWidget {
  const AnnixHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferSizedMoveWindow(
          child: AppBar(
            // toolbarHeight: 48,
            title: const TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              tabs: [
                Tab(child: Text("Playlists")),
                Tab(child: Text("Albums")),
                Tab(child: Text("Categories")),
              ],
            ),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Get.to(
                    () => SearchScreen(),
                    transition: Transition.fade,
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Builder(builder: (context) {
              print(1);
              return Icon(Icons.directions_car);
            }),
            AlbumList(),
            Builder(builder: (context) {
              print(3);
              return AnnixSetup();
            }),
          ],
        ),
      ),
    );
  }
}

class BottomPlayer extends StatelessWidget {
  const BottomPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayingController playing = Get.find();

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        double sensitivity = 360;

        print(details.primaryVelocity);
        if (details.primaryVelocity! > sensitivity) {
          // Right Swipe, prev
          print("Right Swipe, prev");
          playing.service.previous();
        } else if (details.primaryVelocity! < -sensitivity) {
          // Left Swipe, next
          print("Left Swipe, next");
          playing.service.next();
        }
      },
      child: Container(
        height: 64,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Obx(
              () => Global.annil.cover(
                  albumId: playing.state.value.track?.track.albumId ?? "TODO"),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Obx(
                () => Text(
                  "${playing.state.value.track?.info.title}",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            RepeatButton(
              initial: Global.audioService.repeatMode,
              onRepeatModeChange: (mode) {
                Global.audioService.repeatMode = mode;
              },
            ),
            Obx(
              () => playing.status.value == PlayingStatus.loading
                  ? CircularProgressIndicator()
                  : IconButton(
                      icon: Icon(playing.status.value == PlayingStatus.playing
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: () async {
                        if (playing.status.value == PlayingStatus.playing) {
                          playing.service.pause();
                        } else {
                          playing.service.play();
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
