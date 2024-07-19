import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'evergage_flutter_method_channel.dart';

abstract class EvergageFlutterPlatform extends PlatformInterface {
  /// Constructs a EvergageFlutterPlatform.
  EvergageFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static EvergageFlutterPlatform _instance = MethodChannelEvergageFlutter();

  /// The default instance of [EvergageFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelEvergageFlutter].
  static EvergageFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EvergageFlutterPlatform] when
  /// they register themselves.
  static set instance(EvergageFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> start(String account, String dataset, bool usePushNotification) {
    throw UnimplementedError('start() has not been implemented.');
  }

  Future<void> setUser(
      String userId, String email, String firstName, String lastName) {
    throw UnimplementedError('setUser() has not been implemented.');
  }

  Future<void> setZipCode(String zipCode) {
    throw UnimplementedError('setZipCode() has not been implemented.');
  }

  Future<void> setOpCo(String opCo) {
    throw UnimplementedError('setOpCo() has not been implemented.');
  }

  Future<void> viewProduct(String id, String name) {
    throw UnimplementedError('viewProduct() has not been implemented.');
  }

  Future<void> viewCategory(String id, String name) {
    throw UnimplementedError('viewCategory() has not been implemented.');
  }

  Future<void> addToCart(
      String id, String name, double quantity, double price) {
    throw UnimplementedError('addToCart() has not been implemented.');
  }

  Future<void> purchase(String orderId, String lines, double total) {
    throw UnimplementedError('purchase() has not been implemented.');
  }

   Future<void> sendEvent(String eventTrigger,) {
    throw UnimplementedError('sendEvent() has not been implemented.');
  }
}
