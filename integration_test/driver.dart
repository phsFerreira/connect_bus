import 'package:integration_test/integration_test_driver_extended.dart';

// Esse código habilita o driver do teste de integração e então espera
// pela execução do teste.
// A resposta dos dados é armazenado em um arquivo chamado `integration_response_data.json``
// depois que os testes executam.

Future<void> main() => integrationDriver();
