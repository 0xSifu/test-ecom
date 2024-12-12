class PopUpResponse {
    PopUpResponse({
        required this.popup,
    });

    final Popup? popup;

    factory PopUpResponse.fromMap(Map<String, dynamic> json){ 
        return PopUpResponse(
            popup: json["popup"] == null ? null : Popup.fromMap(json["popup"]),
        );
    }

}

class Popup {
    Popup({
        required this.title,
        required this.link,
        required this.image,
    });

    final String? title;
    final String? link;
    final String? image;

    factory Popup.fromMap(Map<String, dynamic> json){ 
        return Popup(
            title: json["title"],
            link: json["link"],
            image: json["image"],
        );
    }

}
