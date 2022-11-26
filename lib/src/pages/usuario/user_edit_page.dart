import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servicios_flutter/models/user.dart';
import 'package:servicios_flutter/providers/user_provider.dart';
import 'package:servicios_flutter/src/pages/usuario/user_show_page.dart';
import 'package:servicios_flutter/src/utils/LSColors.dart';

class UserEdit extends StatefulWidget {
  const UserEdit({Key key}) : super(key: key);

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _direccionController = TextEditingController();
  bool estado;
  //File _fotoPerfil;
  String _fotoPerfil;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: LSColorSecondary,
      appBar: AppBar(
        title: const Text('Editar Usuario',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.topLeft,
                child: Text("Datos",
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextFormField(
                      controller: _nombreController..text = user.name,
                      decoration: const InputDecoration(
                          labelText: 'Nombre',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.7),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return 'El nombre debe contener al menos 3 letras';
                        } else if (value
                            .contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                          return 'El nombre debe contener caracteres especiales';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController..text = user.email,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.7),
                          ),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 3) {
                          return 'El correo ingresado no es valido';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _telefonoController..text = user.telefono,
                      decoration: const InputDecoration(
                          labelText: 'Teléfono',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.7),
                          ),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                          return 'El teléfono ingresado no es válido';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _direccionController..text = user.direccion,
                      decoration: const InputDecoration(
                          labelText: 'Dirección',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.7),
                          ),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                        value: user.estado != null ? user.estado : true,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.7),
                            ),
                            border: OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(
                            child: Text("Activo"),
                            value: true,
                          ),
                          DropdownMenuItem(
                            child: Text("Inactivo"),
                            value: false,
                          )
                        ],
                        hint: const Text("Estado"),
                        onChanged: (value) {
                          setState(() {
                            estado = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            estado = value;
                          });
                        }),
                    TextButton(
                        onPressed: () {
                          getImage();
                        },
                        child: const Text('Actualizar foto de perfil')),
                    const SizedBox(
                      height: 10,
                    ),
                    if (_fotoPerfil != null) ...{
                      Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey[300],
                          child: Image.memory(base64Decode(_fotoPerfil),
                              fit: BoxFit.cover)),
                    },
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(60),
                          backgroundColor: Colors.teal),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Map mapForm = getDataForm();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbarUpdate);
                          await userProvider.updateUser(user.id, mapForm);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          final ruta = MaterialPageRoute(
                              builder: (context) => UserShow(
                                    userId: user.id,
                                  ));
                          Navigator.pushAndRemoveUntil(
                              context, ruta, ModalRoute.withName('/'));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbarUpdateComplete);
                        }
                      },
                      child: const Text("Guardar"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> getDataForm() {
    var mapForm = <String, dynamic>{};
    mapForm['name'] = _nombreController.text;
    mapForm['telefono'] = _telefonoController.text;
    mapForm['direccion'] = _direccionController.text;
    mapForm['estado'] = estado;
    mapForm['foto_perfil'] = _fotoPerfil;
    return mapForm;
  }

  Future<void> getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _cropImage(image.path);
    }
  }

  Future<void> _cropImage(filePath) async {
    final croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        compressFormat: ImageCompressFormat.jpg,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (croppedImage != null) {
      File imageFile = File(croppedImage.path);
      var bytes = imageFile.readAsBytesSync();
      setState(() {
        _fotoPerfil = base64Encode(bytes);
        print('cropeado');
      });
    }
  }

  final snackbarUpdate = SnackBar(
    content: const Text('Actualizando datos...'),
    backgroundColor: Colors.teal[600],
  );
  final snackbarUpdateComplete = SnackBar(
    content: const Text('Datos actualizados correctamente'),
    backgroundColor: Colors.teal[600],
  );
}
