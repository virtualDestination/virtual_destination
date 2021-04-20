
//No need to implement this
class Cities {
  List<City> cities;
  Cities({this.cities});

  factory Cities.fromJSON(List<dynamic> json) {
    List<City> cityList;
    cityList = json.map((e) => City.fromJson(e)).toList();
    return Cities(cities: cityList);
  }
}

class City {
  String country;
  List<String> cities;

  City({this.country, this.cities});

  City.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    cities = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['cities'] = this.cities;
    return data;
  }
}
