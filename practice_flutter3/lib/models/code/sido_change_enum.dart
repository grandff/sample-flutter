enum SidoData {
  seoul("서울특별시", "서울"),
  busan("부산광역시", "부산"),
  deagu("대구광역시", "대구"),
  inchen("인천광역시", "인천"),
  gwangju("광주광역시", "광주"),
  daejeon("대전광역시", "대전"),
  ulsan("울산광역시", "울산"),
  sejong("세종특별자치시", "세종"),
  gyonggi("경기도", "경기"),
  gangwon("강원도", "강원"),
  chungbuk("충청북도", "충북"),
  chungnam("충청남도", "충남"),
  jeonbuk("전라북도", "전북"),
  jeonnam("전라남도", "전남"),
  gyeongbuk("경상북도", "경북"),
  gyeongnam("경상남도", "경남"),
  jeju("제주특별자치도", "제주"),
  all("전국", "전국");

  const SidoData(this.area, this.simpleArea);
  final String area, simpleArea;

  // get by area
  factory SidoData.getByArea(String area) {
    return SidoData.values.firstWhere((element) => element.area == area,
        orElse: () => SidoData.all);
  }
}
