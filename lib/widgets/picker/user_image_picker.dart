import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  //! this is a call back function
  //* We getting a function named imagePickedFn
  //* We execute it here by passing a picked image
  final void Function(File pickedImage) imagePickedFn;

  const UserImagePicker(this.imagePickedFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final picker = ImagePicker();
  File _pickedImage;

  void _pickImage() async {
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      //image quality ranges b/w 0-100
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImage.path);
    });
    widget.imagePickedFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text(
            "Add image",
          ),
          textColor: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
