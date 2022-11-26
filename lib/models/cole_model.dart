class ColegioModel {
  int id;
  String nombres;
  String apellidos;
  String status;
  ColegioModel({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.status,
  });

  factory ColegioModel.deMapAModel(Map<String, dynamic> mapa) => ColegioModel(
        id: mapa["id"],
        nombres: mapa["nombres"],
        apellidos: mapa["apellidos"],
        status: mapa["status"],
      );
}
