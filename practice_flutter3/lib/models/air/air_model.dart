class AirFullModel {
  final AirBodyModel response;
  AirFullModel.fromJson(Map<String, dynamic> json)
      : response = AirBodyModel.fromJson(json['response']);
}

class AirBodyModel {
  final AirListModel body;
  AirBodyModel.fromJson(Map<String, dynamic> json)
      : body = AirListModel.fromJson(json['body']);
}

class AirListModel {
  final List<AirModel> items;
  AirListModel({required this.items});

  factory AirListModel.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<AirModel> items = list.map((e) => AirModel.fromJson(e)).toList();
    return AirListModel(items: items);
  }
}

class AirModel {
  final String dataTime, stationName, pm10Value, pm25Value, pm10Flag, pm25Flag;

  AirModel.fromJson(Map<String, dynamic> json)
      : dataTime = json['dataTime'] ?? "",
        stationName = json['stationName'],
        pm10Value = json['pm10Value'] ?? "",
        pm25Value = json['pm25Value'] ?? "",
        pm10Flag = json['pm10Flag'] ?? "",
        pm25Flag = json['pm25Flag'] ?? "";
}
