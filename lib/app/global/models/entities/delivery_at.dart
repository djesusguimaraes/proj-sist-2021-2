class DeliveryAt {
  final bool? active;
  final String street;
  final String block;
  final String complement;
  final String number;
  final String cep;
  final String city;
  final String uf;
  late String? id;

  DeliveryAt({
    this.active,
    required this.street,
    required this.block,
    required this.complement,
    required this.number,
    required this.cep,
    required this.city,
    required this.uf,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'active': active,
      'cep': cep,
      'city': city,
      'complement': complement,
      'district': block,
      'number': number,
      'street': street,
      'uf': uf,
    };
  }

  static DeliveryAt fromMap(Map<String, dynamic> map) {
    return DeliveryAt(
      active: map['active'],
      cep: map['cep'],
      city: map['city'],
      complement: map['complement'],
      block: map['district'],
      number: map['number'],
      street: map['street'],
      uf: map['uf'],
    );
  }
}
