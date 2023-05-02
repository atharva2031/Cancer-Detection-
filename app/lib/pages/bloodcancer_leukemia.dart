import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class MyBloodCancerLeukemia extends StatefulWidget {
  const MyBloodCancerLeukemia({Key? key}) : super(key: key);

  @override
  MyBloodCancerLeukemiaState createState() => MyBloodCancerLeukemiaState();
}

class MyBloodCancerLeukemiaState extends State<MyBloodCancerLeukemia> {
  File? _image;
  bool _isLoading = false;
  List? _output;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _isLoading = true;

    loadModel().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  Future pickImage() async {
    // ignore: deprecated_member_use
    var pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedImage!.path);
    });

    predictImage(_image!);
  }

  Future loadModel() async {
    await Tflite.loadModel(
        model: 'assets/my_model1.tflite', labels: 'assets/labels1.txt');
  }

  Future predictImage(File image) async {
    // ignore: unnecessary_null_comparison
    if (image == null) return;

    setState(() {
      _isLoading = true;
    });

    // Load the image using the image package
    img.Image? oriImage = img.decodeImage(image.readAsBytesSync());

    // Convert the image to grayscale
    img.Image? grayscaleImage = img.grayscale(oriImage!);

    // Resize the image to (256, 256)
    img.Image? resizedImage =
        img.copyResize(grayscaleImage!, width: 256, height: 256);

    // Convert the image to a Uint8List to be used in Tflite
    Uint8List imageBytes = resizedImage!.getBytes();

    // Run the image through the Tflite model
    var output = await Tflite.runModelOnBinary(binary: imageBytes);

    setState(() {
      _isLoading = false;
      _output = output!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grayscale Image Classification'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _output == null
                ? const Text('No image selected')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.file(
                        _image!,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Confidence: ${_output![0]['confidence']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Class label: ${_output![0]['label']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add),
      ),
    );
  }
}
