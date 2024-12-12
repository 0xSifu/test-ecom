
class AddressRequest {
  final String fullname;
  final String cityId;
  final String phone;
  final String postcode;
  final String zoneId;
  final String countryId;
  final String kelId;
  final String? address2;
  final String address1;
  final String defaultStr;
  final String? addressId;
  final String? geoCode;
  AddressRequest({
    required this.fullname,
    required this.cityId,
    required this.phone,
    required this.postcode,
    required this.zoneId,
    required this.countryId,
    required this.kelId,
    required this.address2,
    required this.address1,
    required this.defaultStr,
    required this.addressId,
    required this.geoCode,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'city_id': cityId,
      'phone': phone,
      'postcode': postcode,
      'zone_id': zoneId,
      'country_id': countryId,
      'kel_id': kelId,
      'address_2': address2,
      'address_1': address1,
      'default': defaultStr,
      'address_id': addressId,
      'geoCode': geoCode,
    };
  }
}
