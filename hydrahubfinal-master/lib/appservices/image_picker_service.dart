import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService{

  static const String apiKey = 'AIzaSyBQ6pT1grNc1SUs5RmiPOF0d2u3TVezEJY';

  Future<void> getDataGallery(BuildContext context) async {
    dynamic gemini = Gemini.instance;

    XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      var convertedFile = File(pickImage.path);
      gemini
          .textAndImage(
        text: "What is this picture?", // text
        images: [convertedFile.readAsBytesSync()], // list of images
      )
          .then((value) {
        // Safely parse the response
        if (value != null && value.content?.parts != null && value.content!.parts.isNotEmpty) {
          final responseText = value.content!.parts.first.text;
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: const Text("Result"),
              content: Text(responseText),
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("Close"))
              ],
            );
          },);
          print(responseText); // Output the desired text
        } else {
          print('No content found in the response.');
        }
      })
          .catchError((e) => print('Error: $e'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image Not Selected')),
      );
    }
  }

  Future<void> getDataCamera(BuildContext context) async {
    dynamic gemini = Gemini.instance;

    XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickImage != null) {
      var convertedFile = File(pickImage.path);
      gemini
          .textAndImage(
        text: "What is this picture?", // text
        images: [convertedFile.readAsBytesSync()], // list of images
      )
          .then((value) {
        // Safely parse the response
        if (value != null && value.content?.parts != null && value.content!.parts.isNotEmpty) {
          final responseText = value.content!.parts.first.text;
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: const Text("Result"),
              content: Text(responseText),
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("Close"))
              ],
            );
          },);
          print(responseText); // Output the desired text
        } else {
          print('No content found in the response.');
        }
      })
          .catchError((e) => print('Error: $e'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image Not Selected')),
      );
    }
  }

}