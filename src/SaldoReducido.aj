import java.util.Scanner;

import ejemplo.cajero.modelo.Banco;
import ejemplo.cajero.modelo.Cuenta;

public aspect SaldoReducido {
	pointcut metodoRetirar(Banco a) : execution(* ejemplo.cajero.control.ComandoRetirar.ejecutar(..)) && args(a);
	pointcut metodoTransferir(Banco a) : execution(* ejemplo.cajero.control.ComandoTransferir.ejecutar(..)) && args(a);

	 void around(Banco arg) throws Exception : (metodoRetirar(arg)) && if(ejemplo.cajero.Cajero.opciones.getProperty("saldo_reducido", "false").equals("true")) {
		
		System.out.println("Retiro de Dinero");
		System.out.println();
		
		// la clase Console no funciona bien en Eclipse
		Scanner console = new Scanner(System.in);			
		
		// Ingresa los datos
		System.out.println("Ingrese el número de cuenta");
		String numeroDeCuenta = console.nextLine();
		
		Cuenta cuenta = arg.buscarCuenta(numeroDeCuenta);
		if (cuenta == null) {
			throw new Exception("No existe cuenta con el número " + numeroDeCuenta);
		}
		
		if(cuenta.getSaldo()<2000)
		{
			throw new Exception("La cuenta seleccionada tiene un saldo menor a $2000.");
		}
		
		System.out.println("Ingrese el valor a retirar");
		String valor = console.nextLine();
	
		try {
			long valorNumerico = Long.parseLong(valor);
			cuenta.retirar(valorNumerico);
		
		} catch (NumberFormatException e) {
			throw new Exception("Valor a retirar no válido : " + valor);
		}
	}
	
void around(Banco arg) throws Exception : (metodoTransferir(arg)) && if(ejemplo.cajero.Cajero.opciones.getProperty("saldo_reducido", "false").equals("true")) {
		
	System.out.println("Transferencia de Dinero");
	System.out.println();
	
	// la clase Console no funciona bien en Eclipse
	Scanner console = new Scanner(System.in);			
	
	// Ingresa los datos
	System.out.println("Ingrese el número de cuenta origen");
	String numeroCuentaOrigen = console.nextLine();
	
	Cuenta cuentaOrigen = arg.buscarCuenta(numeroCuentaOrigen);
	if (cuentaOrigen == null) {
		throw new Exception("No existe cuenta con el número " + numeroCuentaOrigen);
	}
	if(cuentaOrigen.getSaldo()<2000)
	{
		throw new Exception("La cuenta seleccionada tiene un saldo menor a $2000.");
	}

	System.out.println("Ingrese el número de cuenta destino");
	String numeroCuentaDestino = console.nextLine();
	
	Cuenta cuentaDestino = arg.buscarCuenta(numeroCuentaDestino);
	if (cuentaDestino == null) {
		throw new Exception("No existe cuenta con el número " + numeroCuentaDestino);
	}
	
	System.out.println("Ingrese el valor a transferir");
	String valor = console.nextLine();

	try {
		
		// se retira primero y luego se consigna
		// si no se puede retirar, no se hace la consignación
		
		long valorNumerico = Long.parseLong(valor);
		cuentaOrigen.retirar(valorNumerico);
		cuentaDestino.consignar(valorNumerico);
	
	} catch (NumberFormatException e) {
		throw new Exception("Valor a transferir no válido : " + valor);
	}
	}
}