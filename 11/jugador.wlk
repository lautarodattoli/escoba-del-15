import cartas.*
import tablero.*

class Jugador{
	const manojugador = []
	const montojugador = []
	const cartasLevantadas = []
	var mano = false
	var puntaje = 0
	var escobas = 0
	//var idjugador

//method idJugador() = idjugador
	method mostrarManoJugador() = manojugador
	method mostrarMontoJugador() = montojugador 
	method cantidadMontoJugador() = montojugador.size()
	method cantidadManoJugador() = manojugador.size()
	method anadirCartaMonto(carta) = montojugador.add(carta)
	method anadirVariasCartasMonto(cartas) = montojugador.addAll(cartas)
	method eliminarCartaMano(carta) = manojugador.remove(carta)
	method anadirCartaMano(carta) = manojugador.add(carta)
	method puntajeJugador() = puntaje
	method detectarMano() = mano
	method limpiarCartasLevantadas() = cartasLevantadas.clear()
	method mostrarCartasLevantadas() = cartasLevantadas
	method anadirCartasLevantadas(carta) = cartasLevantadas.add(carta)
	method cantidadEscobas() = escobas
	//method saberPuntaje() = puntaje
	method sumarPuntaje() = puntaje+1
    method resetearEscobas() {escobas = 0}
	
	/*  method convertirMano(){
		if(tablero.mostrarJugadores().copyWithout(tablero.mostrarJugadores().find({jugador => 
		jugador.idJugador() == self.idJugador()})).any({jugador => jugador.detectarMano()})) return false
	    return !mano
	 }  */

	method tirarCarta(carta){
   	self.eliminarCartaMano(carta)
   	tablero.anadirCartaMesa(carta)
   }

	method levantarCarta(carta){
   	if(tablero.mostrarMesa().any({_carta => {_carta.paloCarta() == carta.paloCarta() && _carta.valorCarta() == carta.valorCarta()}})){
   		self.anadirCartasLevantadas(carta)
   		tablero.eliminarCartaMesa(carta)
   	}
   	}
		
	method hayEscobadeMano(){//Este metodo devuelve true o false y la verificación se hace en el tablero
			if(self.detectarMano()){
				self.anadirVariasCartasMonto(tablero.mostrarMesa())
				tablero.limpiarMesa()
				//Puede ser que falta aumentar en uno a la escoba
				return true
			}
		return false
	}
//Pusimos que los verificadores de puntaje devuelvan true o false
   	method tengoMayorCantidadCartas() = return (self.cantidadMontoJugador() > 20)
	   
    method tengo7deVelo() = return (montojugador.any({carta => carta.valorCarta() == 7 and carta.paloCarta() == "oro"}))

    method tengoMayorCantidadOros(){
   		if(montojugador.any({carta => carta.paloCarta() == "oro"})){
   				return (montojugador.filter({carta => carta.paloCarta() == "oro"}).size() > 5)
   		}
   		return false
   	}
   	method tengoTodosOros(){
   		if(montojugador.any({carta => carta.paloCarta() == "oro"})){
   				return (montojugador.filter({carta => carta.paloCarta() == "oro"}).size() == 10)                   
   		 }
   	return false
   }
   method tengoSetenta(){
   		if(montojugador.any({carta => carta.valorCarta() == 7})){
   				return (montojugador.filter({carta => carta.valorCarta() == 7}).size() > 2)		
   		}
   	return false
   }
   //Agregamos los metodos de tengoCarta y hayJugada, para verificar si el jugador tiene la carta y la jugada es valida
   method hayJugada(carta) = return (carta.valorCarta() + cartasLevantadas.map({x => 
   	x.valorCarta()}).sum() == 15)
   	method tengoCarta(carta) = return (manojugador.any({ccarta => ccarta.valorCarta() == carta.valorCarta() and ccarta.paloCarta() == carta.paloCarta()}))
	
   method verificarJugada(carta){
   	if(self.tengoCarta(carta)){
		if(self.hayJugada(carta)){
			return true 
		}
		else{
			tablero.anadirCartaMesa(cartasLevantadas)
			self.limpiarCartasLevantadas()
			return false
		}
	}
	return false
}
   method jugada(carta){
   	if(self.detectarMano()){
   	if(self.tengoCarta(carta)){
   		if(self.verificarJugada(carta)){
   			self.anadirCartaMonto(carta)
   			self.anadirVariasCartasMonto(cartasLevantadas)
   			self.limpiarCartasLevantadas()
   			self.eliminarCartaMano(carta)
             escobas = escobas + 1
   			tablero.hacerMano()
   			return true
   		}
   		return false
   	}
   	return false
   	}
   	return false
   }
   method levantarCartasAlTerminarRonda(){
   		if(self.detectarMano()){
   			self.anadirVariasCartasMonto(tablero.mostrarMesa())
   			tablero.limpiarMesa()
   			return true
   			}
   			return false
   		}
   		
  }