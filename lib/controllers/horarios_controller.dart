import 'package:connect_bus/repositories/horarios_repository.dart';
import 'package:flutter/material.dart';

class HorariosController extends ChangeNotifier {
  var horariosRepository = HorariosRepository();
  loadHorarios(bairro) {
    horariosRepository.findByBairroName(bairro);
  }
}
