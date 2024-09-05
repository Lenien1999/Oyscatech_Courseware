import 'package:cloud_firestore/cloud_firestore.dart';

class CardDetails {
  String? cardType;
  String? cardCurreency;
  String? cardAmount;
  String? redeemCode;
  String? giftCardPin;
  String? cvv;
  String? cardNumber;
  String? id;
  String? expDate;
  DateTime time;

  CardDetails(
      {this.cardAmount,
      this.id,
      this.cardCurreency,
      required this.time,
      this.cardNumber,
      this.cardType,
      this.cvv,
      this.expDate,
      this.giftCardPin,
      this.redeemCode});

  Map<String, dynamic> toMap() {
    return {
      'cardType': cardType,
      'cardCurreency': cardCurreency,
      'cardAmount': cardAmount,
      'redeemCode': redeemCode,
      'giftCardPin': giftCardPin,
      'cvv': cvv,
      'time': time,
      'expDate': expDate,
      'cardNumber': cardNumber,
    };
  }

  factory CardDetails.fromJson(Map<String, dynamic> json, String id) {
    return CardDetails(
      id: id,
      time: (json['time'] as Timestamp?)?.toDate() ?? DateTime.now(),
      cardAmount: json['cardAmount'] ?? " ",
      cardNumber: json['cardNumber'] ?? "",
      cardCurreency: json["cardCurreency"] ?? "",
      cardType: json["cardType"] ?? " ",
      cvv: json["cvv"] ?? " ",
      expDate: json["expDate"] ?? "",
      giftCardPin: json["giftCardPin"] ?? " ",
      redeemCode: json["redeemCode"] ?? "",
    );
  }
}
