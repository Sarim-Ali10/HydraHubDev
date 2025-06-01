import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../constants/colors.dart';
import '../constants/size_config.dart';
import 'package:skinai/appservices/image_picker_service.dart';
import '../views/chat_image_screen.dart';

class FaceScannerDialog extends StatelessWidget {
  const FaceScannerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePickerService imagePickerService = ImagePickerService();

    return AlertDialog(
      backgroundColor: secondaryColor,
      title: Text(
        'Face Scanner',
        style: TextStyle(
          fontSize: SizeConfig.textMultiplier * 2,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
      content: Text(
        'Scan Your Face via',
        style: TextStyle(
          fontSize: SizeConfig.textMultiplier * 1.4,
          fontWeight: FontWeight.w400,
          color: primaryColor,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Gallery',
            style: TextStyle(color: primaryColor),
          ),
          onPressed: () async {
            final String userImage =
            await imagePickerService.uploadingImageToFirebase(context, 1);
            Navigator.pop(context); // Close dialog first
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatWithImageScreen(userImage: userImage),
              ),
            );
          },
        ),
        TextButton(
          child: const Text(
            'Camera',
            style: TextStyle(color: primaryColor),
          ),
          onPressed: () async {
            final String userImage =
            await imagePickerService.uploadingImageToFirebase(context, 0);
            Navigator.pop(context); // Close dialog first
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatWithImageScreen(userImage: userImage),
              ),
            );
          },
        ),
      ],
    );
  }
}
