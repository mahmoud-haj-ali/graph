class Edge {
  Edge({
    this.name,
    this.start,
    this.end,
    this.weight,
  });

  String name;
  String start;
  String end;
  String weight;

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
    name: json["name"],
    start: json["start"],
    end: json["end"],
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "start": start,
    "end": end,
    "weight": weight,
  };
}