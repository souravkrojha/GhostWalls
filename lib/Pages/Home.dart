import 'package:GhostWalls/Data/Categorydata.dart';
import 'package:GhostWalls/Models/CategoryModel.dart';
import 'package:GhostWalls/Pages/AboutPage.dart';
import 'package:GhostWalls/Pages/SearchPage.dart';
import 'package:GhostWalls/Widgets/CategoryWidgets.dart';
import 'package:GhostWalls/Widgets/HomeTabWidget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  fetchData() {}
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List();
  String sortyBy = "";
  int something = 0;

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              elevation: 0,
              flexibleSpace: SafeArea(
                child: TabBar(
                  indicatorColor: Colors.black,
                  tabs: [
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text("HOME", style: TextStyle(fontSize: 16))),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child:
                            Text("CATEGROIES", style: TextStyle(fontSize: 16)))
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(children: [
            HomeTab(
              sortBy: sortyBy,
            ),
            CategorieTab(categories: categories)
          ]),
          bottomNavigationBar: SizedBox(
            height: 40,
            child: new BottomAppBar(
              color: Colors.black,
              shape: CircularNotchedRectangle(),
              elevation: 0,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Theme(
                          data: ThemeData.dark(),
                          child: AlertDialog(
                            backgroundColor: Colors.black,
                            title: Text(
                              "Sort By",
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Radio(
                                        value: 0,
                                        groupValue: something,
                                        onChanged: (value) {
                                          setState(() {
                                            something = value;
                                            sortyBy = "popular";
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Text(
                                        "Popular",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Radio(
                                        value: 1,
                                        groupValue: something,
                                        onChanged: (value) {
                                          setState(() {
                                            something = value;
                                            sortyBy = "latest";
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Text(
                                        "Latest",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.sort,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }
}
