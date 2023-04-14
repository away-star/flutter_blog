/**
 * String Utility class
 */
class StrUtil {
  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  static String trimString(String text) {
    return text.trim();
  }
}
