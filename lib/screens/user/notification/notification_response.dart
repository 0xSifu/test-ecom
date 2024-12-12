import 'package:collection/collection.dart';

class NotificationResponse {
    NotificationResponse({
        required List<Pesanan> pesanan,
        required List<Notif> notif,
    }): _pesanan = pesanan, _notif = notif;

    final List<Pesanan> _pesanan;
    final List<Notif> _notif;

    List<Notification> get notifications => (_pesanan.map((e) => e.toNotification).toList() + _notif.map((e) => e.toNotification).toList())
      .sorted((a, b) => (b.dateAdded ?? DateTime.now()).compareTo(a.dateAdded ?? DateTime.now()));

    factory NotificationResponse.fromMap(Map<String, dynamic> json){ 
        return NotificationResponse(
            pesanan: json["pesanan"] == null ? [] : List<Pesanan>.from(json["pesanan"]!.map((x) => Pesanan.fromMap(x))),
            notif: json["notif"] == null ? [] : List<Notif>.from(json["notif"]!.map((x) => Notif.fromMap(x))),
        );
    }

}

enum NotificationType {
  transaction, promo
}

class Notification {
  final NotificationType type;
  final String? name;
  final String? image;
  final String? description;
  final DateTime? dateAdded;
  final String? applink;
  Notification({
    required this.type,
    this.name,
    this.image,
    this.description,
    this.dateAdded,
    this.applink,
  });
}

class Notif {
    Notif({
        required this.name,
        required this.description,
        required this.title,
        required this.dateAdded,
        required this.notifId,
        required this.href,
        required this.image,
    });

    final String? name;
    final String? description;
    final String? title;
    final DateTime? dateAdded;
    final String? notifId;
    final String? href;
    final String? image;

    factory Notif.fromMap(Map<String, dynamic> json){ 
        return Notif(
            name: json["name"],
            description: json["description"],
            title: json["title"],
            dateAdded: DateTime.tryParse(json["date_added"] ?? ""),
            notifId: json["notif_id"],
            href: json["href"],
            image: json["image"],
        );
    }

    Notification get toNotification => Notification(
      type: NotificationType.promo,
      name: name,
      image: image,
      description: description,
      dateAdded: dateAdded,
      applink: "ufoelektronika://ufoelektronika.com/information?notification_id=$notifId"
    );

}

class Pesanan {
    Pesanan({
        required this.statusDesc,
        required this.statusName,
        required this.date,
        required this.view,
    });

    final String? statusDesc;
    final String? statusName;
    final DateTime? date;
    final String? view;

    factory Pesanan.fromMap(Map<String, dynamic> json){ 
        return Pesanan(
            statusDesc: json["status_desc"],
            statusName: json["status_name"],
            date: DateTime.tryParse(json["date"] ?? ""),
            view: json["view"],
        );
    }


    Notification get toNotification => Notification(
      type: NotificationType.transaction,
      name: statusName,
      image: null,
      description: statusDesc,
      dateAdded: date,
      applink: view
    );
}
