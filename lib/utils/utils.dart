import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';import 'package:image_picker/image_picker.dart';

class Utils {
  final ImagePicker _picker = ImagePicker();
  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // Position at bottom
      backgroundColor: Colors.black45,
      textColor: Colors.white,
    );
  }

  static bool isExtraSmallMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 350;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 500 &&
      MediaQuery.of(context).size.width > 350;

  static bool isMobileLarge(BuildContext context) =>
      MediaQuery.of(context).size.width <= 700 &&
      MediaQuery.of(context).size.width >= 500;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 700 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<XFile?> pickImage(ImageSource imageSource) async {
    final image = await _picker.pickImage(source: imageSource);
    if (image != null) {
      return image;
    }
    return null;
  }



  Future<XFile?> showBottomSheetDialog(BuildContext context) async {
    return await showModalBottomSheet<XFile?>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              final image = await pickImage(ImageSource.camera);
                              Navigator.pop(context, image);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              final image =
                                  await pickImage(ImageSource.gallery);
                              Navigator.pop(context, image);
                            },
                            icon: const Icon(
                                Icons.photo_size_select_actual_outlined),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


}
