package ejemplo.cajero.control;

import ejemplo.cajero.modelo.Banco;
import ejemplo.cajero.modelo.Cuenta;

/**
 * Comando usado para listar las cuentas 
 */
public class ComandoImprimirOperaciones implements Comando {

	@Override
	public String getNombre() {
		return "Imprimir operaciones del día";
	}

	@Override
	public void ejecutar(Banco contexto) throws Exception {

		System.out.println("Método no válido para este tipo de Cajero");
		
	}

}
