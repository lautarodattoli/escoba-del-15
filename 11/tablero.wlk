import cartas.*

//Falta: eliminar repeticion linea 48, valor de cartas 10,11,12
object tablero{
	const mazo = []
	const jugadores = []
	const mesa = []
	var cartasarepartir =[]
	
	method limpiarMesa() = mesa.clear()
	method limpiarMazo() = mazo.clear()
	method eliminarCartaMesa(carta) = mesa.remove(carta)
	method eliminarCartaMazo(carta) = mazo.remove(carta)
	method cantidadMazo() = mazo.size()
	method cantidadMesa() = mesa.size()
	method cantidadJugadores() = jugadores.size()
	method mostrarMazo() =  mazo
	method mostrarMesa() =  mesa 
	method mostrarJugadores() = jugadores
	method conocerMano() = jugadores.find({jugador => jugador.detectarMano()})
	method ponerCartaMazo(carta) = mazo.add(carta) //metodo para caso de prueba no darle bola
	method anadirCartaMesa(carta) = mesa.add(carta)
	method verificarEscobadeMano()=(self.saberPuntajeMesa() == 15)
	method saberPuntajeMesa() = mesa.map({carta => carta.valorCarta()}).sum()
	method hacerMano() = jugadores.forEach({jugador => jugador.convertirMano()})
	method anadirJugadores(jugador) = jugadores.add(jugador)
	    
	method agarrarCarta(){
	cartasarepartir = mazo.anyOne()
	mazo.remove(cartasarepartir)
	return cartasarepartir
	}

	method repartirJugadores(){
	//	if(jugadores.any({jugador => jugador.cantidadManoJugador() >= 1}))
		(1..3).forEach({cartas => jugadores.forEach({jugador => jugador.anadirCartaMano(self.agarrarCarta())})})
		}
   
	method llenarMesa(){
	//	if(self.cantidadMesa() == 4)return false
	//	if(self.cantidadMazo() == 0)return false
		(1..4).forEach({cartas => self.anadirCartaMesa(self.agarrarCarta())})
		if(self.verificarEscobadeMano()) jugadores.filter({jugador => jugador.hayEscobadeMano()})
		}


method llenarMazoPalo() {
        const num =[1,2,3,4,5,6,7,10,11,12]
        num.forEach({ncarta => mazo.add(new Cartas(valor = ncarta, palo = "oro"))})
        num.forEach({ncarta => mazo.add(new Cartas(valor = ncarta, palo = "copa"))})
        num.forEach({ncarta => mazo.add(new Cartas(valor = ncarta, palo = "basto"))})
        num.forEach({ncarta => mazo.add(new Cartas(valor = ncarta, palo = "espada"))})
    }

	method contarPuntaje(){//Aca agregamos que el tablero pueda aplica los criterios de puntuación a los jugadores sin tener que hacerlo individualmente con cada jugador
		jugadores.forEach({jugador => 
			if(jugador.tengoMayorCantidadCartas()) jugador.sumarPuntaje()
			if(jugador.tengo7deVelo()) jugador.sumarPuntaje()
			if(jugador.OrtengoSetenta()) jugador.sumarPuntaje()
			if(jugador.tengoTodosos()){
				(1..2).forEach({x => jugador.sumarPuntaje()})
			}else if(jugador.tengoMayorCantidadOros()) jugador.sumarPuntaje()
		})
	}
	method finalizarRonda(){
		if(mazo.size() == 0){
			jugadores.forEach({jugador => jugador.levantarCartasAlTerminarRonda() and jugador.resetearEscobas()})
			self.contarPuntaje()
		}
	}
}
