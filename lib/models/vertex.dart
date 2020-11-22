class Vertex {
  Vertex({
    this.name,
    this.degree,
  });

  String name;
  String degree;

  factory Vertex.fromJson(Map<String, dynamic> json) => Vertex(
    name: json["name"],
    degree: json["degree"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "degree": degree,
  };
}