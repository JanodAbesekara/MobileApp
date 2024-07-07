
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future _getFirebasePdfFile()async{
    final url=  await FirebaseStorage.instance
  .ref()
  .child("pdfs/1717562343672214002D.pdf")
  .getDownloadURL();

firebasePdfDownloadebleUrl=url;
 docFile = await DefaultCacheManager().getSingleFile(firebasePdfDownloadebleUrl!);
setState(() {
  
});


  
  }

  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_)async{
   await _getFirebasePdfFile();
  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecture Note'),
      ),

      body:
      firebasePdfDownloadebleUrl==null? const Center(child: CircularProgressIndicator(),):
      
       PdfView(
       path: docFile!.path
      ),
    );
  }
}