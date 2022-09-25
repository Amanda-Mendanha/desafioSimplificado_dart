class Endereco {
  String logradouro = '';
  String? complemento = '';
  int? numero = 0;
  String bairro = '';
  String cidade = '';
  String estado = '';
  String cep = '';

  Endereco(
      {required this.logradouro,
      this.complemento,
      this.numero,
      required this.bairro,
      required this.estado,
      required this.cidade,
      required this.cep});

  String get cepFormatado {
    return "${cep.substring(0, 2)}.${cep.substring(2, 5)}-${cep.substring(5)}";
  }

  String get estadoFormatado {
    return estado.toUpperCase();
  }
}
