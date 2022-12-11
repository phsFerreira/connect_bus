import 'package:connect_bus/login_passageiro.dart';
import 'package:connect_bus/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Teste de login', () {
    testWidgets('Verifica se botões Passageiro e Motorista aparecem',
        (tester) async {
      // Cria o Widget ao dizer para o tester criá-lo.
      await tester.pumpWidget(const MyApp());

      // Procurando por Widget Text() utilizando Finder.
      final buttonPassengerFinder = find.text('PASSAGEIRO');
      final buttonMotoristFinder = find.text('MOTORISTA');

      // Usa o `findsOneWidget` matcher para verificar se o widget Text()
      // aparece exatamente 1 vez na árvore de widgets
      expect(buttonPassengerFinder, findsOneWidget);
      expect(buttonMotoristFinder, findsOneWidget);
    });
  });
}
