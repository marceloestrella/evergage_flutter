import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:evergage_flutter/evergage_flutter_method_channel.dart';

void main() {
  MethodChannelEvergageFlutter platform = MethodChannelEvergageFlutter();
  const MethodChannel channel = MethodChannel('evergage_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('initialize', () async {
    //expect(await platform.initialize(), '42');
  });
}
