package utiles;

import java.util.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 * Aquí se encontraran todas las funciones que produciran el funcionamiento de nuestra aplicación
 * @author RMGSB
 */
public class ModeloDatos {

    private Connection conexion;
    private Statement mandato;
    private ResultSet resultado;

    public Connection getConexion() {
        return conexion;
    }

    public void setConexion(Connection conexion) {
        this.conexion = conexion;
    }

    public Statement getMandato() {
        return mandato;
    }

    public void setMandato(Statement mandato) {
        this.mandato = mandato;
    }

    public ResultSet getResultado() {
        return resultado;
    }

    public void setResultado(ResultSet resultado) {
        this.resultado = resultado;
    }
    
    
    
    public void obtenerVuelos() {
        try {
            mandato = conexion.createStatement();
            resultado = mandato.executeQuery("SELECT * FROM public.trayecto;");
        } catch (SQLException ex) {
            Logger.getLogger(ModeloDatos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            System.out.println("Ha ocurrido un error al encontrar los vuelos ");
        }
    }
    
    public void ObtenerVuelosPorPersona(String DNI, int dineroVuelo) {
    try {
            mandato = conexion.createStatement();
            DNI = DNI;
            
            dineroVuelo = dineroVuelo;
            resultado = mandato.executeQuery("SELECT compras_totales FROM public.usuarios WHERE DNI="+DNI+";");
            
            if(resultado % 3 == 0)
            {
            	dineroVuelo = dineroVuelo / 2;
            }
            else
            {
            	dineroVuelo = dineroVuelo;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ModeloDatos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            System.out.println("Ha ocurrido un error al encontrar los vuelos ");
        }
    }
    
    public void obtenerEstadisticas() {
        try {
            mandato = conexion.createStatement();
            resultado = mandato.executeQuery("SELECT * FROM public.compras;");
        } catch (SQLException ex) {
            Logger.getLogger(ModeloDatos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            System.out.println("Ha ocurrido un error al encontrar los vuelos ");
        }

    }
    
    //Obtener los billetes con origen, destino y fecha
    public void obtenerBilletes(String o, String d,String fi, String fv){
        try {
            mandato = conexion.createStatement();
            //pasamos la fecha en string a la fecha en formato datetime
            String f = fi.replace('/','-');
            if ((fv == null) || fv.equals("")){
                //where the_timestamp_column::date = date ... -> como hemos puesto que la fecha es
                //un timestamp y necesitamos comparar solo el día, no la hora, hacemos un cast
                resultado = mandato.executeQuery("SELECT * FROM trayecto where plazas>0 and aer_origen = '" + o + "' and aer_destino = '" + d + "' and fecha::timestamp::date = '" + f+"'");
                
            }
            //si se ha puesto fecha de vuelta
            else{
                String fida = fi.replace('/','-');
                String fvu = fv.replace('/','-');
                //aer_origen in ('Barcelona','Madrid') and aer_destino in ('Madrid','Barcelona') and fecha::timestamp::date in ('2019-01-15', '2019-01-30
                resultado = mandato.executeQuery("SELECT * FROM trayecto where plazas>0 and aer_origen in ( '" + o + "', '"+d+"') and aer_destino in ( '" + o + "', '"+d+"') and fecha::timestamp::date in ( '" + fida + "', '"+fvu+"')");//and aer_destino = '" + o + "' and fecha::timestamp::date = '" + fvu+"'");//and aer_origen = '" + d + "'!and aer_destino = '" + o + "' and fecha::timestamp::date = '" + fvu+"' order by fecha desc");
            }  
        }
         catch (SQLException ex) {
            Logger.getLogger(ModeloDatos.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (NullPointerException nw){
            System.out.println("NPE: " + nw);
        }
        catch (Exception e) {
            System.out.println("Ha ocurrido un error al encontrar los vuelos: "+e);
        }
    }
    
    //si compra un billete de avión, se le debe mostrar un resguardo en pdf _< hay que coger los valores de la sesión
    public void imprimierBillete(){
        Document document = new Document();
        String ide = generarIdentificador(alfanum);
        String DEST = "C:\\Users\\solea\\Desktop\\Arquitectura y diseño de sistemas web\\Práctica\\PracticaFinal\\ResguardosBilletes\\"+ide+".pdf";
        
        //De los valores de la sesión metemos en la bd el billete  ya comprado, con id_usuario el DNI del usuario identificado
        //VEEEEEEEEEEEEEEEEEEEEERRRRRR
        try {
            mandato = conexion.createStatement();
            //pasamos la fecha en string a la fecha en formato datetime
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy/dd/MM");
            //como ya se ha comprado el billete lo metemos en la base de datos. Habria que coger de algun lado esos valores
            String q = "INSERT INTO Billete (aer_origen,aer_destino,fecha,identificador,id_usuario) values(meter los valores)";
            resultado = mandato.executeQuery(q);
        }
         catch (SQLException ex) {
            Logger.getLogger(ModeloDatos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            System.out.println("Ha ocurrido un error al encontrar los vuelos");
        }
        
        try{
            PdfWriter.getInstance(document,new FileOutputStream(DEST));
            document.open();
            //Creamos un párrafo nuevo llamado "vacio1" para espaciar los elementos.
            Paragraph vacio1 = new Paragraph();
            vacio1.add("\n\n");
            document.add(vacio1);

            //Declaramos un texto llamado "titulo" como Paragraph. 
            //Le podemos dar formato alineado, tamaño, color, etc.
            Paragraph titulo = new Paragraph();
            titulo.setAlignment(Paragraph.ALIGN_RIGHT);
            titulo.setFont(FontFactory.getFont("Times New Roman", 20, Font.BOLD, BaseColor.BLUE));
            titulo.add("RESGUARDO DEL BILLETE");
            document.add(titulo);
            
            Paragraph saltolinea1 = new Paragraph();
            saltolinea1.add("\n\n");
            document.add(saltolinea1);
            
            Paragraph nom = new Paragraph("Estimado/a Nombre Apellidos");
            document.add(nom);
            Paragraph par = new Paragraph("Gracias por elegir FINALWEB para su viaje.");
            document.add(par);
            Paragraph o = new Paragraph("Todas las horas indicadas son hora local. Por favor, mantega este billete con usted durante su viaje.");
            document.add(o);
            document.add(saltolinea1);
            Paragraph note = new Paragraph();
            note.setFont(FontFactory.getFont("Times New Roman", 8, Font.BOLD, BaseColor.RED));
            note.add("Para evitar problemas mientras realiza una compra en nuestra web, por favor confirme todos los detalles de la tarjeta de crédito que va a usar para la compra. También conuslte con su insitución financiera sobre las condiciones de comprar fuera de su lugar de residencia, compras internacionales y compras online. FINALWEB no es responsable si su insitución financiera rechaza autorizar el pago de su reserva.");
            document.add(note);
            document.add(saltolinea1);
            
            PdfPTable table = new PdfPTable(5);
            //Añadimos los títulos a la tabla. 
            Paragraph columna1 = new Paragraph("NOMBRE");
            columna1.getFont().setStyle(Font.BOLD);
            columna1.getFont().setSize(10);
            //columna1.setColspan(2);
            table.addCell(columna1);

            Paragraph columna2 = new Paragraph("IDENTIFICADOR");
            columna2.getFont().setStyle(Font.BOLD);
            columna2.getFont().setSize(10);
            table.addCell(columna2);

            Paragraph columna3 = new Paragraph("ORIGEN");
            columna3.getFont().setStyle(Font.BOLD);
            columna3.getFont().setSize(10);
            table.addCell(columna3);

            Paragraph columna4 = new Paragraph("DESTINO");
            columna4.getFont().setStyle(Font.BOLD);
            columna4.getFont().setSize(10);
            table.addCell(columna4);

            Paragraph columna5 = new Paragraph("FECHA");
            columna5.getFont().setStyle(Font.BOLD);
            columna5.getFont().setSize(10);
            table.addCell(columna5);
            
            //Añadimos datos de prueba, aquí se deberían sacar de la sesión
            //cons = mandato.executeQuery("Select nombre from usuarios where DNI = usuario_identificado")
            table.addCell("Carmen Alvargonzalez"); //poner el nombre de la persona que está iniciando sesión, cona
            table.addCell(ide); //identificador ya creado
            table.addCell("Madrid"); //aeropuerto origen que habria que pasar por parametro
            table.addCell("Barcelona"); //aeropuerto destino que habria que pasar por parametro
            table.addCell("20/10/2019 15:25"); //fecha que habria que pasar por parametro
            
            
            document.add(table);
            document.close();
        }
        catch (Exception e){
            System.out.println("Error al crear el archivo");
        }
    }
    
    //Se crea el identificador para el billete
    public static String generarIdentificador(String an){
        String ide="";
        for (int i=0; i<=5; i++){
            int numero = (int) (Math.random() * 36);
            //System.out.println(numero);
            ide=ide + an.charAt(numero);
            //System.out.println(ide);
        }
        //System.out.println(ide);
        return ide;
    }
    
    public void abrirConexion() {

        try {
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5432/PECLWeb", "postgres", "ruben");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ModeloDatos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ModeloDatos.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            System.out.println("Ha ocurrido un error al conectarse a la BD");
        }

    }

    public void cerrarConexion() {
        try {
            conexion.close();
        } catch (Exception e) {
            System.out.println("Ha ocurrido un error al cerrar la conexión.");
        }
    }

}
