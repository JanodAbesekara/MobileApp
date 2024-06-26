class LectureMaterial{
  String? lessonName;
  String? pdfPath;
  Uri? zoomLink;
  Uri? lectureRecording;

  LectureMaterial.fromJson(Map<String,dynamic> json){
  lessonName=  json['lesson'];
  pdfPath=  json['PDF'];
   zoomLink= Uri.tryParse(json['zoom']
   
   
   );
   lectureRecording = Uri.tryParse(json['video']);

  }

}