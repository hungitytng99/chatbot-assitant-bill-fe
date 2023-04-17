import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/ui/widgets/pages/app_page.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  final String url;

  const PhotoViewPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBarTitle: 'Ảnh',
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(widget.url),
      ),
    );
  }
}
