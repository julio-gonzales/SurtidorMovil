import 'package:firebase_storage/firebase_storage.dart';

class _FirebaseProvider {
  Future<String> getUrlImagen(String foto) async {
    String img;
    if (foto != null) {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final ref = storage.ref().child(foto);
      await ref.getDownloadURL().then((value) {
        img = value;
      });
    } else {
      img = 'no';
    }
    return img;
  }
}

final firebaseProvider = new _FirebaseProvider();
