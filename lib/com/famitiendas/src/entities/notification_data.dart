class NotificationData{

    String fecha;
    String nombreAsesor;
    int numeroVisitas;
    String vendedor;


    NotificationData(this.fecha,this.nombreAsesor,this.numeroVisitas,this.vendedor);
    NotificationData.toSave(this.fecha,this.nombreAsesor,this.numeroVisitas,this.vendedor);

      toJson()=>{
        "fecha": fecha,
        "nombreAsesor":nombreAsesor,
        "numeroVisitas":numeroVisitas,
        "vendedor":vendedor
      };


}