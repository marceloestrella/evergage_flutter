import 'evergage_flutter_platform_interface.dart';

class EvergageFlutter {
  Future<void> start(String account, String dataset, bool usePushNotification) {
    return EvergageFlutterPlatform.instance
        .start(account, dataset, usePushNotification);
  }

  Future<void> setUser(
      String userId, String email, String firstName, String lastName) {
    return EvergageFlutterPlatform.instance
        .setUser(userId, email, firstName, lastName);
  }

  Future<void> setZipCode(String zipCode) {
    return EvergageFlutterPlatform.instance.setZipCode(zipCode);
  }

  Future<void> viewProduct(String id, String name) {
    return EvergageFlutterPlatform.instance.viewProduct(id, name);
  }

  Future<void> viewCategory(String id, String name) {
    return EvergageFlutterPlatform.instance.viewCategory(id, name);
  }

  Future<void> addToCart(
      String id, String name, double quantity, double price) {
    return EvergageFlutterPlatform.instance
        .addToCart(id, name, quantity, price);
  }

  Future<void> purchase(String orderId, String lines, double total) {
    return EvergageFlutterPlatform.instance.purchase(orderId, lines, total);
  }
}
