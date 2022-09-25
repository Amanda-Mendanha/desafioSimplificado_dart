// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';
import 'pessoaFisica.dart';
import 'pessoaJuridica.dart';

//toda epresa é uma Pessoa Juridica
// atributos privados restritos a classe em que foi criado
class Empresa extends PessoaJuridica {
  final _id = Uuid().v4();
  final _dateCreate = DateTime.now();
  PessoaFisica? socio;

  Empresa({
    required super.cnpj,
    required super.razaoSocial,
    required super.adressPj,
    required super.nomeFantasia,
    this.socio,
  });
//get para utilizar atributo privado
  String get id => _id;
  DateTime get dateCreate => _dateCreate;
}
