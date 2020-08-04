import 'package:GhostWalls/Pages/ImageInfoPage.dart';
import 'package:dio/dio.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class WallpaperPage extends StatefulWidget {
  final String imgUrl, user, userUrl;
  final int imageId, likes, views, downloads, userId;
  WallpaperPage(
      {this.imgUrl,
      this.imageId,
      this.downloads,
      this.likes,
      this.user,
      this.userUrl,
      this.views,
      this.userId});
  @override
  _WallpaperPageState createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage>
    with SingleTickerProviderStateMixin {
  // bool _isdownloading = false;
  double _downloadprogress = 0.0;
  bool background = false;
  Dio dio = Dio();
  CancelToken cancelToken = CancelToken();

  void setDownloadProgress(double newvalue) {
    setState(() {
      _downloadprogress = newvalue;
    });
  }

  Future<bool> downloadImage() async {
    var dir = await getExternalStorageDirectory();
    // double _percentage = 0;
    await dio.download(widget.imgUrl, "${dir.path}/${widget.imageId}.jpg",
        onReceiveProgress: (actualbytes, totalbytes) async {
      var precentage = actualbytes / totalbytes * 100;
      // _percentage = precentage / 100;
      setDownloadProgress(precentage.floor() / 100);
      await Future.delayed(Duration(milliseconds: 10));

      print(_downloadprogress);
    }, cancelToken: cancelToken);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Hero(
          tag: widget.imgUrl,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.imgUrl,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 20),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        try {
                          if (background == false) {
                            cancelToken.cancel();
                          }
                        } catch (e) {}

                        Navigator.pop(context);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FabCircularMenu(
        fabSize: 45,
        // animationDuration: Duration(microseconds: 300),
        fabOpenColor: Colors.white,
        fabOpenIcon: Icon(
          Icons.short_text,
          color: Colors.white,
        ),
        ringColor: Colors.transparent,
        ringDiameter: 250,
        ringWidth: 70,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            // padding: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_downward,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _downloadprogress = 0;
                });

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title:
                        Text("Download", style: TextStyle(color: Colors.white)),
                    actionsPadding: EdgeInsets.zero,
                    content: FutureBuilder(
                      future: downloadImage(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return LinearProgressIndicator(
                            backgroundColor: Colors.black,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          );
                        } else {
                          return Text(
                            "Download Complete",
                            style: TextStyle(color: Colors.white),
                          );
                        }
                      },
                    ),
                    backgroundColor: Colors.black,
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          try {
                            cancelToken.cancel();
                          } catch (e) {}
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "Ok",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          try {
                            cancelToken.cancel();
                          } catch (e) {}
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageInfoPage(
                        downloads: widget.downloads,
                        imageId: widget.imageId,
                        imgUrl: widget.imgUrl,
                        likes: widget.likes,
                        user: widget.user,
                        userUrl: widget.userUrl,
                        views: widget.views,
                        userId: widget.userId,
                      ),
                    ),
                  );
                }),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  Share.share('check out this image ${widget.imgUrl}');
                }),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: IconButton(
                icon: Icon(
                  Icons.wallpaper,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.black,
                      title: Text(
                        "Set Wallpaper",
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Home",
                              style: TextStyle(color: Colors.white),
                            ),
                            // onTap: () => Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => SetWallpaperWidget(
                            //           imageLink: widget.imgUrl),
                            //     )),
                            onTap: () async {
                              var file = await DefaultCacheManager()
                                  .getSingleFile(widget.imgUrl);

                              await WallpaperManager.setWallpaperFromFile(
                                  file.path, WallpaperManager.HOME_SCREEN);
                              Toast.show("Wallpaper Applied", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                              leading: Icon(
                                Icons.screen_lock_portrait,
                                color: Colors.white,
                              ),
                              title: Text(
                                "Lock Screen",
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () async {
                                var file = await DefaultCacheManager()
                                    .getSingleFile(widget.imgUrl);

                                await WallpaperManager.setWallpaperFromFile(
                                    file.path, WallpaperManager.LOCK_SCREEN);
                                Toast.show("Wallpaper Applied", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black);
                                Navigator.pop(context);
                              }),
                          ListTile(
                              leading: Icon(
                                Icons.burst_mode,
                                color: Colors.white,
                              ),
                              title: Text(
                                "Both",
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () async {
                                var file = await DefaultCacheManager()
                                    .getSingleFile(widget.imgUrl);

                                await WallpaperManager.setWallpaperFromFile(
                                    file.path, WallpaperManager.BOTH_SCREENS);
                                Toast.show("Wallpaper Applied", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black);
                                Navigator.pop(context);
                              })
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
