/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class CameraPreviewScreen extends StatefulWidget {
  @override
  _CameraPreviewScreenState createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  File? _imageFile;

  @override
  void initState() {
    super.initState();

    // Get the first available camera and initialize the controller
    _initializeControllerFuture = initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    await _controller.initialize();
  }

  Future<void> takePicture() async {
    try {
      // Ensure that the controller is initialized before calling takePicture()
      await _initializeControllerFuture;

      final image = await _controller.takePicture();

      setState(() {
        _imageFile = File(image.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the screen is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Camera preview
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

          // Image preview
          if (_imageFile != null) Image.file(_imageFile!),

          // Buttons to take picture or pick image
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: takePicture,
                  child: Icon(Icons.camera_alt),
                ),
                FloatingActionButton(
                  onPressed: pickImage,
                  child: Icon(Icons.photo_library),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/