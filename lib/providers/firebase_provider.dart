import 'package:firebase_storage/firebase_storage.dart';

class _FirebaseProvider {

  Future<String> getUrlImagen(String foto) async {
    String img;
    if (foto != null) {
      final ref = FirebaseStorage.instance.ref().child(foto);
      await ref.getDownloadURL().then((value) {
        img = value;
      });
    } else {
      img = 'no';
    }
    return img;
  }
}

final firebaseProvider = _FirebaseProvider();
