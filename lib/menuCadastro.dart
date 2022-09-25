// ignore_for_file: file_names

import 'dart:io';
import 'empresa.dart';
import 'endereco.dart';
import 'pessoaFisica.dart';

class MenuCadastro {
  final List<Empresa> _myCompanys = [];
//metodo para cadastrar uma nova empresa
  void cadastrarEmpresa() {
    final String razaoSocialEmpresa = _inputEmpresa("a", "razao social");
    final String nomeFantasiaEmpresa = _inputEmpresa("o", "nome fantasia");
    String cnpjEmpresa = _inputEmpresa("o", "cnpj");

    while (_validarCnpj(cnpjEmpresa)) {
      print("CNPJ inválido! O CNPJ possui 14 digitos, sem pontos e traços");
      cnpjEmpresa = _inputEmpresa("o", "cnpj");
    }
    final adressEmpresa = _addEndereco(Empresa);

    PessoaFisica? socio;
    socio = _addSocio(PessoaFisica);
    _myCompanys.add(Empresa(
        cnpj: cnpjEmpresa,
        razaoSocial: razaoSocialEmpresa,
        adressPj: adressEmpresa,
        nomeFantasia: nomeFantasiaEmpresa,
        socio: socio));
  }

//metodo para pesquisar empresa por CNPJ, utilizar for in para trabalhar com lista
  void pesquisarEmpresaPorCnpj() {
    if (_myCompanys.isEmpty) {
      print("Não há empresas cadastradas.");
      return;
    }
    print("Qual CNPj da empresa que deseja pesquisar?");
    final inputCnpjPesquisa = stdin.readLineSync()!;
    for (var element in _myCompanys) {
      if (element.cnpj == inputCnpjPesquisa) {
        _mostrarEmpresa(element);
      } else {
        print(
            "Não há empresas cadastradas com o CNPJ digitado. Tente novamente.");
      }
    }
  }

//metodo para pesquisar empresa pelo CPF
  void pesquisarEmpresaSocio() {
    if (_myCompanys.isEmpty) {
      print("Não há empresas cadastradas.");
      return;
    }
    print("Qual CPF do sócio da empresa que deseja pesquisar?");

    final inputCpfPesquisa = stdin.readLineSync()!;

    for (var element in _myCompanys) {
      if (element.socio!.cpf == inputCpfPesquisa) {
        _mostrarEmpresa(element);
      } else {
        print(
            "Não há empresas cadastradas com o CPF digitado. Tente novamente.");
      }
    }
  }

//metodo para excluir empresa pelo ID, utilizar for in e metodo removeWhere para remover todos os objetos da lista
  void excluirEmpresa(String idEmpresa) {
    if (_myCompanys.isEmpty) {
      print("Não há empresas cadastradas.");
      return;
    }
    for (var element in _myCompanys) {
      if (element.id == idEmpresa) {
        print(
            "Deseja excluir a empresa ${element.razaoSocial}? Digite SIM ou NÂO.");
        final input = stdin.readLineSync()!;
        if (input == "SIM" || input == "NÃO") {
          _myCompanys.removeWhere((element) {
            return element.id == idEmpresa;
          });
          print("Empresa removida com sucesso");
        }
      }
    }
  }

//sort recebe dois parâmetros e os compara, compareTo ordenar em ordem alfabetica
  void listarEmpresaEmOrdem() {
    _myCompanys.sort((a, b) => a.razaoSocial.compareTo(b.razaoSocial));
    print("Lista de empresas cadastradas");
    for (var element in _myCompanys) {
      print('''ID: ${element.id} 
      CNPJ: ${element.cnpjFormatado}
      Data de Cadastro: ${element.dateCreate}
      Razão Social: ${element.razaoSocial}''');
    }
  }

//método para ser utilizado nas pesquisas por CNPJ e CPF do sócio para retornar os dados de uma empresa cadastrada
  void _mostrarEmpresa(Empresa empresa) {
    print('''
ID: ${empresa.id}
CNPJ: ${empresa.cnpjFormatado} 
Data Cadastro: ${empresa.dateCreate}
Razão Social: ${empresa.razaoSocial}
Nome Fantasia: ${empresa.nomeFantasia}
Endereço: ${empresa.adressPj.logradouro}, ${empresa.adressPj.numero}, ${empresa.adressPj.bairro}, ${empresa.adressPj.cidade}/${empresa.adressPj.estado}, ${empresa.adressPj.cepFormatado}
Sócio:
CPF: ${empresa.socio?.cpfFormatado}
Nome Completo: ${empresa.socio?.nameSocio}
Endereço: ${empresa.socio?.adressPf.logradouro}, ${empresa.socio?.adressPf.numero}, ${empresa.socio?.adressPf.bairro}, ${empresa.socio?.adressPf.cidade}/${empresa.socio?.adressPf.estado}, ${empresa.socio?.adressPf.cepFormatado}
''');
  }

// metodo para ler dados de uma empresa
  String _inputEmpresa(String artigo, String nome) {
    print("Digite $artigo $nome da empresa");
    return stdin.readLineSync()!;
  }

//metodo para adicionar socio, Type converte para String na depuração, com String direto ocasiona erro
  PessoaFisica _addSocio(Type tipo) {
    String cpf = '';
    String nameSocio = '';
    Endereco adressPf;
    print("Agora iremos adicionar o sócio da empresa.");
    nameSocio = _input("O", "nome do sócio", tipo);
    print("Agora iremos adicionar o endereço do sócio.");
    adressPf = _addEndereco(PessoaFisica);
    cpf = _input("O", "CPF", tipo);

    while (_validarCpf(cpf)) {
      print("CPF inválido! O CPF deve conter 11 digitos sem traços e pontos.");
      cpf = _input("O", "CPF", tipo);
    }
    return PessoaFisica(nameSocio: nameSocio, cpf: cpf, adressPf: adressPf);
  }

//metodo para adicionar endereço, Type converte para String na depuração, com String direto ocasiona erro
  Endereco _addEndereco(Type tipo) {
    String logradouro;
    String? numero;
    String? complemento;
    String bairro;
    String cep;
    String cidade;
    String estado;
    print('Adicionar endereço:');
    logradouro = _input("o", "logradouro", tipo);
    numero = int.tryParse(_input("o", "numero", tipo)) as String?;
    complemento = _input("o", "complemento", tipo);
    bairro = _input("o", "bairro", tipo);
    cidade = _input("a", "cidade", tipo);

    estado = _input("a", "sigla do estado", tipo);
    while (estado.length != 2) {
      print("O estado deve conter duas letras, digite um valor válido.");
      estado = _input("a", "sigla do estado", tipo);
    }

    cep = _input("o", "cep", tipo);
    while (cep.length != 8) {
      print(
          "CEP inválido, digite novamente: O número deve conter 8 numeros sem traços e pontos");
      cep = _input("o", "cep", tipo);
    }

    return Endereco(
        logradouro: logradouro,
        complemento: complemento,
        bairro: bairro,
        cidade: cidade,
        estado: estado,
        cep: cep);
  }

//metodo para ler dados de endereço e socio dentro dos metodos add socio e add endereco, Type converte para String na depuração, com String direto ocasiona erro
  String _input(String artigo, String nome, Type tipo) {
    print("Digite $artigo $nome");
    return stdin.readLineSync()!;
  }

  bool _validarCpf(String inputCpf) {
    if (inputCpf.length != 11) {
      return true;
    } else {
      return false;
    }
  }

  bool _validarCnpj(String inputCnpj) {
    if (inputCnpj.length != 14) {
      return true;
    } else {
      return false;
    }
  }
}
