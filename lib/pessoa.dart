class Pessoa {
  String nome = "";
  String CPF = "";
  String telefone = "";
  String nomeUsuario = "";
  String email = "";
  String senha = "";

  // Pessoa(this.nome, this.CPF, this.telefone, this.nomeUsuario, this.email,
  //     this.senha);

  //constructor
  Pessoa(
      {required this.nome,
      required this.CPF,
      required this.telefone,
      required this.nomeUsuario,
      required this.email,
      required this.senha});

  String getNome() {
    return nome;
  }

  String getCPF() {
    return CPF;
  }

  String getTelefone() {
    return telefone;
  }

  String getNomeUsuario() {
    return nomeUsuario;
  }

  String getEmail() {
    return email;
  }

  String getSenha() {
    return senha;
  }

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "CPF": CPF,
      "telefone": telefone,
      "nomeUsuario": nomeUsuario,
      "email": email,
      "senha": senha,
    };
  }
}
