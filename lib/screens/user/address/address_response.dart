class AddressResponse {
    AddressResponse({
        required this.headingTitle,
        required this.textAddressBook,
        required this.textEmpty,
        required this.buttonNewAddress,
        required this.buttonEdit,
        required this.buttonDelete,
        required this.buttonBack,
        required this.errorWarning,
        required this.success,
        required this.addresses,
    });

    final String? headingTitle;
    final String? textAddressBook;
    final String? textEmpty;
    final String? buttonNewAddress;
    final String? buttonEdit;
    final String? buttonDelete;
    final String? buttonBack;
    final String? errorWarning;
    final String? success;
    final List<Address> addresses;

    factory AddressResponse.fromMap(Map<String, dynamic> json){ 
        return AddressResponse(
            headingTitle: json["heading_title"],
            textAddressBook: json["text_address_book"],
            textEmpty: json["text_empty"],
            buttonNewAddress: json["button_new_address"],
            buttonEdit: json["button_edit"],
            buttonDelete: json["button_delete"],
            buttonBack: json["button_back"],
            errorWarning: json["error_warning"],
            success: json["success"],
            addresses: json["addresses"] == null ? [] : List<Address>.from(json["addresses"]!.map((x) => Address.fromMap(x))),
        );
    }

}

class Address {
    Address({
        required this.addressId,
        required this.firstname,
        required this.lastname,
        required this.company,
        required this.address1,
        required this.address2,
        required this.phone,
        required this.main,
        required this.postcode,
        required this.cityId,
        required this.lat,
        required this.lng,
        required this.city,
        required this.zoneId,
        required this.zone,
        required this.zoneCode,
        required this.kel,
        required this.kelId,
        required this.countryId,
        required this.country,
        required this.isoCode2,
        required this.isoCode3,
        required this.addressFormat,
        required this.defaultAddress,
        required this.customField,
    });

    final String? addressId;
    final String? firstname;
    final String? lastname;
    final String? company;
    final String? address1;
    final String? address2;
    final String? phone;
    final String? main;
    final String? postcode;
    final String? cityId;
    final String? lat;
    final String? lng;
    final String? city;
    final String? zoneId;
    final String? zone;
    final String? zoneCode;
    final String? kel;
    final String? kelId;
    final String? countryId;
    final String? country;
    final String? isoCode2;
    final String? isoCode3;
    final String? addressFormat;
    final bool? defaultAddress;
    final dynamic customField;

    String get detail => "${address1 ?? ""}${kel != null ? ", $kel" : ""}${city != null ? ", $city" : ""}${zone != null ? ", $zone" : ""}${country != null ? ", $country" : ""}${postcode != null ? ", $postcode" : ""}";

    factory Address.fromMap(Map<String, dynamic> json){ 
        return Address(
            addressId: json["address_id"],
            firstname: json["firstname"],
            lastname: json["lastname"],
            company: json["company"],
            address1: json["address_1"],
            address2: json["address_2"],
            phone: json["phone"],
            main: json["main"],
            postcode: json["postcode"],
            cityId: json["city_id"],
            lat: json["lat"],
            lng: json["lng"],
            city: json["city"],
            zoneId: json["zone_id"],
            zone: json["zone"],
            zoneCode: json["zone_code"],
            kel: json["kel"],
            kelId: json["kel_id"],
            countryId: json["country_id"],
            country: json["country"],
            isoCode2: json["iso_code_2"],
            isoCode3: json["iso_code_3"],
            addressFormat: json["address_format"],
            defaultAddress: json['default'],
            customField: json["custom_field"],
        );
    }

}