class Meal {
  int id;
  String name;
  String ingredient;
  List<Calorie> calories;
  String recipe;
  String imageUrl;
  String type;
  int isFavorite;

  Meal({
    required this.id,
    required this.name,
    required this.ingredient,
    required this.calories,
    required this.recipe,
    required this.imageUrl,
    required this.type,
    this.isFavorite=0,
  });

  // Meal nesnesini Map'e dönüştüren fonksiyon
  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      name: map['name'],
      ingredient: map['ingredient'],
      calories: map['calories'] != null
          ? (map['calories'] as List)
          .map((calorie) => Calorie.fromMap(calorie))
          .toList()
          : [], // Eğer calories null ise boş liste olarak kabul edilir
      recipe: map['recipe'],
      imageUrl: map['image_url'],
      type: map['type'],
      isFavorite: map['isFavorite'], // Eklenen yeni özellik
    );
  }

  // Meal nesnesini Map formatına dönüştüren fonksiyon
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ingredient': ingredient,
      'calories': calories.map((calorie) => calorie.toMap()).toList(),
      'recipe': recipe,
      'image_url': imageUrl,
      'type': type,
      'isFavorite': isFavorite, // Eklenen yeni özellik
    };
  }

  // Meal nesnesini JSON formatına çevirme
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      name: json['name'],
      ingredient: json['ingredient'],
      calories: json['calories'] != null
          ? (json['calories'] as List)
          .map((calorie) => Calorie.fromJson(calorie))
          .toList()
          : [], // Eğer calories null ise boş liste olarak kabul edilir
      recipe: json['recipe'],
      imageUrl: json['image_url'],
      type: json['type'],
      isFavorite: json['isFavorite'], // Eklenen yeni özellik
    );
  }

  // Meal nesnesini JSON formatına dönüştüren fonksiyon
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ingredient': ingredient,
      'calories': calories.map((calorie) => calorie.toJson()).toList(),
      'recipe': recipe,
      'image_url': imageUrl,
      'type': type,
      'isFavorite': isFavorite, // Eklenen yeni özellik
    };
  }
}

class Calorie {
  String portion;
  String calorie;

  Calorie({required this.portion, required this.calorie});

  // Calorie nesnesini Map formatına çevirme
  Map<String, dynamic> toMap() {
    return {
      'portion': portion,
      'calorie': calorie,
    };
  }

  // Map verisinden Calorie nesnesi oluşturma
  factory Calorie.fromMap(Map<String, dynamic> map) {
    return Calorie(
      portion: map['portion'],
      calorie: map['calorie'],
    );
  }

  // JSON verisinden Calorie nesnesi oluşturma
  factory Calorie.fromJson(Map<String, dynamic> json) {
    return Calorie(
      portion: json['portion'],
      calorie: json['calorie'],
    );
  }

  // Calorie nesnesini JSON formatına çevirme
  Map<String, dynamic> toJson() {
    return {
      'portion': portion,
      'calorie': calorie,
    };
  }
}
