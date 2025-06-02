import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:mockapp/res/components/customOutlineButton.dart';
import 'package:mockapp/view/mobile%20view/search_vehicle.dart';
import 'package:path_provider/path_provider.dart';
import '../../res/components/CustomGradientButton.dart';

class ScanVehiclePlate extends StatefulWidget {
  File? imageFile;
  Uint8List? imageData;

  ScanVehiclePlate({super.key, this.imageFile, this.imageData});

  @override
  _ScanVehiclePlateState createState() => _ScanVehiclePlateState();
}

class _ScanVehiclePlateState extends State<ScanVehiclePlate> {
  final CropController _cropController = CropController();
  late final String vehicleRegistration;

  // bool _isCropping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Crop(
            controller: _cropController,
            image: widget.imageData!,
            onCropped: (cropped) async {
              final tempDir = await getTemporaryDirectory();
              final croppedFile = File('${tempDir.path}/cropped_image.jpg');
              await croppedFile.writeAsBytes(cropped);

              final textRecognizer =
                  TextRecognizer(script: TextRecognitionScript.latin);
              final inputImage = InputImage.fromFile(croppedFile);
              final recognizedText =
                  await textRecognizer.processImage(inputImage);
              await textRecognizer.close();

              final extracted = recognizedText.text;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchVehicle(
                    imageFile: widget.imageFile,
                    vehicleRegistration: extracted,
                  ),
                ),
              );
            },
            initialSize: 0.8,
            maskColor: Colors.black.withOpacity(0.5),
            cornerDotBuilder: (size, edgeAlignment) =>
                DotControl(color: Colors.cyanAccent),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Scan Code",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomOutlineButton(
                    title: 'Retake',
                    prefixIcon: Icons.refresh,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                CustomGradientButton(
                    width: 160,
                    title: 'Proceed',
                    suffixIcon: Icons.arrow_right_alt_sharp,
                    onPressed: () {
                      // setState(() => _isCropping = true);
                      _cropController.crop();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
