class Notificationd {
  String key;
  String nameAsesor;
  String visitas;
  String date; 
  Notificationd(
      this.nameAsesor,
      this.visitas,
      this.date);

  Notificationd.toShow(
      this.nameAsesor,
      this.visitas,
      this.date);

  Notificationd.namedConst(
      this.nameAsesor,
      this.visitas,
      this.date);
  Notificationd.toSave(
      this.nameAsesor,
      this.visitas,
      this.date);

  toJson() => {
        "nombreAsesor": nameAsesor,
        "numeroVisitas": visitas, 
        "fecha": date,
      };
} 