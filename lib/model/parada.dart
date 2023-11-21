class Parada {
  Parada(
      {required this.bairro,
      required this.latitude,
      required this.longitude,
      this.onibus});
  String? bairro;
  double? latitude;
  double? longitude;
  List? onibus;
}
