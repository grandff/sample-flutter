/* guide */
class GuideListModel {
  final List<GuideItemModel> guideList;

  GuideListModel({
    required this.guideList,
  });

  factory GuideListModel.fromJson(Map<String, dynamic> json) {
    var list = json['guide'] as List;
    List<GuideItemModel> itemList =
        list.map((i) => GuideItemModel.fromJson(i)).toList();
    return GuideListModel(guideList: itemList);
  }
}

class GuideItemModel {
  final num pointIndex, type, distance, duration;
  final String instructions;

  GuideItemModel.fromJson(Map<String, dynamic> json)
      : pointIndex = json['pointIndex'],
        type = json['type'],
        distance = json['distance'],
        duration = json['duration'],
        instructions = json['instructions'];
}
/* // guide */
/* section */
/* // section */