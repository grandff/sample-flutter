class RegionFullModel {
  final RegionMetaModel meta;
  final RegionDocumentModel documents;

  RegionFullModel.fromJson(Map<String, dynamic> json)
      : meta = json['meta'],
        documents = json['documents'];
}

class RegionDocumentModel {
  final List<RegionCodeModel> documents;
  RegionDocumentModel({required this.documents});

  factory RegionDocumentModel.fromJson(Map<String, dynamic> json) {
    var list = json as List;
    List<RegionCodeModel> itemList =
        list.map((e) => RegionCodeModel.fromJson(e)).toList();
    return RegionDocumentModel(documents: itemList);
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

class RegionMetaModel {
  final num totalCount;

  RegionMetaModel.fromJson(Map<String, dynamic> json)
      : totalCount = json['total_count'];
}
