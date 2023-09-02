import 'package:connect_bus/login_passageiro.dart';
import 'package:connect_bus/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createLoginScreen() => const MaterialApp(
      home: LoginPassageiroPage(),
    );

void main() {
  group('Teste de login', () {
    testWidgets('Verificar se campos email e senha aparecem', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      final emailField = find.byKey(const ValueKey('emailField'));
      expect(emailField, findsWidgets);
      final passwordField = find.byKey(const ValueKey('passwordField'));
      expect(passwordField, findsWidgets);
    });

    testWidgets('Verifica se o Icone do Onibus aparece', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      final iconBus = find.byIcon(Icons.bus_alert);
      expect(iconBus, findsOneWidget);
    });

    testWidgets('Verifica se o botão login aparece', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      final loginButton = find.byKey(const ValueKey('loginButton'));
      expect(loginButton, findsOneWidget);
    });
  });
}
