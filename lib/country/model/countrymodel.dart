class CountryModel {
  late Name name;
  late Flags flags;
  late String region, subregion;
  late dynamic area;
  late List capital = [];
  late dynamic population;

  CountryModel(
      {required this.name,
      required this.flags,
      required this.region,
      required this.area,
      required this.subregion,
      required this.capital,
      required this.population});

  factory CountryModel.fromJson(Map m1) {
    return CountryModel(
      name: Name.fromJson(m1['name']),
      flags: Flags.fromJson(m1['flags']),
      region: m1['region'] ?? 'hello',
      area: m1['area'] ?? 4529,
      subregion: m1['subregion'] ?? 'Caribbean',
      capital: m1['capital'] ?? ['No have any Capital'],
      population: m1['population'] ?? 10
    );
  }
}

class Name {
  late String common, official;

  Name({required this.common, required this.official});

  factory Name.fromJson(Map m1) {
    return Name(common: m1['common'], official: m1['official']);
  }
}

class Flags {
  late String png;

  Flags({required this.png});

  factory Flags.fromJson(Map m1) {
    return Flags(png: m1['png']);
  }
}