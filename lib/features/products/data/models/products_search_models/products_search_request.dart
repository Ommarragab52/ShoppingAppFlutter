class ProductsSearchRequest {
  final String text;

  ProductsSearchRequest({required this.text});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'text': text};
  }
}
