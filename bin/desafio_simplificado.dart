import 'dart:io';

import 'package:desafio_simplificado/menuCadastro.dart';

void main() {
  print("\x1B[2J\x1B[0;0H");
  MenuCadastro menuCadastro = MenuCadastro();
  String inputId = '';
  String option = '';
  while (true) {
    print('''Escolha uma opção:
  1) Cadastrar empresa
  2) Pesquisar empresa pelo CNPJ
  3) Pesquisar empresa pelo CPF do sócio
  4) Listar empresas cadastradas
  5) Excluir empresa
  0) Sair
   ''');
    option = stdin.readLineSync()!;
    if (option == '0') break;
    switch (option) {
      case '1':
        menuCadastro.cadastrarEmpresa();
        break;
      case '2':
        menuCadastro.pesquisarEmpresaPorCnpj();
        break;
      case '3':
        menuCadastro.pesquisarEmpresaSocio();
        break;

      case '4':
        menuCadastro.listarEmpresaEmOrdem();
        break;
      case '5':
        print("Digite o ID da empresa que deeja excluir:");
        inputId = stdin.readLineSync()!;
        menuCadastro.excluirEmpresa(inputId);
        break;

      default:
        print("Opção inválida. Tente novamente");
    }
  }
}
