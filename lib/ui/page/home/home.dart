import 'package:annix/controllers/annil_controller.dart';
import 'package:annix/controllers/anniv_controller.dart';
import 'package:annix/services/player.dart';
import 'package:annix/i18n/i18n.dart';
import 'package:annix/services/global.dart';
import 'package:annix/ui/page/home/home_albums.dart';
import 'package:annix/ui/page/home/home_appbar.dart';
import 'package:annix/ui/page/home/home_title.dart';
import 'package:annix/ui/route/delegate.dart';
import 'package:annix/ui/widgets/cover.dart';
import 'package:annix/ui/widgets/utils/two_side_sliver.dart';
import 'package:annix/widgets/buttons/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PlaylistView extends StatelessWidget {
  final AnnivController anniv = Get.find();
  final AnnilController annil = Get.find();

  PlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == 0) {
              // fav
              return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: AspectRatio(
                    aspectRatio: 1,
                    child: anniv.favorites.isEmpty
                        ? DummyMusicCover()
                        : MusicCover(
                            albumId: anniv.favorites.values.last.track.albumId),
                  ),
                  title: Text(I18n.MY_FAVORITE.tr),
                  visualDensity: VisualDensity.standard,
                  onTap: () {
                    AnnixRouterDelegate.of(context).to(name: "/favorite");
                  });
            } else {
              index = index - 1;
            }

            final playlistId = anniv.playlists.keys.toList()[index];
            final playlist = anniv.playlists[playlistId]!;

            final albumId =
                playlist.cover.albumId == "" ? null : playlist.cover.albumId;
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: AspectRatio(
                aspectRatio: 1,
                child: albumId == null
                    ? DummyMusicCover()
                    : MusicCover(albumId: albumId),
              ),
              title: Text(
                playlist.name,
                overflow: TextOverflow.ellipsis,
              ),
              visualDensity: VisualDensity.standard,
              onTap: () async {
                final playlist =
                    await anniv.client!.getPlaylistDetail(playlistId);
                AnnixRouterDelegate.of(context)
                    .to(name: "/playlist", arguments: playlist);
              },
            );
          },
          childCount: anniv.playlists.length + 1,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final AnnivController anniv = Get.find();
  final AnnilController annil = Get.find();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: (<Widget>[
                  SliverAppBar.large(
                    title: Obx(() => HomeAppBar(info: anniv.info.value)),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    scrolledUnderElevation: 0,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.shuffle_outlined),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return Center(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(width: 12),
                                        Text("Loading..."),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                          Provider.of<PlayerService>(context, listen: false)
                              .fullShuffleMode()
                              .then((value) => Navigator.of(context).pop());
                        },
                      ),
                      ThemeButton(),
                    ],
                  ),
                ] +
                content())
            .map(
              (sliver) => SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                sliver: sliver,
              ),
            )
            .toList(),

        // (anniv.info.value != null ? content() : []),
      ),
    );
  }

  List<Widget> content() {
    return <Widget>[
      if (annil.albums.isNotEmpty) HomeAlbums(),

      ////////////////////////////////////////////////
      SliverPadding(
        padding: EdgeInsets.only(top: 48, left: 16, bottom: 16),
        sliver: TwoSideSliver(
          leftPercentage: Global.isDesktop ? 0.5 : 1,
          left: HomeTitle(
            sliver: true,
            title: I18n.PLAYLISTS.tr,
            icon: Icons.queue_music_outlined,
          ),
          right: HomeTitle(
            sliver: true,
            title: I18n.PLAYED_RECENTLY.tr,
            icon: Icons.music_note_outlined,
          ),
        ),
      ),
      TwoSideSliver(
        leftPercentage: Global.isDesktop ? 0.5 : 1,
        left: PlaylistView(),
        right: SliverToBoxAdapter(),
      ),
    ];
  }
}