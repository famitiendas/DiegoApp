class NotificationData{

    String fecha;
    String nombreAsesor;
    int numeroVisitas;



    NotificationData(this.fecha,this.nombreAsesor,this.numeroVisitas);

      toJson()=>{
        "fecha": fecha,
        "nombreAsesor":nombreAsesor,
        "numeroVisitas":numeroVisitas
      };


}