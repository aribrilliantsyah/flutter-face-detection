import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tembongkeun Bengeut',
      home: const HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  File? fileImage;
  final List<dynamic> listOutputs = [];

  @override
  void initState() {
    super.initState();
    isLoading = true;
    loadModel().then((_) {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Face Detection')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    fileImage == null ? Container() : Image.file(fileImage!),
                    const SizedBox(height: 16),
                    listOutputs.isNotEmpty
                        ? Text(
                          '${listOutputs[0]['label']}'.replaceAll(
                            RegExp(r'[0-9]'),
                            '',
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            background: Paint()..color = Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        : const Text('Upload your image'),
                  ],
                ),
              ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.camera),
            tooltip: 'Take Picture From Camera',
            onPressed: () => pickImage(ImageSource.camera),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            child: const Icon(Icons.image),
            tooltip: 'Take Picture From Gallery',
            onPressed: () => pickImage(ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: 'assets/model_unquant.tflite',
        labels: 'assets/labels.txt',
      );
    } catch (e) {
      debugPrint('Error loading model: $e');
    }
  }

  Future<void> pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile == null) return;

    setState(() {
      isLoading = true;
      fileImage = File(pickedFile.path);
    });

    await processImage(fileImage!);
  }

  Future<void> processImage(File image) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      setState(() {
        isLoading = false;
        listOutputs.clear();
        if (output != null) {
          listOutputs.addAll(output);
        }
        debugPrint('outputs: $listOutputs');
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error processing image: $e');
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
