import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class NuevoRecuerdo extends StatelessWidget {
  NuevoRecuerdo({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Función para seleccionar una foto de la galería
  Future<String> pickImageFromGallery(BuildContext context) async {
    // Seleccionar la foto
    //print which platform is running
    if (kIsWeb) {
      //do something else
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var url = await uploadPhotoToStorage(image.path);
        print(url);
        firestore.collection('m&a').doc('both').collection('memories').add({
          'title': 'foto',
          'description': 'descripción de la foto',
          'url': url,
          'date': DateTime.now(),
          'createdBy': 'martin',
          'type': 'photo',
        }).then((value) => Navigator.pop(context));
      }
    } else {
      //do something else
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var url = await uploadPhotoToStorage(image.path);
        print(url);

        firestore.collection('m&a').doc('both').collection('memories').add({
          'title': 'foto',
          'description': 'descripción de la foto',
          'url': url,
          'date': DateTime.now(),
          'createdBy': 'martin',
          'type': 'photo',
        }).then((value) => Navigator.pop(context));
      }
    }

    return '';
  }

  Future<String> uploadPhotoToStorage(String filePath) async {
    // Nombre único para el archivo en Firebase Storage
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Referencia a Firebase Storage con el nombre del archivo
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);

    // Subir el archivo a Firebase Storage
    await ref.putFile(File(filePath));

    // Obtener la URL de la foto subida
    String photoUrl = await ref.getDownloadURL();

    return photoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'nueva',
              style: TextStyle(
                  fontFamily: 'visby',
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'título',
              style: TextStyle(
                  fontFamily: 'visby',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: titleController,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'título',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'contenido',
              style: TextStyle(
                  fontFamily: 'visby',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: contentController,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'contenido',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    //guardar en firebase
                    pickImageFromGallery(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.fromBorderSide(
                          BorderSide(color: Colors.black, width: 2)),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("guardar",
                              style: TextStyle(
                                  fontFamily: 'visby',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.save,
                            color: Colors.black,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
