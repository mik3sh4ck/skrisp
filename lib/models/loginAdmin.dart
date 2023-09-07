class LoginAdmin {
  int status;
  String message;
  Data data;

  LoginAdmin({
    required this.status,
    required this.message,
    required this.data,
  });
}

class Data {
  String idUser;

  Data({
    required this.idUser,
  });
}
