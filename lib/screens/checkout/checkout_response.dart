import 'package:get/get.dart';
import 'package:ufo_elektronika/screens/cart/cart_response.dart';
import 'package:ufo_elektronika/screens/user/address/address_response.dart';

class CheckoutResponse {
    CheckoutResponse({
        required this.product,
        required this.packingKayuPrice,
        required this.biayaLayanan,
        required this.lokasiSession,
        required this.locClickCollect,
        required this.optLoc,
        required this.totalGaransiPrice,
        required this.totalQty,
        required this.totalAllUfoP,
        required this.reward,
        required this.totalPrice,
        required this.totalPriceNum,
        required this.paymentHead,
        required this.paymentType,
        required this.packingKayuChecked,
        required this.jenisPengirimanChecked,
        required this.tipePengirimanChecked,
        required this.address,
        required this.coupon,
        required this.modules,
        required this.totalPoints,
        required this.useCoupon,
        required this.allPrice,
        required this.stores,
        required this.countries,
        required this.totalWeight,
        required this.logged,
        required this.account,
        required this.addresses,
        required this.shippingRequired,
        required this.addressId,
        required this.methodDataPayment,
        required this.snapCc,
        required this.snapVa,
        required this.snapUangElektronik,
        required this.snapTunai,
        required this.snapCicilan,
        required this.paymentMethodHead,
        required this.kurirTokoPrice,
        required this.priceRangeKurirToko,
        required this.kurirTokoDays,
        required this.shippingMethod,
        required this.shippingMethodHead,
        required this.ekspedisi,
        required this.postcode,
        required this.countryId,
        required this.zoneId,
        required this.cityId,
        required this.kelId,
        required this.kurirTokoStatus,
        required this.zones,
        required this.cities,
        required this.kelurahan,
        required this.customFields,
        required this.shippingAddressCustomField,
        required this.customerInfo,
        required this.base,
        required this.errors,
        required this.buttonConfirm,
        required this.mixpanelKey,
        required this.merchantId,
        required this.clientKey,
        required this.environment,
        required this.textLoading,
        required this.disableMixpanel,
        required this.redirect,
        required this.processOrder,
    });

    final List<CartProduct> product;
    final double? packingKayuPrice;
    final double? biayaLayanan;
    final String? lokasiSession;
    final String? locClickCollect;
    final String? optLoc;
    final int? totalGaransiPrice;
    final int? totalQty;
    final int? totalAllUfoP;
    final int? reward;
    final String? totalPrice;
    final int? totalPriceNum;
    final String? paymentHead;
    final String? paymentType;
    final String? packingKayuChecked;
    final String? jenisPengirimanChecked;
    final String? tipePengirimanChecked;
    final String? address;
    final List<Coupon> coupon;
    final List<String> modules;
    final String? totalPoints;
    final List<CouponUsed> useCoupon;
    final List<AllPrice> allPrice;
    final List<Store> stores;
    final List<Country> countries;
    final int? totalWeight;
    final String? logged;
    final String? account;
    final Map<String, Address> addresses;
    final bool? shippingRequired;
    final int? addressId;
    final List<MethodDataPayment> methodDataPayment;
    final List<Snap> snapCc;
    final List<Snap> snapVa;
    final List<Snap> snapUangElektronik;
    final List<Snap> snapTunai;
    final List<Snap> snapCicilan;
    final Map<String, dynamic>? paymentMethodHead;
    final int? kurirTokoPrice;
    final String? priceRangeKurirToko;
    final String? kurirTokoDays;
    final List<ShippingMethod> shippingMethod;
    final Map<String, ShippingMethodHead> shippingMethodHead;
    final Map<String, dynamic> ekspedisi;
    final String? postcode;
    final String? countryId;
    final String? zoneId;
    final String? cityId;
    final String? kelId;
    final String? kurirTokoStatus;
    final List<Zone> zones;
    final List<City> cities;
    final List<Kelurahan> kelurahan;
    final List<dynamic> customFields;
    final List<dynamic> shippingAddressCustomField;
    final CustomerInfo? customerInfo;
    final String? base;
    final List<dynamic> errors;
    final String? buttonConfirm;
    final String? mixpanelKey;
    final String? merchantId;
    final String? clientKey;
    final String? environment;
    final String? textLoading;
    final String? disableMixpanel;
    final String? redirect;
    final String? processOrder;

    AllPrice? get couponPrice => allPrice.firstWhereOrNull((price) => price.code == "coupon");


    factory CheckoutResponse.fromMap(Map<String, dynamic> json){ 
        return CheckoutResponse(
            product: json["product"] == null ? [] : List<CartProduct>.from(json["product"]!.map((x) => CartProduct.fromMap(x))),
            packingKayuPrice: int.tryParse(json["packing_kayu_price"]?.toString().replaceAll(".", "").replaceAll(",", "") ?? "")?.toDouble(),
            biayaLayanan: int.tryParse(json["biaya_layanan"]?.toString().replaceAll(".", "").replaceAll(",", "") ?? "")?.toDouble(),
            lokasiSession: json["lokasi_session"],
            locClickCollect: json["loc_click_collect"],
            optLoc: json["opt_loc"],
            totalGaransiPrice: json["total_garansi_price"],
            totalQty: json["total_qty"],
            totalAllUfoP: int.tryParse(json["total_all_ufoP"]?.toString().replaceAll(".", "").replaceAll(",", "") ?? ""),
            reward: json["reward"],
            totalPrice: json["total_price"],
            totalPriceNum: json["total_price_num"],
            paymentHead: json["payment_head"],
            paymentType: json["payment_type"],
            packingKayuChecked: json["packing_kayu_checked"],
            jenisPengirimanChecked: json["jenis_pengiriman_checked"],
            tipePengirimanChecked: json["tipe_pengiriman_checked"],
            address: json["address"],
            coupon: json["coupon"] == null ? [] : List<Coupon>.from(json["coupon"]!.map((x) => Coupon.fromMap(x))),
            modules: json["modules"] == null ? [] : List<String>.from(json["modules"]!.map((x) => x)),
            totalPoints: json["total_points"]?.toString(),
            useCoupon: json["use_coupon"] == null ? [] : json['use_coupon'] is Map ? [CouponUsed.fromMap(json['use_coupon'])] : List<CouponUsed>.from(json["use_coupon"]!.map((x) => CouponUsed.fromMap(x))),
            allPrice: json["all_price"] == null ? [] : List<AllPrice>.from(json["all_price"]!.map((x) => AllPrice.fromMap(x))),
            stores: json["stores"] == null ? [] : List<Store>.from(json["stores"]!.map((x) => Store.fromMap(x))),
            countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromMap(x))),
            totalWeight: json["total_weight"],
            logged: json["logged"],
            account: json["account"],
            addresses: Map.from(json["addresses"]).map((k, v) => MapEntry<String, Address>(k, Address.fromMap(v))),
            shippingRequired: json["shipping_required"],
            addressId: int.tryParse(json["address_id"]?.toString() ?? ""),
            methodDataPayment: json["method_data_payment"] == null ? [] : List<MethodDataPayment>.from(json['method_data_payment']!.map((x) => MethodDataPayment.fromMap(x))),
            snapCc: json["snap_cc"] == null ? [] : List<Snap>.from(json["snap_cc"]!.map((x) => Snap.fromMap(x))),
            snapVa: json["snap_va"] == null ? [] : List<Snap>.from(json["snap_va"]!.map((x) => Snap.fromMap(x))),
            snapUangElektronik: json["snap_uang_elektronik"] == null ? [] : List<Snap>.from(json["snap_uang_elektronik"]!.map((x) => Snap.fromMap(x))),
            snapTunai: json["snap_tunai"] == null ? [] : List<Snap>.from(json["snap_tunai"]!.map((x) => Snap.fromMap(x))),
            snapCicilan: json["snap_cicilan"] == null ? [] : List<Snap>.from(json["snap_cicilan"]!.map((x) => Snap.fromMap(x))),
            paymentMethodHead: json["payment_method_head"] == null ? <String, dynamic>{} : Map.from(json["payment_method_head"]).map((k, v) => MapEntry<String, dynamic>(k, v)),
            kurirTokoPrice: json["kurir_toko_price"],
            priceRangeKurirToko: json["price_range_kurir_toko"],
            kurirTokoDays: json["kurir_toko_days"],
            shippingMethod: json["shipping_method"] == null ? [] : List<ShippingMethod>.from(json["shipping_method"]!.map((x) => ShippingMethod.fromMap(x))),
            shippingMethodHead: json["shipping_method_head"] == null ? {} : (json["shipping_method_head"] is List<dynamic>) ? {} : (json["shipping_method_head"] as Map<String, dynamic>).map((key, value) => MapEntry(key, ShippingMethodHead.fromMap(value))),
            ekspedisi: json["ekspedisi"] == null ? {} : (json['ekspedisi'] as Map<String, dynamic>).map((key, value) => MapEntry(key, Ekspedisi.fromMap(value))),
            postcode: json["postcode"],
            countryId: json["country_id"],
            zoneId: json["zone_id"],
            cityId: json["city_id"],
            kelId: json["kel_id"],
            kurirTokoStatus: json["kurir_toko_status"],
            zones: json["zones"] == null ? [] : List<Zone>.from(json["zones"]!.map((x) => Zone.fromMap(x))),
            cities: json["cities"] == null ? [] : List<City>.from(json["cities"]!.map((x) => City.fromMap(x))),
            kelurahan: json["kelurahan"] == null ? [] : List<Kelurahan>.from(json["kelurahan"]!.map((x) => Kelurahan.fromMap(x))),
            customFields: json["custom_fields"] == null ? [] : List<dynamic>.from(json["custom_fields"]!.map((x) => x)),
            shippingAddressCustomField: json["shipping_address_custom_field"] == null ? [] : List<dynamic>.from(json["shipping_address_custom_field"]!.map((x) => x)),
            customerInfo: json["customer_info"] == null ? null : CustomerInfo.fromMap(json["customer_info"]),
            base: json["base"],
            errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
            buttonConfirm: json["button_confirm"],
            mixpanelKey: json["mixpanel_key"],
            merchantId: json["merchant_id"],
            clientKey: json["client_key"],
            environment: json["environment"],
            textLoading: json["text_loading"],
            disableMixpanel: json["disable_mixpanel"],
            redirect: json["redirect"],
            processOrder: json["process_order"],
        );
    }

}

class AllPrice {
    AllPrice({
        required this.code,
        required this.title,
        required this.value,
        required this.sortOrder,
    });

    final String? code;
    final String? title;
    final int? value;
    final String? sortOrder;

    factory AllPrice.fromMap(Map<String, dynamic> json){ 
        return AllPrice(
            code: json["code"],
            title: json["title"],
            value: json["value"],
            sortOrder: json["sort_order"],
        );
    }

}

class City {
    City({
        required this.cityId,
        required this.zoneId,
        required this.code,
        required this.name,
        required this.status,
        required this.kurirTokoPrice,
        required this.kurirTokoStatus,
    });

    final String? cityId;
    final String? zoneId;
    final String? code;
    final String? name;
    final String? status;
    final String? kurirTokoPrice;
    final String? kurirTokoStatus;

    factory City.fromMap(Map<String, dynamic> json){ 
        return City(
            cityId: json["city_id"],
            zoneId: json["zone_id"],
            code: json["code"],
            name: json["name"],
            status: json["status"],
            kurirTokoPrice: json["kurir_toko_price"],
            kurirTokoStatus: json["kurir_toko_status"],
        );
    }

}

class Country {
    Country({
        required this.countryId,
        required this.name,
        required this.isoCode2,
        required this.isoCode3,
        required this.addressFormat,
        required this.postcodeRequired,
        required this.status,
    });

    final String? countryId;
    final String? name;
    final String? isoCode2;
    final String? isoCode3;
    final String? addressFormat;
    final String? postcodeRequired;
    final String? status;

    factory Country.fromMap(Map<String, dynamic> json){ 
        return Country(
            countryId: json["country_id"],
            name: json["name"],
            isoCode2: json["iso_code_2"],
            isoCode3: json["iso_code_3"],
            addressFormat: json["address_format"],
            postcodeRequired: json["postcode_required"],
            status: json["status"],
        );
    }

}

class Coupon {
    Coupon({
        required this.couponId,
        required this.name,
        required this.code,
        required this.usesTotal,
        required this.usesCustomer,
        required this.total,
        required this.percent,
        required this.end,
        required this.min,
        required this.amount,
    });

    final String? couponId;
    final String? name;
    final String? code;
    final String? usesTotal;
    final String? usesCustomer;
    final int? total;
    final int? percent;
    final String? end;
    final String? min;
    final String? amount;

    factory Coupon.fromMap(Map<String, dynamic> json){ 
        return Coupon(
            couponId: json["coupon_id"],
            name: json["name"],
            code: json["code"],
            usesTotal: json["uses_total"],
            usesCustomer: json["uses_customer"],
            total: json["total"],
            percent: json["percent"],
            end: json["end"],
            min: json["min"],
            amount: json["amount"],
        );
    }

}

class CustomerInfo {
    CustomerInfo({
        required this.customerId,
        required this.customerGroupId,
        required this.storeId,
        required this.affiliateId,
        required this.languageId,
        required this.firstname,
        required this.lastname,
        required this.email,
        required this.telephone,
        required this.fax,
        required this.password,
        required this.salt,
        required this.cart,
        required this.wishlist,
        required this.newsletter,
        required this.addressId,
        required this.customField,
        required this.ip,
        required this.status,
        required this.approved,
        required this.safe,
        required this.token,
        required this.code,
        required this.dateAdded,
        required this.codeDateAdded,
        required this.dob,
        required this.gender,
        required this.nik,
        required this.image,
        required this.registerMethod,
        required this.totalPoint,
        required this.rememberToken,
    });

    final String? customerId;
    final String? customerGroupId;
    final String? storeId;
    final String? affiliateId;
    final String? languageId;
    final String? firstname;
    final String? lastname;
    final String? email;
    final String? telephone;
    final String? fax;
    final String? password;
    final String? salt;
    final dynamic cart;
    final dynamic wishlist;
    final String? newsletter;
    final String? addressId;
    final String? customField;
    final String? ip;
    final String? status;
    final String? approved;
    final String? safe;
    final String? token;
    final String? code;
    final DateTime? dateAdded;
    final DateTime? codeDateAdded;
    final dynamic dob;
    final String? gender;
    final String? nik;
    final String? image;
    final String? registerMethod;
    final String? totalPoint;
    final String? rememberToken;

    factory CustomerInfo.fromMap(Map<String, dynamic> json){ 
        return CustomerInfo(
            customerId: json["customer_id"],
            customerGroupId: json["customer_group_id"],
            storeId: json["store_id"],
            affiliateId: json["affiliate_id"],
            languageId: json["language_id"],
            firstname: json["firstname"],
            lastname: json["lastname"],
            email: json["email"],
            telephone: json["telephone"],
            fax: json["fax"],
            password: json["password"],
            salt: json["salt"],
            cart: json["cart"],
            wishlist: json["wishlist"],
            newsletter: json["newsletter"],
            addressId: json["address_id"],
            customField: json["custom_field"],
            ip: json["ip"],
            status: json["status"],
            approved: json["approved"],
            safe: json["safe"],
            token: json["token"],
            code: json["code"],
            dateAdded: DateTime.tryParse(json["date_added"] ?? ""),
            codeDateAdded: DateTime.tryParse(json["code_date_added"] ?? ""),
            dob: json["dob"],
            gender: json["gender"],
            nik: json["nik"],
            image: json["image"],
            registerMethod: json["register_method"],
            totalPoint: json["total_point"],
            rememberToken: json["remember_token"],
        );
    }

}

class Kelurahan {
    Kelurahan({
        required this.id,
        required this.kelurahan,
        required this.kecamatan,
        required this.kodepos,
        required this.status,
    });

    final String? id;
    final String? kelurahan;
    final String? kecamatan;
    final String? kodepos;
    final String? status;

    factory Kelurahan.fromMap(Map<String, dynamic> json){ 
        return Kelurahan(
            id: json["id"],
            kelurahan: json["kelurahan"],
            kecamatan: json["kecamatan"],
            kodepos: json["kodepos"],
            status: json["status"],
        );
    }

}


class MethodDataPayment {
    MethodDataPayment({
        required this.group,
        required this.methods,
    });

    final String? group;
    final List<Method> methods;

    factory MethodDataPayment.fromMap(Map<String, dynamic> json){ 
        return MethodDataPayment(
            group: json["group"],
            methods: json["methods"] == null ? [] : List<Method>.from(json["methods"]!.map((x) => Method.fromMap(x))),
        );
    }

}

class Method {
    Method({
        required this.code,
        required this.title,
        required this.sortOrder,
        required this.terms,
        required this.thumb,
        required this.judul,
    });

    final String? code;
    final String? title;
    final dynamic sortOrder;
    final String? terms;
    final String? thumb;
    final String? judul;

    factory Method.fromMap(Map<String, dynamic> json){ 
        return Method(
            code: json["code"],
            title: json["title"],
            sortOrder: json["sort_order"],
            terms: json["terms"],
            thumb: json["thumb"],
            judul: json["judul"]
        );
    }

}

class Trf {
    Trf({
        required this.code,
        required this.title,
        required this.terms,
        required this.thumb,
        required this.sortOrder,
    });

    final String? code;
    final String? title;
    final String? terms;
    final String? thumb;
    final String? sortOrder;

    factory Trf.fromMap(Map<String, dynamic> json){ 
        return Trf(
            code: json["code"],
            title: json["title"],
            terms: json["terms"],
            thumb: json["thumb"],
            sortOrder: json["sort_order"],
        );
    }

}

class Snap {
    Snap({
        required this.code,
        required this.title,
        required this.sortOrder,
        required this.terms,
        required this.thumb,
    });

    final String? code;
    final String? title;
    final int? sortOrder;
    final String? terms;
    final String? thumb;

    factory Snap.fromMap(Map<String, dynamic> json){ 
        return Snap(
            code: json["code"],
            title: json["title"],
            sortOrder: json["sort_order"],
            terms: json["terms"],
            thumb: json["thumb"],
        );
    }

}

class Store {
    Store({
        required this.locationId,
        required this.name,
        required this.address,
        required this.telephone,
        required this.fax,
        required this.geocode,
        required this.zoneId,
        required this.open,
        required this.cityId,
        required this.countryId,
        required this.image,
    });

    final String? locationId;
    final String? name;
    final String? address;
    final String? telephone;
    final String? fax;
    final String? geocode;
    final String? zoneId;
    final String? open;
    final String? cityId;
    final String? countryId;
    final String? image;

    factory Store.fromMap(Map<String, dynamic> json){ 
        return Store(
            locationId: json["location_id"],
            name: json["name"],
            address: json["address"],
            telephone: json["telephone"],
            fax: json["fax"],
            geocode: json["geocode"],
            zoneId: json["zone_id"],
            open: json["open"],
            cityId: json["city_id"],
            countryId: json["country_id"],
            image: json["image"],
        );
    }

}

class Zone {
    Zone({
        required this.zoneId,
        required this.countryId,
        required this.name,
        required this.code,
        required this.status,
    });

    final String? zoneId;
    final String? countryId;
    final String? name;
    final String? code;
    final String? status;

    factory Zone.fromMap(Map<String, dynamic> json){ 
        return Zone(
            zoneId: json["zone_id"],
            countryId: json["country_id"],
            name: json["name"],
            code: json["code"],
            status: json["status"],
        );
    }

}

class ShippingMethod {
    ShippingMethod({
        required this.code,
        required this.title,
        required this.cost,
        required this.etd,
        required this.taxClassId,
        required this.text,
        required this.headTitle,
        required this.codeGroup,
    });

    final String? code;
    final String? title;
    final int? cost;
    final String? etd;
    final int? taxClassId;
    final String? text;
    final String? headTitle;
    final String? codeGroup;

    factory ShippingMethod.fromMap(Map<String, dynamic> json){ 
        return ShippingMethod(
            code: json["code"],
            title: json["title"],
            cost: json["cost"],
            etd: json["etd"],
            taxClassId: json["tax_class_id"],
            text: json["text"],
            headTitle: json["head_title"],
            codeGroup: json["code_group"],
        );
    }

    static ShippingMethod get kurirToko => ShippingMethod(code: "", title: "Kurir Toko", cost: 0, etd: null, taxClassId: null, text: "Kurir Toko", headTitle: null, codeGroup: null);
    

  ShippingMethod copyWith({
    String? code,
    String? title,
    int? cost,
    String? etd,
    int? taxClassId,
    String? text,
    String? headTitle,
    String? codeGroup,
  }) {
    return ShippingMethod(
      code: code ?? this.code,
      title: title ?? this.title,
      cost: cost ?? this.cost,
      etd: etd ?? this.etd,
      taxClassId: taxClassId ?? this.taxClassId,
      text: text ?? this.text,
      headTitle: headTitle ?? this.headTitle,
      codeGroup: codeGroup ?? this.codeGroup,
    );
  }
}

class ShippingMethodHead {
    ShippingMethodHead({
        required this.name,
        required this.code,
    });

    final String? name;
    final String? code;

    factory ShippingMethodHead.fromMap(Map<String, dynamic> json){ 
        return ShippingMethodHead(
            name: json["name"],
            code: json["code"],
        );
    }

}

class Ekspedisi {
    Ekspedisi({
        required this.code,
        required this.title,
        required this.quote,
        required this.sortOrder,
        required this.error,
    });

    final String? code;
    final String? title;
    final Map<String, EkspedisiQuote>? quote;
    final int? sortOrder;
    final bool? error;

    factory Ekspedisi.fromMap(Map<String, dynamic> json){ 
        return Ekspedisi(
            code: json["code"],
            title: json["title"],
            quote: json["quote"] == null ? null : json["quote"] is List ? null : (json["quote"] as Map<String, dynamic>).map((key, value) => MapEntry(key, EkspedisiQuote.fromMap(value))),
            sortOrder: json["sort_order"],
            error: json["error"],
        );
    }

}

class EkspedisiQuote {
    EkspedisiQuote({
        required this.code,
        required this.title,
        required this.cost,
        required this.etd,
        required this.taxClassId,
        required this.text,
    });

    final String? code;
    final String? title;
    final int? cost;
    final String? etd;
    final int? taxClassId;
    final String? text;

    factory EkspedisiQuote.fromMap(Map<String, dynamic> json){ 
        return EkspedisiQuote(
            code: json["code"],
            title: json["title"],
            cost: json["cost"],
            etd: json["etd"],
            taxClassId: json["tax_class_id"],
            text: json["text"],
        );
    }

}