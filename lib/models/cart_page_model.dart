class CartPageTestModel {
  String imageSrc;
  String path;
  CartPageTestModel.fromJson(Map<String, dynamic> json) {
    imageSrc = json['imageSrc'];
    path = json['path'];
  }
}