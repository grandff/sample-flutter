class MidFcstModel {
  final MidFcstBodyModel response;
  MidFcstModel.fromJson(Map<String, dynamic> json)
      : response = MidFcstBodyModel.fromJson(json['response']);
}

class MidFcstBodyModel {
  final MidFcstResponseModel body;

  MidFcstBodyModel.fromJson(Map<String, dynamic> json)
      : body = MidFcstResponseModel.fromJson(json['body']);
}

class MidFcstResponseModel {
  final String dataType;
  final MidFcstItemsModel items;

  MidFcstResponseModel.fromJson(Map<String, dynamic> json)
      : dataType = json['dataType'],
        items = MidFcstItemsModel.fromJson(json['items']);
}

class MidFcstItemsModel {
  final List<MidFcstItemModel> item;

  MidFcstItemsModel({
    required this.item,
  });

  factory MidFcstItemsModel.fromJson(Map<String, dynamic> json) {
    var list = json['item'] as List;
    List<MidFcstItemModel> itemList =
        list.map((e) => MidFcstItemModel.fromJson(e)).toList();
    return MidFcstItemsModel(item: itemList);
  }
}

class MidFcstItemModel {
  final String regId,
      wf3Am,
      wf3Pm,
      wf4Am,
      wf4Pm,
      wf5Am,
      wf5Pm,
      wf6Am,
      wf6Pm,
      wf7Am,
      wf7Pm;
  final int rnSt3Am,
      rnSt3Pm,
      rnSt4Am,
      rnSt4Pm,
      rnSt5Am,
      rnSt5Pm,
      rnSt6Am,
      rnSt6Pm,
      rnSt7Am,
      rnSt7Pm;
  MidFcstItemModel.fromJson(Map<String, dynamic> json)
      : regId = json['regId'],
        wf3Am = json['wf3Am'],
        wf3Pm = json['wf3Pm'],
        wf4Am = json['wf4Am'],
        wf4Pm = json['wf4Pm'],
        wf5Am = json['wf5Am'],
        wf5Pm = json['wf5Pm'],
        wf6Am = json['wf6Am'],
        wf6Pm = json['wf6Pm'],
        wf7Am = json['wf7Am'],
        wf7Pm = json['wf7Pm'],
        rnSt3Am = json['rnSt3Am'],
        rnSt3Pm = json['rnSt3Pm'],
        rnSt4Am = json['rnSt4Am'],
        rnSt4Pm = json['rnSt4Pm'],
        rnSt5Am = json['rnSt5Am'],
        rnSt5Pm = json['rnSt5Pm'],
        rnSt6Am = json['rnSt6Am'],
        rnSt6Pm = json['rnSt6Pm'],
        rnSt7Am = json['rnSt7Am'],
        rnSt7Pm = json['rnSt7Pm'];
}
