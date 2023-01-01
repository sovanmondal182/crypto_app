class Cryptocurrency {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentprice;
  double? marketcap;
  int? marketcaprank;
  double? totalvolume;
  double? high_24h;
  double? low_24h;
  double? pricechange_24h;
  double? pricechangepercentage_24h;
  double? marketcapchange_24h;
  double? marketcapchangepercentage_24h;
  double? circulatingsupply;
  double? ath;
  double? atl;

  Cryptocurrency(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.currentprice,
      required this.marketcap,
      required this.marketcaprank,
      required this.totalvolume,
      required this.high_24h,
      required this.low_24h,
      required this.pricechange_24h,
      required this.pricechangepercentage_24h,
      required this.marketcapchange_24h,
      required this.marketcapchangepercentage_24h,
      required this.circulatingsupply,
      required this.ath,
      required this.atl});

  factory Cryptocurrency.fromJson(Map<String, dynamic> map) {
    return Cryptocurrency(
        id: map['id'],
        symbol: map['symbol'],
        name: map['name'],
        image: map['image'],
        currentprice: double.parse(map['current_price'].toString()),
        marketcap: double.parse(map['market_cap'].toString()),
        marketcaprank: map['market_cap_rank'],
        totalvolume: double.parse(map['total_volume'].toString()),
        high_24h: double.parse(map['high_24h'].toString()),
        low_24h: double.parse(map['low_24h'].toString()),
        pricechange_24h: double.parse(map['price_change_24h'].toString()),
        pricechangepercentage_24h:
            double.parse(map['price_change_percentage_24h'].toString()),
        marketcapchange_24h:
            double.parse(map['market_cap_change_24h'].toString()),
        marketcapchangepercentage_24h:
            double.parse(map['market_cap_change_percentage_24h'].toString()),
        circulatingsupply: double.parse(map['circulating_supply'].toString()),
        ath: double.parse(map['ath'].toString()),
        atl: double.parse(map['atl'].toString()));
  }
}
