class VirtualGift {
  final String id;
  final String name;
  final int coinCost;
  final String iconAsset; // path under assets/gifts/
  final GiftTier tier;
  final bool isAnimated; // full-screen combo animation (Lottie) vs a simple fly-in

  const VirtualGift({
    required this.id,
    required this.name,
    required this.coinCost,
    required this.iconAsset,
    required this.tier,
    this.isAnimated = false,
  });

  static const List<VirtualGift> catalog = [
    VirtualGift(id: 'rose', name: 'Rose', coinCost: 10, iconAsset: 'assets/gifts/rose.png', tier: GiftTier.basic),
    VirtualGift(id: 'heart', name: 'Heart', coinCost: 20, iconAsset: 'assets/gifts/heart.png', tier: GiftTier.basic),
    VirtualGift(id: 'icecream', name: 'Ice Cream', coinCost: 50, iconAsset: 'assets/gifts/icecream.png', tier: GiftTier.basic),
    VirtualGift(id: 'crown', name: 'Crown', coinCost: 500, iconAsset: 'assets/gifts/crown.png', tier: GiftTier.premium, isAnimated: true),
    VirtualGift(id: 'sportscar', name: 'Sports Car', coinCost: 2000, iconAsset: 'assets/gifts/sportscar.png', tier: GiftTier.premium, isAnimated: true),
    VirtualGift(id: 'rocket', name: 'Rocket', coinCost: 5000, iconAsset: 'assets/gifts/rocket.png', tier: GiftTier.luxury, isAnimated: true),
    VirtualGift(id: 'dodo_throne', name: "Dodo's Throne", coinCost: 20000, iconAsset: 'assets/gifts/throne.png', tier: GiftTier.luxury, isAnimated: true),
  ];
}

enum GiftTier { basic, premium, luxury }
