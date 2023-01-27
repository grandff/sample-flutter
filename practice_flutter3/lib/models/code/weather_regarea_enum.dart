enum WeatherRegareaEnum {
  regArea1('서울', '11B00000'),
  regArea2('인천', '11B00000'),
  regArea3('경기도', '11B00000'),
  regArea4('강원도', '11D10000'),
  regArea5('대전', '11C20000'),
  regArea6('세종', '11C20000'),
  regArea7('충청남도', '11C20000'),
  regArea8('충청북도', '11C10000'),
  regArea9('광주', '11F20000'),
  regArea10('전라남도', '11F20000'),
  regArea11('전라북도', '11F10000'),
  regArea12('대구', '11H10000'),
  regArea13('경상북도', '11H10000'),
  regArea14('부산', '11H20000'),
  regArea15('울산', '11H20000'),
  regArea16('경상남도', '11H20000'),
  regArea17('제주도', '11G00000');

  const WeatherRegareaEnum(this.area, this.code);
  final String area, code;

  // get by area
  factory WeatherRegareaEnum.getByArea(String area) {
    return WeatherRegareaEnum.values.firstWhere(
        (element) => area.contains(element.area),
        orElse: () => WeatherRegareaEnum.regArea1);
  }
}
