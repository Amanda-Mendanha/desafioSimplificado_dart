import 'package:desafio_simplificado/endereco.dart';

class PessoaFisica {
  String cpf = '';
  String nameSocio = '';
  Endereco adressPf;

  PessoaFisica({
    required this.nameSocio,
    required this.cpf,
    required this.adressPf,
  });

  String get cpfFormatado {
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
  }
}
