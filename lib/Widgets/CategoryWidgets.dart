import 'package:GhostWalls/Models/CategoryModel.dart';
import 'package:GhostWalls/Pages/CategoryPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategorieTab extends StatelessWidget {
  const CategorieTab({
    Key key,
    @required this.categories,
  }) : super(key: key);

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                            category:
                                categories[index].categorieName.toLowerCase(),
                          )));
            },
            child: CateorieTiles(
              imgUrl: categories[index].categorieImgUrl,
              title: categories[index].categorieName,
            ),
          );
        },
      ),
    );
  }
}

class CateorieTiles extends StatelessWidget {
  final String imgUrl, title;
  CateorieTiles({this.imgUrl, this.title});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 240,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 200, left: 20),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    );
  }
}
