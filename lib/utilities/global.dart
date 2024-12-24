import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
class Globals {
  static final Globals _instance = Globals._internal();

  factory Globals() {
    return _instance;
  }

  Globals._internal();

  String name = '';
  String email = '';
  String phoneNumber = '';
  String accessToken = '';
  String refreshToken = '';
  File? profileImage;

  Future<void> setName(String value) async {
    name = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }

  Future<void> setEmail(String value) async {
    email = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<void> setPhoneNumber(String value) async {
    phoneNumber = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber);
  }


  Future<void> setAccessToken(String value) async {
    accessToken = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }

  Future<void> setRefreshToken(String value) async {
    refreshToken = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', refreshToken);
  }

  Future<void> setProfileImage(File? imageFile) async {
    profileImage = imageFile!;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImagePath', imageFile.path);
  }

  Future<void> loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    email = prefs.getString('email') ?? '';
    phoneNumber = prefs.getString('phoneNumber') ?? '';
 
    accessToken = prefs.getString('accessToken') ?? '';
    refreshToken = prefs.getString('refreshToken') ?? '';
    final profileImagePath = prefs.getString('profileImagePath');
    if (profileImagePath != null && profileImagePath.isNotEmpty) {
      profileImage = File(profileImagePath);
    } else {
      profileImage = null;
    }
  
  }

  Future<void> clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    name = '';
    email = '';
    phoneNumber = '';
    accessToken = '';
    refreshToken = '';
    profileImage = null;
  }
  Future<void> downloadAndSaveProfileImage(String backendImagePath) async {
    final cleanPath = backendImagePath.startsWith('/') ? backendImagePath.substring(1) : backendImagePath;
    final imageUrl = dotenv.env['SERVER_URL']! + cleanPath;
    print("hey");
    print(imageUrl);
    
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final documentsDir = await getApplicationDocumentsDirectory();
        final fileName = path.basename(cleanPath);
        final localPath = path.join(documentsDir.path, fileName);
        
        final imageFile = File(localPath);
        await imageFile.writeAsBytes(response.bodyBytes);
        
        await setProfileImage(imageFile);
      }
    } catch (e) {
      print('Error downloading profile image: $e');
    }
  }
}

final globals = Globals();
