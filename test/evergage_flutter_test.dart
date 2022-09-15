import 'package:flutter_test/flutter_test.dart';
import 'package:evergage_flutter/evergage_flutter.dart';
import 'package:evergage_flutter/evergage_flutter_platform_interface.dart';
import 'package:evergage_flutter/evergage_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEvergageFlutterPlatform
    with MockPlatformInterfaceMixin
    implements EvergageFlutterPlatform {
  @override
  Future<void> start(String account, String dataset, bool usePushNotification) {
    // TODO: implement start
    throw UnimplementedError();
  }

  @override
  Future<void> viewProduct(String id, String name) {
    // TODO: implement viewProduct
    throw UnimplementedError();
  }

  @override
  Future<void> addToCart(
      String id, String name, double quantity, double price) {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  Future<void> purchase(String orderId, String lines, double total) {
    // TODO: implement purchase
    throw UnimplementedError();
  }

  @override
  Future<void> setUser(
      String userId, String email, String firstName, String lastName) {
    // TODO: implement setUser
    throw UnimplementedError();
  }

  @override
  Future<void> setZipCode(String zipCode) {
    // TODO: implement setZipCode
    throw UnimplementedError();
  }

  @override
  Future<void> viewCategory(String id, String name) {
    // TODO: implement viewCategory
    throw UnimplementedError();
  }
}

void main() {
  final EvergageFlutterPlatform initialPlatform =
      EvergageFlutterPlatform.instance;

  test('$MethodChannelEvergageFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEvergageFlutter>());
  });

  test('initialize', () async {
    EvergageFlutter evergageFlutterPlugin = EvergageFlutter();
    MockEvergageFlutterPlatform fakePlatform = MockEvergageFlutterPlatform();
    EvergageFlutterPlatform.instance = fakePlatform;

    //expect(await evergageFlutterPlugin.getPlatformVersion(), '42');
  });
}
