class MyResponse<T> {
  T? body;
  bool success;
  int _responseCode;

  MyResponse(this.body, this.success, this._responseCode);

  String responseMessage() {
    switch (_responseCode) {
      case 200:
        return "Connection Success";
        break;
      default:
        return "Something Wrong";
    }
  }
}
