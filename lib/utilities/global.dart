import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

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
}

final globals = Globals();
