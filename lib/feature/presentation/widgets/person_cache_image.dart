import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PersonCacheImage extends StatelessWidget {
  final String? imageUrl;
  final double? width, height;

  const PersonCacheImage({Key? key, this.imageUrl, this.width, this.height})
      : super(key: key);

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: "http://via.placeholder.com/200x150",
      imageBuilder: (context, imageProvider) {
        print(imageProvider);
        return Image.network(imageProvider.toString());
      },
      // placeholder: (context, url) {
      //   return Center(
      //     child: CircularProgressIndicator(),
      //   );
      //   // return _imageWidget(
      //   //   AssetImage('assets/image/no-image.jpg'),
      //   // );
      // },
      errorWidget: (context, url, error) {
        return _imageWidget(
          AssetImage('assets/image/no-image.jpg'),
        );
      },
    );
  }
}