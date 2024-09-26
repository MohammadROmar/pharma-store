enum Category {
  antibiotics,
  obesity,
  antidiabetic,
  cardiovascular,
  neurologicalPsychlogical,
  nsaidsAnalgesicsAntipyretic,
  gastrointestinal,
  respiratory,
  musculoskeletal,
  urological,
  dermatological,
  vitaminsMinerals,
  foodSupplement
}

class Medicine {
  const Medicine({
    required this.id,
    required this.imagePath,
    required this.scientificName,
    required this.price,
    required this.expiryDate,
    required this.company,
    required this.commName,
    required this.category,
    required this.amount,
  });

  final int id;
  final String scientificName;
  final String commName;
  final Category category;
  final String company;
  final int amount;
  final String expiryDate;
  final int price;
  final String imagePath;
}
