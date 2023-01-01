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
        currentprice: map['current_price'],
        marketcap: map['market_cap'],
        marketcaprank: map['market_cap_rank'],
        totalvolume: map['total_volume'],
        high_24h: map['high_24h'],
        low_24h: map['low_24h'],
        pricechange_24h: map['price_change_24h'],
        pricechangepercentage_24h: map['price_change_percentage_24h'],
        marketcapchange_24h: map['market_cap_change_24h'],
        marketcapchangepercentage_24h: map['market_cap_change_percentage_24h'],
        circulatingsupply: map['circulating_supply'],
        ath: map['ath'],
        atl: map['atl']);
  }
}
