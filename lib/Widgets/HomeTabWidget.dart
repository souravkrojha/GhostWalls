import 'package:GhostWalls/Data/ApiData.dart';
import 'package:GhostWalls/Models/WallpaperModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'WallpaperWidget.dart';

class HomeTab extends StatefulWidget {
  final String sortBy;
  HomeTab({this.sortBy});
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  List<WallpaperModel> wallpaper = new List();
  ApiData apiData = ApiData();
  String category = "galaxy";
  int itemCount = 20;
  ScrollController _scrollController = new ScrollController();

  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Bottom poistion
        setState(() {
          itemCount += 20;
        });
      }
    });
  }

  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: FutureBuilder(
        future: apiData.fetchData(itemCount,
            category: category, sortBy: widget.sortBy),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            // makePageLoadFalse();
            return StaggeredGridView.countBuilder(
              controller: _scrollController,
              crossAxisCount: 4,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return WallpaperTile(
                  imgUrl: snapshot.data[index].wallpaperUrl,
                  id: snapshot.data[index].id,
                  downloads: snapshot.data[index].downloads,
                  likes: snapshot.data[index].likes,
                  user: snapshot.data[index].user,
                  userUrl: snapshot.data[index].userUrl,
                  views: snapshot.data[index].views,
                  userId: snapshot.data[index].userId,
                );
              },
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.count(2, index.isEven ? 4 : 2),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
