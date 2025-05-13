import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MaterialApp(
    home: ScanNumberScreen(camera: cameras.first),
    debugShowCheckedModeBanner: false,
  ));
}

class ScanNumberScreen extends StatefulWidget {
  final CameraDescription camera;
  const ScanNumberScreen({Key? key, required this.camera}) : super(key: key);

  @override
  State<ScanNumberScreen> createState() => _ScanNumberScreenState();
}

class _ScanNumberScreenState extends State<ScanNumberScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  double top = 200, left = 50, width = 300, height = 120;
  double minWidth = 100, minHeight = 50;

  final TextEditingController _textController = TextEditingController();
  final TextRecognizer _textRecognizer =
  TextRecognizer(script: TextRecognitionScript.latin);

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textRecognizer.close();
    _textController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      left = max(0, left + details.delta.dx);
      top = max(0, top + details.delta.dy);
    });
  }

  void _onResize(DragUpdateDetails details, Alignment alignment) {
    setState(() {
      if (alignment == Alignment.topLeft) {
        double newLeft = left + details.delta.dx;
        double newTop = top + details.delta.dy;
        double newWidth = width - details.delta.dx;
        double newHeight = height - details.delta.dy;
        if (newWidth > minWidth && newHeight > minHeight) {
          left = newLeft;
          top = newTop;
          width = newWidth;
          height = newHeight;
        }
      } else if (alignment == Alignment.topRight) {
        double newTop = top + details.delta.dy;
        double newWidth = width + details.delta.dx;
        double newHeight = height - details.delta.dy;
        if (newWidth > minWidth && newHeight > minHeight) {
          top = newTop;
          width = newWidth;
          height = newHeight;
        }
      } else if (alignment == Alignment.bottomLeft) {
        double newLeft = left + details.delta.dx;
        double newWidth = width - details.delta.dx;
        double newHeight = height + details.delta.dy;
        if (newWidth > minWidth && newHeight > minHeight) {
          left = newLeft;
          width = newWidth;
          height = newHeight;
        }
      } else if (alignment == Alignment.bottomRight) {
        double newWidth = width + details.delta.dx;
        double newHeight = height + details.delta.dy;
        if (newWidth > minWidth && newHeight > minHeight) {
          width = newWidth;
          height = newHeight;
        }
      }
    });
  }

  Future<void> _captureCropAndRecognizeText() async {
    try {
      await _initializeControllerFuture;
      final XFile file = await _controller.takePicture();
      final bytes = await file.readAsBytes();

      img.Image? capturedImage = img.decodeImage(bytes);
      if (capturedImage == null) return;

      final previewSize = _controller.value.previewSize!;
      double scaleX = capturedImage.width / previewSize.height;
      double scaleY = capturedImage.height / previewSize.width;

      int cropLeft = (top * scaleX).toInt();
      int cropTop = (left * scaleY).toInt();
      int cropWidth = (height * scaleX).toInt();
      int cropHeight = (width * scaleY).toInt();

      cropWidth = min(cropWidth, capturedImage.width - cropLeft);
      cropHeight = min(cropHeight, capturedImage.height - cropTop);

      img.Image croppedImage = img.copyCrop(
        capturedImage,
        x: cropLeft,
        y: cropTop,
        width: cropWidth,
        height: cropHeight,
      );

      final directory = await getTemporaryDirectory();
      final croppedPath = '${directory.path}/cropped_plate.png';
      final croppedFile = File(croppedPath);
      await croppedFile.writeAsBytes(img.encodePng(croppedImage));

      final recognizedText = await _performTextRecognition(croppedFile);

      if (mounted) {
        setState(() {
          _textController.text = recognizedText;
        });
      }

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Cropped Number Plate'),
          content: Image.file(croppedFile),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            )
          ],
        ),
      );
    } catch (e) {
      print('Error capturing or recognizing text: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to capture or recognize text')),
      );
    }
  }

  Future<String> _performTextRecognition(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText =
    await _textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }

  Widget _buildResizableRect() {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onPanUpdate: _onPanUpdate,
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.cyan, width: 3),
                color: Colors.transparent,
              ),
            ),
            ...[
              Alignment.topLeft,
              Alignment.topRight,
              Alignment.bottomLeft,
              Alignment.bottomRight,
            ].map((alignment) {
              double x = alignment.x == -1 ? 0 : width - 16;
              double y = alignment.y == -1 ? 0 : height - 16;
              return Positioned(
                left: x,
                top: y,
                child: GestureDetector(
                  onPanUpdate: (details) => _onResize(details, alignment),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.cyan, width: 2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Stack(
                      children: [
                        CameraPreview(_controller),
                        Container(color: Colors.black.withOpacity(0.4)),
                        _buildResizableRect(),
                        Positioned(
                          top: 16,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              'Scan Number',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: FloatingActionButton(
                              onPressed: _captureCropAndRecognizeText,
                              backgroundColor: Colors.green,
                              child: Icon(Icons.camera_alt, size: 32),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error initializing camera',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey[900],
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Recognized Number Plate',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
