import 'package:file_picker/file_picker.dart';
import 'dart:io'; 

/// Utility function to pick a file.
/// Returns a map containing:
/// - 'file': The selected file as a `File` object
/// - 'fileName': The name of the selected file
/// Returns null if the user cancels the picker.
Future<Map<String, dynamic>?> pickFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'], 
  );

  if (result != null && result.files.single.path != null) {
    return {
      'file': File(result.files.single.path!), 
      'fileName': result.files.single.name,    
    };
  } else {
    return null;
  }
}