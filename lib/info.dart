class Info {
  String? code,
      units,
      buy_price,
      manage_fee,
      manage_fee_refund,
      nett,
      target,
      type,
      gross,
      profit;
  DateTime? purchased_date;

  Info({
    this.code,
    this.purchased_date,
    this.units,
    this.buy_price,
    this.manage_fee,
    this.manage_fee_refund,
    this.nett,
    this.target,
    this.type,
    this.gross,
    this.profit,
  });
}
