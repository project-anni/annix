import 'package:annix/providers.dart';
import 'package:annix/services/theme.dart';
import 'package:annix/ui/page/playing/playing_desktop.dart';
import 'package:annix/ui/route/delegate.dart';
import 'package:annix/ui/bottom_player/bottom_player.dart';
import 'package:flutter/material.dart';
import 'package:annix/i18n/strings.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// n |
/// a |
/// v |
///   |
///   |       body page
///   |
///   |
///   |
/// __|______________________
///            player
///
class AnnixLayoutDesktop extends ConsumerStatefulWidget {
  final AnnixRouterDelegate router;
  final Widget child;

  const AnnixLayoutDesktop({
    super.key,
    required this.child,
    required this.router,
  });

  @override
  ConsumerState<AnnixLayoutDesktop> createState() => _AnnixLayoutDesktopState();
}

class _AnnixLayoutDesktopState extends ConsumerState<AnnixLayoutDesktop> {
  static const pages = <String>[
    '/home',
    '/tags',
    '/settings',
  ];

  bool showIsPlaying = false;

  @override
  Widget build(final BuildContext context) {
    final root = Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: IndexedStack(
              index: showIsPlaying ? 0 : 1,
              children: [
                PlayingDesktopScreen(
                  onBack: () {
                    setState(() {
                      showIsPlaying = false;
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    (() {
                      final route = widget.router.currentRoute;
                      final selectedIndex =
                          pages.contains(route) ? pages.indexOf(route) : null;

                      return NavigationRail(
                        minExtendedWidth: 192,
                        selectedIndex: selectedIndex,
                        onDestinationSelected: (final index) {
                          widget.router.off(name: pages[index]);
                        },
                        extended: true,
                        destinations: <NavigationRailDestination>[
                          NavigationRailDestination(
                            icon: const Icon(Icons.home_outlined),
                            selectedIcon: const Icon(Icons.home),
                            label: Text(t.home),
                          ),
                          NavigationRailDestination(
                            icon: const Icon(Icons.local_offer_outlined),
                            selectedIcon: const Icon(Icons.local_offer),
                            label: Text(t.category),
                          ),
                          NavigationRailDestination(
                            icon: const Icon(Icons.settings_outlined),
                            selectedIcon: const Icon(Icons.settings),
                            label: Text(t.settings.settings),
                          ),
                        ],
                      );
                    })(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: widget.child),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          DesktopBottomPlayer(
            onClick: () {
              setState(() {
                showIsPlaying = true;
              });
            },
          ),
        ],
      ),
    );

    return Navigator(
      pages: [MaterialPage(child: root)],
      onPopPage: (final route, final result) {
        return false;
      },
      observers: [ThemePopObserver(ref.read(themeProvider))],
    );
  }
}
