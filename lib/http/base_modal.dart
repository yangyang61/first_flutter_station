class BaseModal<T> {
  T? data;
  int? errorCode;
  String? errorMsg;

  BaseModal.fromJson(dynamic json) {
    data = json["data"];
    errorCode = json["errorCode"];
    errorMsg = json["errorMsg"];

  }
}