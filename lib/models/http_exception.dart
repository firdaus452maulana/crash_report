class HttpException implements Exception {

  final String message;

  HttpException(this.message);

  @override
  String toString(){
    // Mengubah menjadi string
    return message;
  }


}