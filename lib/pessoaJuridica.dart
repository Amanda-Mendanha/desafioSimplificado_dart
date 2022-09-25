import 'package:desafio_simplificado/endereco.dart';

class PessoaJuridica {
  String cnpj = '';
  String razaoSocial = '';
  String nomeFantasia = '';
  Endereco adressPj;

  PessoaJuridica({
    required this.cnpj,
    required this.razaoSocial,
    required this.adressPj,
    required this.nomeFantasia,
  });

  String get cnpjFormatado {
    return '${cnpj.substring(0, 3)}.${cnpj.substring(3, 6)}.${cnpj.substring(6, 9)}-${cnpj.substring(9)}';
  }
}
