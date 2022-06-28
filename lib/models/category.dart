class Category {
  final int? id;
  final int icon;
  final String title;
  final int color;
  final bool custom; // True if the user created the category

  Category({
    this.id,
    required this.icon,
    required this.title,
    required this.color,
    required this.custom
  });

  Map<String, Object> toMap() {
    return {
      'icon': icon,
      'title': title,
      'color': color,
      'custom': custom,
    };
  }
}