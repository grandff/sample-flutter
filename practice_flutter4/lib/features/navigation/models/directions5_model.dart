/* response body */
class NavigationResponse {
  final int code;
  final String message;
  final String currentDateTime;
  final RouteModel route;

  NavigationResponse({
    required this.code,
    required this.message,
    required this.currentDateTime,
    required this.route,
  });

  factory NavigationResponse.fromJson(Map<String, dynamic> json) {
    return NavigationResponse(
      code: json['code'],
      message: json['message'],
      currentDateTime: json['currentDateTime'],
      route: RouteModel.fromJson(json['route']),
    );
  }
}
/* // response body */

/* route */
class RouteModel {
  final List<TraFastModel> traFast;

  RouteModel({
    required this.traFast,
  });

  RouteModel.fromJson(Map<String, dynamic> json)
      : traFast = (json['trafast'] as List<dynamic>)
            .map((item) => TraFastModel.fromJson(item))
            .toList();
}
/* // route */

/* trafast */
class TraFastModel {
  final SummaryModel summary;
  final List<List<double>> path;
  final List<GuideItemModel> guide;
  final List<SectionItemModel> section;

  TraFastModel({
    required this.summary,
    required this.path,
    required this.guide,
    required this.section,
  });

  factory TraFastModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> pathList = json['path'];
    final List<List<double>> path = [];
    for (var i = 0; i < pathList.length; i++) {
      path.add(List<double>.from(pathList[i]));
    }

    final List<dynamic> sectionList = json['section'];
    final List<SectionItemModel> section = [];
    for (var i = 0; i < sectionList.length; i++) {
      section.add(SectionItemModel.fromJson(sectionList[i]));
    }

    final List<dynamic> guideList = json['guide'];
    final List<GuideItemModel> guide = [];
    for (var i = 0; i < guideList.length; i++) {
      guide.add(GuideItemModel.fromJson(guideList[i]));
    }

    return TraFastModel(
      summary: SummaryModel.fromJson(json['summary']),
      path: path,
      section: section,
      guide: guide,
    );
  }
}
/* // trafast */

/* guide */
/*class GuideListModel {
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
}*/

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
/*class SectionListModel {
  final List<SectionItemModel> sectionList;

  SectionListModel({
    required this.sectionList,
  });

  factory SectionListModel.fromJson(Map<String, dynamic> json) {
    var list = json['section'] as List;
    List<SectionItemModel> itemList =
        list.map((i) => SectionItemModel.fromJson(i)).toList();
    return SectionListModel(sectionList: itemList);
  }
}*/

class SectionItemModel {
  final num pointIndex, pointCount, distance, congestion, speed;
  final String name;

  SectionItemModel.fromJson(Map<String, dynamic> json)
      : pointIndex = json['pointIndex'],
        pointCount = json['pointCount'],
        distance = json['distance'],
        congestion = json['congestion'],
        speed = json['speed'],
        name = json['name'];
}
/* // section */

/* summary */
class SummaryModel {
  final Map<String, dynamic> start, goal;
  final int distance, duration, tollFare, taxiFare, fuelPrice;
  final List<List<double>> bbox;

  SummaryModel({
    required this.start,
    required this.goal,
    required this.distance,
    required this.duration,
    required this.bbox,
    required this.tollFare,
    required this.taxiFare,
    required this.fuelPrice,
  });

  SummaryModel.fromJson(Map<String, dynamic> json)
      : start = json['start'],
        goal = json['goal'],
        distance = json['distance'],
        duration = json['duration'],
        bbox = (json['bbox'] as List<dynamic>)
            .map((item) => List<double>.from(item))
            .toList(),
        tollFare = json['tollFare'],
        taxiFare = json['taxiFare'],
        fuelPrice = json['fuelPrice'];
}
/* // summary */