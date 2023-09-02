import 'package:connect_bus/model/horario.dart';
import 'package:connect_bus/repositories/horarios_repository.dart';
import 'package:flutter/material.dart';

class HorariosController extends ChangeNotifier {
  List<ExpansionTile> expansionTiles = [];

  loadHorarios(String bairro) async {
    print('linhasHorariosDoBairro Controller ===>');
    var horariosRepository = HorariosRepository();
    List<Horario> linhasHorariosDoBairro =
        await horariosRepository.findByBairroName(bairro);
    print('linhasHorariosDoBairro Controller ===> $linhasHorariosDoBairro');

    // (método de ChangeNotifier) usado para notificar
    // qualquer um que esteja assistindo ParadasController
    notifyListeners();
  }
}
