import 'package:firebase_storage/firebase_storage.dart';

class _FirebaseProvider {
  Future<String> getUrlImagen(String foto) async {
    String img = 'no';
    if (foto != null) {
      final ref = FirebaseStorage.instance.ref().child(foto);

      try {
        await ref.getDownloadURL().then((value) {
          img = value;
        });
      } on FirebaseException catch (e) {
        print("Error en la descarga de la imagen '${e.code}': ${e.message}");
      }
    }
    return img;
  }
}

final firebaseProvider = _FirebaseProvider();
