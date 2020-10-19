import java.io.File;
import java.io.FileWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Scanner;

public aspect GenerarArchivoAuditoria {

	
ArrayList<String> logs = new ArrayList<String>();

pointcut metodosControl() : call( * ejemplo.cajero.control.Comando..*(..));
pointcut metodoImprimirOperaciones() : execution(* ejemplo.cajero.control.ComandoGenerarAuditoria.ejecutar(..));

before(): metodosControl() {
	if(thisJoinPoint.getSignature().getName().contains("getNombre"))
		return;
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
	   LocalDateTime now = LocalDateTime.now(); 
	   try {
		   String log = "[" + dtf.format(now) + "] Realizando operación : " + thisJoinPoint.getTarget().toString().split("ejemplo.cajero.control.")[1].substring(0, thisJoinPoint.getTarget().toString().split("ejemplo.cajero.control.")[1].lastIndexOf("@"));
			logs.add(log);
	} catch (Exception e) {
		// TODO: handle exception
	}
	
  }

after(): metodosControl() {
	if(thisJoinPoint.getSignature().getName().contains("getNombre"))
		return;
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
	   LocalDateTime now = LocalDateTime.now();
	   try {
		   String log = "[" + dtf.format(now) + "] Operación finalizada: " + thisJoinPoint.getTarget().toString().split("ejemplo.cajero.control.")[1].substring(0, thisJoinPoint.getTarget().toString().split("ejemplo.cajero.control.")[1].lastIndexOf("@"));
			logs.add(log);
	} catch (Exception e) {
		// TODO: handle exception
	}
	
  }

void around(): metodoImprimirOperaciones () {
	System.out.println("Escriba el nombre del archivo a generar: ");
	Scanner console = new Scanner(System.in);			
	String valorIngresado = console.nextLine();
	try {
		File archivo = new File(valorIngresado);
		FileWriter myWriter = new FileWriter(valorIngresado);
		for (String string : logs) {
			myWriter.write(string +"\n");
		}
		  myWriter.close();
	} catch (Exception e) {
		System.out.println(e);
	}
}
}