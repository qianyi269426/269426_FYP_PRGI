// To parse this JSON data, do
//
//     final ratesModel = ratesModelFromJson(jsonString);

import 'dart:convert';

RatesModel ratesModelFromJson(String str) => RatesModel.fromJson(json.decode(str));

String ratesModelToJson(RatesModel data) => json.encode(data.toJson());

class RatesModel {
    RatesModel({
        this.disclaimer,
        this.license,
        this.timestamp,
        this.base,
        this.rates,
    });

    String? disclaimer;
    String? license;
    int? timestamp;
    String? base;
    Map<String, double>? rates;

    factory RatesModel.fromJson(Map<String, dynamic> json) => RatesModel(
        disclaimer: json["disclaimer"],
        license: json["license"],
        timestamp: json["timestamp"],
        base: json["base"],
        rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "disclaimer": disclaimer,
        "license": license,
        "timestamp": timestamp,
        "base": base,
        "rates": Map.from(rates!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}