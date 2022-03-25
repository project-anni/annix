import 'package:annix/models/metadata.dart';
import 'package:annix/pages/album_info.dart';
import 'package:annix/services/global.dart';
import 'package:annix/widgets/third_party/marquee_widget/marquee_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AlbumGrid extends StatefulWidget {
  final String albumId;
  final Widget cover;
  final String tag;

  AlbumGrid({
    Key? key,
    required this.albumId,
    required this.cover,
    String? tag,
  })  : this.tag = tag ?? Uuid().v4().toString(),
        super(key: key);

  @override
  _AlbumGridState createState() => _AlbumGridState();
}

class _AlbumGridState extends State<AlbumGrid> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: widget.tag,
              child: widget.cover,
            ),
            Positioned(
              bottom: 0,
              child: FutureBuilder<Album?>(
                future:
                    Global.metadataSource!.getAlbum(albumId: widget.albumId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => AlbumInfoScreen(
                            albumInfo: snapshot.data!.toAlbumInfo(),
                            tag: widget.tag,
                          ),
                        );
                      },
                      child: Container(
                        width: constraints.maxWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Marquee(
                            child: Text(
                              '${snapshot.data?.title}',
                              style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.black87,
                              ),
                            ),
                            pauseDuration: Duration(seconds: 1),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
