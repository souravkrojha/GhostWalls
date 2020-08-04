import 'dart:convert';
import 'package:requests/requests.dart';
import 'package:GhostWalls/Models/WallpaperModel.dart';

class ApiData {
  String api = "17144076-f9a46efb2d4940dc87c64c64a";
  Future<List<WallpaperModel>> fetchData(int itemCount,
      {String category, sortBy}) async {
    String url =
        "https://pixabay.com/api/?key=17664833-ee5b75102f53388985c01d5c5&image_type=photo&q=$category&per_page=$itemCount&orientation=vertical&order=$sortBy&editors_choice=false";
    List<WallpaperModel> apidata = [];
    var response = await Requests.get(url);

    var jsonData = jsonDecode(response.content());
    jsonData["hits"].forEach((element) {
      // print(element);
      WallpaperModel wallpaperModel = WallpaperModel(
          pageUrl: element["pageUrl"],
          user: element["user"],
          userUrl: element["userImageURL"],
          wallpaperUrl: element["largeImageURL"],
          id: element["id"],
          views: element["views"],
          downloads: element["downloads"],
          likes: element["likes"],
          userId: element["user_id"]);
      apidata.add(wallpaperModel);
    });
    return apidata;
  }
}
