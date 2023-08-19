class ResLocalList<T> {
  List<Map<String, dynamic>> data;
  T Function(Map<String, dynamic> json) fromJsonModel;
  ResLocalList({required this.data, required this.fromJsonModel});
}

class ResLocalOne<T> {
  Map<String, dynamic> data;
  T Function(Map<String, dynamic> json) fromJsonModel;
  ResLocalOne({required this.data, required this.fromJsonModel});
}

List<T> parseLocalList<T>(ResLocalList<T> responseBody) {
  return List<T>.from(responseBody.data
      .map((itemsJson) => responseBody.fromJsonModel(itemsJson)));
}

T parseLocalOne<T>(ResLocalOne<T> responseBody) {
  return responseBody.fromJsonModel(responseBody.data);
}
