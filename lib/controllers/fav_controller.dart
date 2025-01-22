import 'package:get/get.dart';

class FavoritesController extends GetxController {
  var favorites = <Map<String, dynamic>>[].obs;

  void addToFavorites(Map<String, dynamic> item) {
    if (!favorites.any((favorite) => favorite['id'] == item['id'])) {
      favorites.add(item);
      Get.snackbar("Added", "${item['title'] ?? item['name']} added to favorites");
    } else {
      Get.snackbar("Already in Favorites", "${item['title'] ?? item['name']} is already in favorites");
    }
  }

  void removeFromFavorites(int id) {
    favorites.removeWhere((item) => item['id'] == id);
    Get.snackbar("Removed", "Item removed from favorites");
  }
}
