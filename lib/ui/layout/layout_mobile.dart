import 'package:annix/global.dart';
import 'package:annix/services/playback/playback.dart';
import 'package:annix/ui/page/playing/playing_mobile.dart';
import 'package:annix/ui/page/playing/playing_mobile_blur.dart';
import 'package:annix/ui/route/delegate.dart';
import 'package:annix/ui/bottom_player/bottom_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_slide/we_slide.dart';
import 'package:annix/i18n/strings.g.dart';

import 'package:annix/ui/layout/layout.dart';

class AnnixLayoutMobile extends AnnixLayout {
  final AnnixRouterDelegate router;
  final Widget child;

  static const pages = <String>[
    '/home',
    '/tags',
    '/server',
  ];

  const AnnixLayoutMobile({
    super.key,
    required this.child,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    final double panelMaxSize = MediaQuery.of(context).size.height;

    final root = Scaffold(
      body: Selector2<PlaybackService, AnnixRouterDelegate, List<bool>>(
        selector: (context, player, delegate) {
          final isPlaying = player.playing != null;
          final isMainPage = pages.contains(delegate.currentRoute);
          return [isPlaying, isMainPage];
        },
        builder: (context, result, child) {
          final isPlaying = result[0];
          final isMainPage = result[1];
          if (!isMainPage) {
            Global.mobileWeSlideFooterController.hide();
          } else {
            Global.mobileWeSlideFooterController.show();
          }

          return WeSlide(
            controller: Global.mobileWeSlideController,
            footerController: Global.mobileWeSlideFooterController,
            parallax: true,
            hideAppBar: true,
            hideFooter: true,
            panelBorderRadiusBegin: 12,
            panelBorderRadiusEnd: 0,
            backgroundColor: Colors.transparent,
            body: Material(child: child),
            panelMinSize: 60 + 80,
            panelMaxSize: panelMaxSize,
            isUpSlide: isPlaying,
            panelHeader: GestureDetector(
              onTap: () {
                if (isPlaying) {
                  Global.mobileWeSlideController.show();
                }
              },
              child: const MobileBottomPlayer(),
            ),
            panel: ValueListenableProvider.value(
              value: Global.settings.blurPlayingPage,
              updateShouldNotify: (old, value) => true,
              child: Builder(
                builder: (context) {
                  final blur = context.watch<bool>();
                  return blur
                      ? const PlayingScreenMobileBlur()
                      : const PlayingScreenMobile();
                },
              ),
            ),
            footerHeight: 80,
            footer: (() {
              final route = router.currentRoute;
              final selectedIndex =
                  pages.contains(route) ? pages.indexOf(route) : 0;

              return MediaQuery(
                data: MediaQuery.of(context).copyWith(padding: EdgeInsets.zero),
                child: NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    router.off(name: pages[index]);
                  },
                  destinations: [
                    NavigationDestination(
                      icon: const Icon(Icons.casino_outlined),
                      label: t.home,
                    ),
                    NavigationDestination(
                      icon: const Icon(Icons.local_offer_outlined),
                      label: t.category,
                    ),
                    NavigationDestination(
                      icon: const Icon(Icons.dns_outlined),
                      label: t.server.server,
                    ),
                  ],
                ),
              );
            })(),
          );
        },
        child: child,
      ),
    );

    return Navigator(
      pages: [MaterialPage(child: root)],
      onPopPage: (route, result) {
        return false;
      },
    );
  }
}
