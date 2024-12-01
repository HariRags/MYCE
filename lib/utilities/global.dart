class Globals {
  static final Globals _instance = Globals._internal();

  factory Globals() {
    return _instance;
  }

  Globals._internal();


  String name = '';
  String email = '';
  String phoneNumber = '';
  String address = '';
  String accessToken = '';
  String refreshToken = '';
  String location = '';
}

final globals = Globals(); 
