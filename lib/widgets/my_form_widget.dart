import 'package:app5_basededatos/db/db_admin.dart';
import 'package:app5_basededatos/models/cole_model.dart';
import 'package:flutter/material.dart';

class MyForWidget extends StatefulWidget {
  const MyForWidget({super.key});

  @override
  State<MyForWidget> createState() => _MyForWidgetState();
}

class _MyForWidgetState extends State<MyForWidget> {
  bool isFinished = false;
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();

  addColegio() {
    ColegioModel colegioModel = ColegioModel(
      nombres: _nombresController.text,
      apellidos: _apellidosController.text,
      status: isFinished.toString(),
    );
    DBadmin.db.insertColegio(colegioModel).then((value) {
      if (value > 0) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            duration: const Duration(milliseconds: 1400),
            content: Row(
              children: const [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Tarea Registrada con exito",
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Agregar Tarea"),
          const SizedBox(
            height: 6.0,
          ),
          TextField(
            controller: _nombresController,
            decoration: InputDecoration(hintText: "Titulo"),
          ),
          const SizedBox(
            height: 6.0,
          ),
          TextField(
            controller: _apellidosController,
            maxLines: 3,
            decoration: InputDecoration(hintText: "Descripcion"),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Row(
            children: [
              const Text("estado: "),
              const SizedBox(
                width: 6.0,
              ),
              Checkbox(
                value: isFinished,
                onChanged: (value) {
                  isFinished = value!;
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "cancelar",
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  addColegio();
                },
                child: Text("aceptar,"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
