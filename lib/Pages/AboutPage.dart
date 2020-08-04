import 'package:GhostWalls/Data/my_flutter_app_icons.dart';
import 'package:GhostWalls/Widgets/AppTitle.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "About",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              About(),
              SizedBox(
                height: 8,
              ),
              ListTile(
                title: Text(
                  "Ghost Walls",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                subtitle: Text(
                  "Stunning free images & royalty free stock",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              HorizontalLine(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Text(
                  "About App",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "GitHub",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    subtitle: Text(
                      "GhostWalls is open-source,check it out on GitHub",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      launch("https://github.com/bughunter-99/GhostWalls");
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Report Bug",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    subtitle: Text(
                      "Report a bug or request for new features",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      launch(
                          "https://github.com/bughunter-99/GhostWalls/issues");
                    },
                  )
                ],
              ),
              HorizontalLine(),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  "Connect",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Icon(
                    MyFlutterApp.github_circled_alt2,
                    size: 30,
                    color: Color(0xfff1f1f1f1),
                  ),
                ),
                title: Text(
                  "GitHub",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                subtitle: Text(
                  "@bughunter-99",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  launch("https://www.github.com/bughunter-99");
                },
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Icon(
                    MyFlutterApp.linkedin,
                    size: 30,
                    color: Color(0xfff1f1f1f1),
                  ),
                ),
                title: Text(
                  "LinkedIn",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                subtitle: Text(
                  "@SouravOjha",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  launch("https://www.linkedin.com/in/sourav-ojha-82ba81195/");
                },
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Icon(
                    MyFlutterApp.instagram,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Instagram",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                subtitle: Text(
                  "@_ghost_wheel_",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  launch("https://www.instagram.com/_ghost_wheel_");
                },
              ),
              HorizontalLine(),
              ListTile(
                title: Text(
                  "View Licences",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () {
                  showLicensePage(
                    context: context,
                    applicationName: "GhostWalls",
                    applicationVersion: "0.1.0",
                  );
                },
              ),
            ],
          ),
        ));
  }
}

class HorizontalLine extends StatelessWidget {
  final Color color;
  const HorizontalLine({this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 1.0,
        width: 1000.0,
        color: color,
      ),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          AppTitle(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "0.1.0",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
