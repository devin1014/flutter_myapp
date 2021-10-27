const _homeStoryImage = "https://qa-nbaimageproxy.neulion.com/nba_d/thumbs/categories/\${id}_ph_es.jpg";

class ImageUtil {
  const ImageUtil._();

  static String getStory(String id) {
    return _homeStoryImage.replaceAll("\${id}", id);
  }
}
