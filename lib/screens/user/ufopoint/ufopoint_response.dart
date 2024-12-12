class UfoPointResponse {
    UfoPointResponse({
        required this.headingTitle,
        required this.rewards,
        required this.coupon,
        required this.totalPointsExpired,
        required this.couponExpired,
        required this.pointHistory,
        required this.pointExpiredHistory,
        required this.totalPoints,
        required this.pagination,
        required this.results,
        required this.total,
        required this.errorWarning,
        required this.success,
        required this.account,
        required this.ufoPointResponseReturn,
        required this.voucher,
        required this.transaction,
        required this.notification,
        required this.wishlist,
        required this.newsletter,
        required this.recurring,
        required this.action,
        required this.edit,
        required this.password,
        required this.logout,
        required this.ufopoint,
        required this.address,
        required this.header,
        required this.footer,
    });

    final String? headingTitle;
    final List<dynamic> rewards;
    final List<Coupon> coupon;
    final String? totalPointsExpired;
    final List<dynamic> couponExpired;
    final List<PointHistory> pointHistory;
    final List<PointHistory> pointExpiredHistory;
    final String? totalPoints;
    final String? pagination;
    final String? results;
    final int? total;
    final String? errorWarning;
    final String? success;
    final String? account;
    final String? ufoPointResponseReturn;
    final String? voucher;
    final String? transaction;
    final String? notification;
    final String? wishlist;
    final String? newsletter;
    final String? recurring;
    final String? action;
    final String? edit;
    final String? password;
    final String? logout;
    final String? ufopoint;
    final String? address;
    final String? header;
    final String? footer;

    factory UfoPointResponse.fromMap(Map<String, dynamic> json){ 
        return UfoPointResponse(
            headingTitle: json["heading_title"],
            rewards: json["rewards"] == null ? [] : List<dynamic>.from(json["rewards"]!.map((x) => x)),
            coupon: json["coupon"] == null ? [] : List<Coupon>.from(json["coupon"]!.map((x) => Coupon.fromMap(x))),
            totalPointsExpired: json["total_points_expired"]?.toString(),
            couponExpired: json["coupon_expired"] == null ? [] : List<dynamic>.from(json["coupon_expired"]!.map((x) => x)),
            pointHistory: json["point_history"] == null ? [] : List<PointHistory>.from(json["point_history"]!.map((x) => PointHistory.fromMap(x))),
            pointExpiredHistory: json["point_expired_history"] == null ? [] : List<PointHistory>.from(json["point_expired_history"]!.map((x) => PointHistory.fromMap(x))),
            totalPoints: json["total_points"]?.toString(),
            pagination: json["pagination"],
            results: json["results"],
            total: json["total"],
            errorWarning: json["error_warning"],
            success: json["success"],
            account: json["account"],
            ufoPointResponseReturn: json["return"],
            voucher: json["voucher"],
            transaction: json["transaction"],
            notification: json["notification"],
            wishlist: json["wishlist"],
            newsletter: json["newsletter"],
            recurring: json["recurring"],
            action: json["action"],
            edit: json["edit"],
            password: json["password"],
            logout: json["logout"],
            ufopoint: json["ufopoint"],
            address: json["address"],
            header: json["header"],
            footer: json["footer"],
        );
    }

}

class PointHistory {
    PointHistory({
        required this.customerRewardId,
        required this.customerId,
        required this.orderId,
        required this.description,
        required this.points,
        required this.dateAdded,
        required this.status,
        required this.pointUsed,
        required this.expiredDate,
    });

    final String? customerRewardId;
    final String? customerId;
    final String? orderId;
    final String? description;
    final String? points;
    final DateTime? dateAdded;
    final String? status;
    final String? pointUsed;
    final DateTime? expiredDate;

    factory PointHistory.fromMap(Map<String, dynamic> json){ 
        return PointHistory(
            customerRewardId: json["customer_reward_id"],
            customerId: json["customer_id"],
            orderId: json["order_id"],
            description: json["description"],
            points: json["points"],
            dateAdded: DateTime.tryParse(json["date_added"] ?? ""),
            status: json["status"],
            pointUsed: json["point_used"],
            expiredDate: DateTime.tryParse(json["expired_date"] ?? ""),
        );
    }

}

class Coupon {
    Coupon({
        required this.couponId,
        required this.name,
        required this.code,
        required this.usesTotal,
        required this.point,
        required this.usesCustomer,
        required this.cls,
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
    final String? point;
    final String? usesCustomer;
    final String? cls;
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
            point: json["point"],
            usesCustomer: json["uses_customer"],
            cls: json["cls"],
            total: json["total"],
            percent: json["percent"],
            end: json["end"],
            min: json["min"],
            amount: json["amount"],
        );
    }

}
