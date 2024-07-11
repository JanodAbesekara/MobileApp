import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class OnlinePdfView extends StatefulWidget {
  final String pdfLink;
  const OnlinePdfView({required this.pdfLink, super.key});

  @override
  State<OnlinePdfView> createState() => _OnlinePdfViewState();
}

class _OnlinePdfViewState extends State<OnlinePdfView> {
  String? firebasePdfDownloadebleUrl;
  File? docFile;

  Future<void> _getFirebasePdfFile() async {
    if (widget.pdfLink.isEmpty) {
      return;
    }

    docFile = await DefaultCacheManager().getSingleFile(widget.pdfLink);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getFirebasePdfFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecture Note'),
        backgroundColor: Colors.blue,
      ),
      body: widget.pdfLink.isEmpty
          ? Center(
              child: Text(
                'No PDF link in this lecture.',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            )
          : docFile == null
              ? const Center(child: CircularProgressIndicator())
              : PdfView(
                  path: docFile!.path,
                ),
    );
  }
}
