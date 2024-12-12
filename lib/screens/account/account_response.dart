class ProfileResponse {
    ProfileResponse({
        required this.success,
        required this.error,
        required this.textLogged,
        required this.logout,
        required this.entryFullname,
        required this.entryEmail,
        required this.entryTelephone,
        required this.fullname,
        required this.email,
        required this.telephone,
        required this.dob,
        required this.nik,
        required this.gender,
        required this.dateAdded,
        required this.fax,
        required this.image,
        required this.headingTitle,
        required this.textMyAccount,
        required this.textMyOrders,
        required this.textMyNewsletter,
        required this.textEdit,
        required this.textPassword,
        required this.textAddress,
        required this.textCreditCard,
        required this.textWishlist,
        required this.textOrder,
        required this.textDownload,
        required this.textReward,
        required this.textReturn,
        required this.textTransaction,
        required this.textNewsletter,
        required this.textRecurring,
        required this.edit,
        required this.password,
        required this.address,
        required this.actionUpload,
        required this.ufopoint,
        required this.creditCards,
        required this.wishlist,
        required this.order,
        required this.download,
        required this.reward,
    });

    final String? success;
    final String? error;
    final String? textLogged;
    final String? logout;
    final String? entryFullname;
    final String? entryEmail;
    final String? entryTelephone;
    final String? fullname;
    final String? email;
    final String? telephone;
    final String? dob;
    final String? nik;
    final String? gender;
    final String? dateAdded;
    final String? fax;
    final String? image;
    final String? headingTitle;
    final String? textMyAccount;
    final String? textMyOrders;
    final String? textMyNewsletter;
    final String? textEdit;
    final String? textPassword;
    final String? textAddress;
    final String? textCreditCard;
    final String? textWishlist;
    final String? textOrder;
    final String? textDownload;
    final String? textReward;
    final String? textReturn;
    final String? textTransaction;
    final String? textNewsletter;
    final String? textRecurring;
    final String? edit;
    final String? password;
    final String? address;
    final String? actionUpload;
    final String? ufopoint;
    final List<dynamic> creditCards;
    final String? wishlist;
    final String? order;
    final String? download;
    final String? reward;

    factory ProfileResponse.fromMap(Map<String, dynamic> json){ 
        return ProfileResponse(
            success: json["success"],
            error: json["error"],
            textLogged: json["text_logged"],
            logout: json["logout"],
            entryFullname: json["entry_fullname"],
            entryEmail: json["entry_email"],
            entryTelephone: json["entry_telephone"],
            fullname: json["fullname"],
            email: json["email"],
            telephone: json["telephone"],
            dob: json["dob"],
            nik: json["nik"],
            gender: json["gender"],
            dateAdded: json["date_added"],
            fax: json["fax"],
            image: json["image"],
            headingTitle: json["heading_title"],
            textMyAccount: json["text_my_account"],
            textMyOrders: json["text_my_orders"],
            textMyNewsletter: json["text_my_newsletter"],
            textEdit: json["text_edit"],
            textPassword: json["text_password"],
            textAddress: json["text_address"],
            textCreditCard: json["text_credit_card"],
            textWishlist: json["text_wishlist"],
            textOrder: json["text_order"],
            textDownload: json["text_download"],
            textReward: json["text_reward"],
            textReturn: json["text_return"],
            textTransaction: json["text_transaction"],
            textNewsletter: json["text_newsletter"],
            textRecurring: json["text_recurring"],
            edit: json["edit"],
            password: json["password"],
            address: json["address"],
            actionUpload: json["action_upload"],
            ufopoint: json["ufopoint"],
            creditCards: json["credit_cards"] == null ? [] : List<dynamic>.from(json["credit_cards"]!.map((x) => x)),
            wishlist: json["wishlist"],
            order: json["order"],
            download: json["download"],
            reward: json["reward"],
        );
    }

}
