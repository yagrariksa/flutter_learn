class MyResponse<T> {
  T? body;
  bool success;
  int responseCode;

  MyResponse(this.body, this.success, this.responseCode);

  String responseMessage() {
    switch (responseCode) {
      case 200:
        return "OK";
        break;
      case 201:
        return "Success Create";
        break;
      default:
        return "Something Wrong";
    }
  }
}
