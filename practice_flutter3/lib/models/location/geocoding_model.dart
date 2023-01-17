class RegionFullModel {
  final List<RegionCodeModel> documents;
  RegionFullModel({required this.documents});

  factory RegionFullModel.fromJson(Map<String, dynamic> json) {
    var list = json['documents'] as List;
    List<RegionCodeModel> itemList =
        list.map((e) => RegionCodeModel.fromJson(e)).toList();
    return RegionFullModel(documents: itemList);
  }
}

class RegionCodeModel {
  final String regionType,
      addressName,
      region1depthName,
      region2depthName,
      region3depthName,
      region4depthName,
      code;
  final num x, y;

  RegionCodeModel.fromJson(Map<String, dynamic> json)
      : regionType = json['region_type'],
        addressName = json['address_name'],
        region1depthName = json['region_1depth_name'],
        region2depthName = json['region_2depth_name'],
        region3depthName = json['region_3depth_name'],
        region4depthName = json['region_4depth_name'],
        code = json['code'],
        x = json['x'],
        y = json['y'];
}
