const _homeStoryImage = "https://qa-nbaimageproxy.neulion"
    ".com/nba_d/thumbs/categories/\${image}";

class ImageUtil {
  const ImageUtil._();

  static String getStory(String image) {
    return _homeStoryImage.replaceAll("\${image}", image);
  }
}
