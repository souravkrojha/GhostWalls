import 'package:GhostWalls/Data/ApiData.dart';
import 'package:GhostWalls/Models/WallpaperModel.dart';
import 'package:GhostWalls/Widgets/WallpaperWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  CategoryPage({this.category});
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<WallpaperModel> wallpaper = new List();
  ApiData apiData = ApiData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.category,
            style: TextStyle(fontStyle: FontStyle.normal),
          ),
          centerTitle: true,
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: FutureBuilder(
          future: apiData.fetchData(itemCount, category: widget.category),
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
      ),
    );
  }
}
