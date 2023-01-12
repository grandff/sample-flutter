enum LocationData {
  seoul("서울특별시", 60, 127),
  busan("부산광역시", 98, 76),
  deagu("대구광역시", 89, 90),
  inchen("인천광역시", 55, 124),
  gwangju("광주광역시", 58, 74),
  daejeon("대전광역시", 67, 100),
  ulsan("울산광역시", 102, 84),
  sejong("세종특별자치시", 66, 103),
  gyonggi("경기도", 60, 120),
  gangwon("강원도", 73, 134),
  chungbuk("충청북도", 69, 107),
  chungnam("충청남도", 68, 100),
  jeonbuk("전라북도", 63, 89),
  jeonnam("전라남도", 51, 67),
  gyeongbuk("경상북도", 89, 91),
  gyeongnam("경상남도", 91, 77),
  jeju("제주특별자치도", 52, 38),
  undefined(
    "undefined",
    0,
    0,
  );

  const LocationData(this.area, this.nx, this.ny);
  final String area;
  final int nx;
  final int ny;

  // get by area
  factory LocationData.getByArea(String area) {
    return LocationData.values.firstWhere((element) => element.area == area,
        orElse: () => LocationData.undefined);
  }
}
