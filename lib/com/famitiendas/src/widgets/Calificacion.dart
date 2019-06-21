class Calification {
  String key;
  String nameClient;
  String codeClient;
  String date;
  List<String> listResp; 
  Calification(
      this.nameClient,
      this.codeClient,
      this.date,
      this.listResp);

  Calification.toShow(
      this.nameClient,
      this.codeClient,
      this.date,
      this.listResp);

  Calification.namedConst(
      this.nameClient,
      this.codeClient,
      this.date,
      this.listResp);
  Calification.toSave(
      this.nameClient,
      this.codeClient,
      this.date,
      this.listResp);

  toJson() => {
        "nameClient": nameClient,
        "codeClient": codeClient,
        "listResp": listResp,
        "date": date,
      };
}

class Respuestas{
  String pregunta;
  String valor;

  Respuestas(this.pregunta,this.valor);

Respuestas.toSave(
      this.pregunta,
      this.valor);

  toJson() => {
        "pregunta": pregunta,
        "valor": valor
      };
}