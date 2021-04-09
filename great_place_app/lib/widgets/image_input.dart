import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systemPath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput({Key key, this.onSelectImage}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  static ImagePicker picker = ImagePicker();

  Future<void> _takePicture() async {
    final capturImage = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      if (capturImage != null) {
        _storedImage = File(capturImage.path);
      }
    });

    final appDir = await systemPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(capturImage.path);
    final savedImage =
        await File(capturImage.path).copy(('${appDir.path}/$fileName'));
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //This container for image preview....
        Container(
          height: 100,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text("No image taken"),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 90,
        ),
        FlatButton.icon(
          onPressed: _takePicture,
          icon: Icon(
            Icons.camera,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            "Take Picture",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
