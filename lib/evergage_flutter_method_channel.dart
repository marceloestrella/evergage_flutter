import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'evergage_flutter_platform_interface.dart';

/// An implementation of [EvergageFlutterPlatform] that uses method channels.
class MethodChannelEvergageFlutter extends EvergageFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('evergage_flutter');

  @override
  Future<void> start(
      String account, String dataset, bool usePushNotification) async {
    await methodChannel.invokeMethod('start', {
      'account': account,
      'dataset': dataset,
      'usePushNotification': usePushNotification
    });
  }

  @override
  Future<void> setUser(
      String userId, String email, String firstName, String lastName) async {
    await methodChannel.invokeMethod('setUser', {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName
    });
  }

  @override
  Future<void> setZipCode(String zipCode) async {
    await methodChannel.invokeMethod('setZipCode', {'zipCode': zipCode});
  }
  
  @override
  Future<void> setOpCo(String opCo) async {
    await methodChannel.invokeMethod('setOpCo', {'OpCo': opCo});
  }

  @override
  Future<void> viewProduct(String id, String name) async {
    await methodChannel.invokeMethod('viewProduct', {'id': id, 'name': name});
  }

  @override
  Future<void> viewCategory(String id, String name) async {
    await methodChannel.invokeMethod('viewCategory', {'id': id, 'name': name});
  }

  @override
  Future<void> addToCart(
      String id, String name, double quantity, double price) async {
    await methodChannel.invokeMethod('addToCart',
        {'id': id, 'name': name, 'price': price, 'quantity': quantity});
  }

  @override
  Future<void> purchase(String orderId, String lines, double total) async {
    await methodChannel.invokeMethod(
        'purchase', {'orderId': orderId, 'lines': lines, 'total': total});
  }

  @override
  Future<void> sendEvent(String eventTrigger,) async {
    await methodChannel.invokeMethod(
        'sendEvent', {'eventTrigger': eventTrigger,});
  }
}
