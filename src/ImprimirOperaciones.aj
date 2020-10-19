import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;


public aspect ImprimirOperaciones {
	ArrayList<String> logs = new ArrayList<String>();
	

	pointcut metodosControl() : call( * ejemplo.cajero.control.Comando..*(..));
	pointcut metodoImprimirOperaciones() : execution(* ejemplo.cajero.control.ComandoImprimirOperaciones.ejecutar(..));
	
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
		for (String string : logs) {
			System.out.println(string);
		}
	}
	
}