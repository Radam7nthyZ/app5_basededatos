import 'package:app5_basededatos/db/db_admin.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> getFullName() async {
    return " renso diaz";
  }

  showDialogForm() {
    showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Agregar Tarea"),
              SizedBox(
                height: 6.0,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Titulo"),
              ),
              SizedBox(
                height: 6.0,
              ),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(hintText: "Descripcion"),
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                children: [
                  Text("estado: "),
                  SizedBox(
                    width: 6.0,
                  ),
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
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
                    onPressed: () {},
                    child: Text("aceptar,"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DBadmin.db.getRawColegios();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogForm();
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: DBadmin.db.getColegios(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List<Map<String, dynamic>> myColegios = snap.data;
            return ListView.builder(
              itemCount: myColegios.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(myColegios[index]["nombres"]),
                  subtitle: Text(myColegios[index]["apellidos"]),
                  trailing: Text(myColegios[index]["id"].to.toString()),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
