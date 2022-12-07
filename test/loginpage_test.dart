import 'package:connect_bus/login_passageiro.dart';
import 'package:connect_bus/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createLoginScreen() => const MaterialApp(
      home: LoginPage(),
    );

void main() {
  group('Teste de login', () {
    testWidgets('Inserir dados passageiro', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      final emailField = find.byType(TextField);
      expect(emailField, findsWidgets);
    });
  });
}
