class FcstModel {
  final FcstBodyModel response;
  FcstModel.fromJson(Map<String, dynamic> json)
      : response = FcstBodyModel.fromJson(json['response']);
}

class FcstBodyModel {
  final FcstResponseModel body;

  FcstBodyModel.fromJson(Map<String, dynamic> json)
      : body = FcstResponseModel.fromJson(json['body']);
}

class FcstResponseModel {
  final String dataType;
  final FcstItemsModel items;

  FcstResponseModel.fromJson(Map<String, dynamic> json)
      : dataType = json['dataType'],
        items = FcstItemsModel.fromJson(json['items']);
}

class FcstItemsModel {
  // json list parsing
  final List<FcstItemModel> item;

  FcstItemsModel({required this.item});

  factory FcstItemsModel.fromJson(Map<String, dynamic> json) {
    var list = json['item'] as List;
    List<FcstItemModel> itemList =
        list.map((i) => FcstItemModel.fromJson(i)).toList();
    return FcstItemsModel(item: itemList);
  }
}

class FcstItemModel {
  final String baseDate, baseTime, category, fcstDate, fcstTime, fcstValue;
  final int nx, ny;

  FcstItemModel.fromJson(Map<String, dynamic> json)
      : baseDate = json['baseDate'],
        baseTime = json['baseTime'],
        category = json['category'],
        fcstDate = json['fcstDate'],
        fcstTime = json['fcstTime'],
        fcstValue = json['fcstValue'],
        nx = json['nx'],
        ny = json['ny'];
}
