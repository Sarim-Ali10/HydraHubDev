import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService{

  static const String apiKey = 'AIzaSyBQ6pT1grNc1SUs5RmiPOF0d2u3TVezEJY';


  Future pickImageCamera()async{
    XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if(pickImage != null){
      Uint8List convertedFile = await pickImage.readAsBytes();
      final aiClient = GoogleGenerativeAI(
        apiKey: 'YOUR_API_KEY',
      );
      final response = await aiClient.generateTextAndImage(
        prompt: 'A',
        image: convertedFile,
      );
      return convertedFile;
    } else{
      return null;
    }
  }

  Future pickImageGallery()async{
    XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickImage != null){
      Uint8List convertedFile = await pickImage.readAsBytes();
      final content = [
        Content.multi([
          TextPart('Analyze the skin condition in this image and tell me about which skin disease is this. Why it happens. What is the cure of this. how much time it require to be cured. Answer me in the JSON format. having keys like title (Disease Name). and cure and month to be cured and precautions'),
          // The only accepted mime types are image/*.
          DataPart('image/jpeg', convertedFile),
        ])
      ];
      var response = await model.generateContent(content);
      debugPrint("API Reponse: $response");
      return convertedFile;
    } else{
      return null;
    }
  }


}