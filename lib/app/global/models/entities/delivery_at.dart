class DeliveryAt {
  final String street;
  final String block;
  final String complement;
  final int? number;
  final String cep;
  final String city;
  final String uf;
  final bool active;

  DeliveryAt({
    this.active = false,
    required this.street,
    required this.block,
    required this.complement,
    required this.number,
    required this.cep,
    this.city = 'Palmas',
    this.uf = 'TO',
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
