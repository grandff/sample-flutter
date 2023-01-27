class WrnModel {
  final WrnBodyModel response;
  WrnModel.fromJson(Map<String, dynamic> json)
      : response = WrnBodyModel.fromJson(json['response']);
}

class WrnBodyModel {
  final WrnResponseModel body;

  WrnBodyModel.fromJson(Map<String, dynamic> json)
      : body = WrnResponseModel.fromJson(json['body']);
}

class WrnResponseModel {
  final String dataType;
  final WrnItemsModel items;

  WrnResponseModel.fromJson(Map<String, dynamic> json)
      : dataType = json['dataType'],
        items = WrnItemsModel.fromJson(json['items']);
}

class WrnItemsModel {
  final List<WrnItemModel> item;

  WrnItemsModel({
    required this.item,
  });

  factory WrnItemsModel.fromJson(Map<String, dynamic> json) {
    var list = json['item'] as List;
    List<WrnItemModel> itemList =
        list.map((e) => WrnItemModel.fromJson(e)).toList();
    return WrnItemsModel(item: itemList);
  }
}

class WrnItemModel {
  final String other, t6, t7, tmEf;
  final num tmFc, tmSeq;
  WrnItemModel.fromJson(Map<String, dynamic> json)
      : other = json['other'],
        t6 = json['t6'],
        t7 = json['t7'],
        tmEf = json['tmEf'],
        tmFc = json['tmFc'],
        tmSeq = json['tmSeq'];
}
