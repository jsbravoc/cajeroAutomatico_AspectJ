package ejemplo.cajero.control;

import ejemplo.cajero.modelo.Banco;
import ejemplo.cajero.modelo.Cuenta;

/**
 * Comando usado para listar las cuentas 
 */
public class ComandoGenerarAuditoria implements Comando {

	@Override
	public String getNombre() {
		return "Generar archivo auditoría";
	}

	@Override
	public void ejecutar(Banco contexto) throws Exception {

		System.out.println("Método no válido para este tipo de Cajero");
		
	}

}
