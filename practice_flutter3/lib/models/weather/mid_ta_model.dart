class MidTaModel {
  final MidTaBodyModel response;
  MidTaModel.fromJson(Map<String, dynamic> json)
      : response = MidTaBodyModel.fromJson(json['response']);
}

class MidTaBodyModel {
  final MidTaResponseModel body;

  MidTaBodyModel.fromJson(Map<String, dynamic> json)
      : body = MidTaResponseModel.fromJson(json['body']);
}

class MidTaResponseModel {
  final String dataType;
  final MidTaItemsModel items;

  MidTaResponseModel.fromJson(Map<String, dynamic> json)
      : dataType = json['dataType'],
        items = MidTaItemsModel.fromJson(json['items']);
}

class MidTaItemsModel {
  final List<MidTaItemModel> item;

  MidTaItemsModel({
    required this.item,
  });

  factory MidTaItemsModel.fromJson(Map<String, dynamic> json) {
    var list = json['item'] as List;
    List<MidTaItemModel> itemList =
        list.map((e) => MidTaItemModel.fromJson(e)).toList();
    return MidTaItemsModel(item: itemList);
  }
}

class MidTaItemModel {
  final String regId;
  final num taMin3,
      taMin3Low,
      taMin3High,
      taMax3,
      taMax3Low,
      taMax3High,
      taMin4,
      taMin4Low,
      taMin4High,
      taMax4,
      taMax4Low,
      taMax4High,
      taMin5,
      taMin5Low,
      taMin5High,
      taMax5,
      taMax5Low,
      taMax5High,
      taMin6,
      taMin6Low,
      taMin6High,
      taMax6,
      taMax6Low,
      taMax6High,
      taMin7,
      taMin7Low,
      taMin7High,
      taMax7,
      taMax7Low,
      taMax7High;
  MidTaItemModel.fromJson(Map<String, dynamic> json)
      : regId = json['regId'],
        taMin3 = json['taMin3'],
        taMin3Low = json['taMin3Low'],
        taMin3High = json['taMin3High'],
        taMax3 = json['taMax3'],
        taMax3Low = json['taMax3Low'],
        taMax3High = json['taMax3High'],
        taMin4 = json['taMin4'],
        taMin4Low = json['taMin4Low'],
        taMin4High = json['taMin4High'],
        taMax4 = json['taMax4'],
        taMax4Low = json['taMax4Low'],
        taMax4High = json['taMax4High'],
        taMin5 = json['taMin5'],
        taMin5Low = json['taMin5Low'],
        taMin5High = json['taMin5High'],
        taMax5 = json['taMax5'],
        taMax5Low = json['taMax5Low'],
        taMax5High = json['taMax5High'],
        taMin6 = json['taMin6'],
        taMin6Low = json['taMin6Low'],
        taMin6High = json['taMin6High'],
        taMax6 = json['taMax6'],
        taMax6Low = json['taMax6Low'],
        taMax6High = json['taMax6High'],
        taMin7 = json['taMin7'],
        taMin7Low = json['taMin7Low'],
        taMin7High = json['taMin7High'],
        taMax7 = json['taMax7'],
        taMax7Low = json['taMax7Low'],
        taMax7High = json['taMax7High'];
}
