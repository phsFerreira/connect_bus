import 'package:connect_bus/maps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget createMapScreen() => const MaterialApp(
    //  home: MapSample(),
    );

void main() {
  group('Teste tela Google Maps', () {
    testWidgets('', ((widgetTester) async {
      await widgetTester.pumpWidget(MapSample());
      final maps = find.byType(GoogleMap);
      expect(maps, findsOneWidget);
    }));
  });
}
