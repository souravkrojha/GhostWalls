import 'package:GhostWalls/Pages/WallpaperPage.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
// import 'package:random_color/random_color.dart';

// ignore: must_be_immutable
class WallpaperTile extends StatelessWidget {
  final String imgUrl, user, userUrl;
  final int id, likes, views, downloads, userId;

  WallpaperTile(
      {this.imgUrl,
      this.id,
      this.downloads,
      this.likes,
      this.user,
      this.userUrl,
      this.views,
      this.userId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WallpaperPage(
              imgUrl: imgUrl,
              imageId: id,
              downloads: downloads,
              likes: likes,
              user: user,
              userUrl: userUrl,
              views: views,
              userId: userId,
            ),
          ),
        );
      },
      child: Hero(
        tag: imgUrl,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FancyShimmerImage(
            shimmerDuration: Duration(hours: 1),
            imageUrl: imgUrl,
            boxFit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
