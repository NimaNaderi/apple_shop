class VariantType {
  String? id;
  String? name;
  String? title;
  VariantTypeEnum? type;

  VariantType(this.id, this.name, this.title, this.type);

  factory VariantType.fromJson(Map<String, dynamic> jsonObject) {
    return VariantType(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['title'],
      _getVariantTypeEnum(jsonObject['type']),
    );
  }
}

VariantTypeEnum _getVariantTypeEnum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.COLOR;
    case 'Storage':
      return VariantTypeEnum.STORAGTE;
    case 'Voltage':
      return VariantTypeEnum.VOLTAGE;
    default:
      return VariantTypeEnum.COLOR;
  }
}

enum VariantTypeEnum { COLOR, STORAGTE, VOLTAGE }
