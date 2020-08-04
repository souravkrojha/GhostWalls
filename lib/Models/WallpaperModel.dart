class WallpaperModel {
  String user;
  String userUrl;
  String wallpaperUrl;
  String pageUrl;
  int id;
  int views;
  int downloads;
  int likes;
  int userId;

  WallpaperModel(
      {this.pageUrl,
      this.user,
      this.userUrl,
      this.wallpaperUrl,
      this.id,
      this.downloads,
      this.likes,
      this.views,
      this.userId});
}
