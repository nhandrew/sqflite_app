class Trail {
  final String name;
  final double distance;
  final String difficulty;

  Trail({this.name, this.difficulty, this.distance});

  factory Trail.fromJson(Map<String,dynamic> json){
    return Trail(  
      name: json['name'],
      difficulty: json['difficulty'],
      distance: json['distance']
    );
  }
}