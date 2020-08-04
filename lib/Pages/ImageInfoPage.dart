import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageInfoPage extends StatefulWidget {
  final String imgUrl, user, userUrl;
  final int imageId, likes, views, downloads, userId;
  ImageInfoPage(
      {this.imgUrl,
      this.imageId,
      this.downloads,
      this.likes,
      this.user,
      this.userUrl,
      this.views,
      this.userId});
  @override
  _ImageInfoPageState createState() => _ImageInfoPageState();
}

class _ImageInfoPageState extends State<ImageInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 20),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, left: 10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.network(
                    widget.userUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  widget.user,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 150),
                  child: IconButton(
                      icon: Icon(
                        Icons.person_outline,
                        size: 35,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        launch(
                            "https://pixabay.com/users/${widget.user}-${widget.userId}/");
                      }))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 0.5,
            color: Colors.white,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Views",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.views.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.white))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Likes",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.likes.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.white))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Downloads",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.downloads.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.white))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 30),
            height: 0.5,
            color: Colors.white,
          ),
          Text(
            "Powered By",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          GestureDetector(
            onTap: () {
              launch("http://pixabay.com/");
            },
            child: Container(
              height: 100,
              width: 200,
              child: SvgPicture.asset(
                "assets/images/pixabay.svg",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
