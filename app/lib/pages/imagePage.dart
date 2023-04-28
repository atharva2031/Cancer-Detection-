import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:app/utils/globals.dart';

class MyImagePage extends StatefulWidget {
  const MyImagePage({Key? key}) : super(key: key);

  @override
  State<MyImagePage> createState() => MyImagePageState();
}

class MyImagePageState extends State<MyImagePage> {
  bool loading = true;
  late File _image;
  late List _output;
  final imagepicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }

  detectimage(File image) async {
    var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _output = prediction!;
      loading = false;
    });
  }

  loadmodel() async {
    if ("$selectedOption $subOption" == 'Blood Cancer Leukemia') {
      await Tflite.loadModel(
          model: 'app\lib\DL_Models_TFLite\Blood_Cancer_Leukemia_100.tflite');
    }
    if ("$selectedOption $subOption" == 'Blood Cancer Lymphoma') {
      await Tflite.loadModel(
          model: 'app\lib\DL_Models_TFLite\Blood_Cancer_Lymphoma_98.50.tflite');
    }
    if ("$selectedOption $subOption" == 'Brain Cancer') {
      await Tflite.loadModel(
          model: 'app\lib\DL_Models_TFLite\Brain_Cancer_Detailed_97.tflite');
    }
    if ("$selectedOption $subOption" == 'Breast Cancer pCR') {
      await Tflite.loadModel(
          model: 'app\lib\DL_Models_TFLite\Breast_Cancer_pCR_99.5.tflitee');
    }
    if ("$selectedOption $subOption" == 'Breast Cancer Histopathology') {
      await Tflite.loadModel(
          model:
              'app\lib\DL_Models_TFLite\Breast_Cancer_Histopathology_95.30.tflite');
    }
    if ("$selectedOption $subOption" == 'Breast Cancer Ultrasound') {
      await Tflite.loadModel(
          model:
              'app\lib\DL_Models_TFLite\Breast_Cancer_Ultrasound_99.2.tflite');
    }
    if ("$selectedOption $subOption" == 'Cervical Cancer') {
      await Tflite.loadModel(
          model: 'app\lib\DL_Models_TFLite\Cervical_Cancer_98.tflite');
    }
    if ("$selectedOption $subOption" == 'Colon Cancer') {
      await Tflite.loadModel(
          model: 'app\lib\DL_Models_TFLite\Colon_Cancer_98.31.tflite');
    }
    if ("$selectedOption $subOption" == 'Kidney Cancer') {
      await Tflite.loadModel(
          model: 'app\lib\DL_Models_TFLite\Kidney_Cancer_100.tflite');
    }
    if ("$selectedOption $subOption" == 'Lung Cancer Histopathology') {
      await Tflite.loadModel(
          model:
              'app\lib\DL_Models_TFLite\Lung_Cancer_Histopathology_97.40.tflite');
    }
    if ("$selectedOption $subOption" == 'Oral Cancer Histopathology') {
      await Tflite.loadModel(
          model:
              'app\lib\DL_Models_TFLite\Oral_Cancer_Histopathology_93.tflite');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  pickimage_camera() async {
    // ignore: deprecated_member_use
    var image = await imagepicker.getImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    detectimage(_image);
  }

  // ignore: non_constant_identifier_names
  pickimage_gallery() async {
    var image = await imagepicker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    ByteData data = await rootBundle.load(image.path);
    img.Image? sneakerImage = img.decodeImage(data.buffer.asUint8List());
    sneakerImage = img.grayscale(sneakerImage!);
    List<String> lV1 = [
      'Breast Cancer Histopathology',
      'Colon Cancer',
      'Kidney Cancer',
      'Lung Cancer'
    ];
    if (lV1.contains(selOp)) {
      sneakerImage = img.copyResize(sneakerImage, width: 200, height: 200);
    } else if (selOp == 'Breast Cancer Ultrasound') {
      sneakerImage = img.copyResize(sneakerImage, width: 224, height: 224);
    } else {
      sneakerImage = img.copyResize(sneakerImage, width: 256, height: 256);
    }
    detectimage(_image);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ML Classifier',
          style: GoogleFonts.roboto(),
        ),
      ),
      body: SizedBox(
        height: h,
        width: w,
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              padding: const EdgeInsets.all(10),
            ),
            Text('Mask Detector',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 50),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Text('Capture',
                          style: GoogleFonts.roboto(fontSize: 18)),
                      onPressed: () {
                        pickimage_camera();
                      }),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Text('Gallery',
                          style: GoogleFonts.roboto(fontSize: 18)),
                      onPressed: () {
                        pickimage_gallery();
                      }),
                ),
              ],
            ),
            loading != true
                ? Column(
                    children: [
                      Container(
                        height: 220,
                        // width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        child: Image.file(_image),
                      ),
                      // ignore: unnecessary_null_comparison
                      _output != null
                          ? Text((_output[0]['label']).toString().substring(2),
                              style: GoogleFonts.roboto(fontSize: 18))
                          : const Text(''),
                      // ignore: unnecessary_null_comparison
                      _output != null
                          ? Text('Confidence: ${_output[0]['confidence']}',
                              style: GoogleFonts.roboto(fontSize: 18))
                          : const Text('')
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
