import 'package:GhostWalls/Data/ApiData.dart';
import 'package:GhostWalls/Models/WallpaperModel.dart';
import 'package:GhostWalls/Widgets/WallpaperWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<WallpaperModel> wallpaper = new List();
  ApiData apiData = ApiData();
  final searchText = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool show = false;
  String searchValue;
  int itemCount = 100;
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

  // function for fetching data from the pexels api

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // padding: ,
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Form(
          key: formKey,
          child: TextFormField(
            style: TextStyle(color: Colors.white, fontSize: 20),
            controller: searchText,
            onChanged: (val) {
              if (val.isEmpty) {
                setState(() {
                  show = false;
                });
              }
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10, top: 4),
                hintText: "Search Wallpaper",
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.2)
                // suffixIcon:
                ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              if (!formKey.currentState.validate()) {
                // return "Is not valid";

              } else {
                setState(() {
                  show = false;
                  show = true;
                });
              }
              return null;
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: show
          ? SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                child: FutureBuilder(
                  future:
                      apiData.fetchData(itemCount, category: searchText.text),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      // makePageLoadFalse();
                      return StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        physics: NeverScrollableScrollPhysics(),
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
            )
          : Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 180),
                  height: 200,
                  child: Center(
                    child: SvgPicture.asset(
                        "assets/images/undraw_the_search_s0xf.svg"),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Start by typing something in search box",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.2),
                )
              ],
            ),
    );
  }
}
