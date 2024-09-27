
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
		if(jugadores.any({jugador => jugador.cantidadManoJugador() >= 1})) return false
		(1..3).forEach({cartas => jugadores.forEach({jugador => jugador.anadirCartaMano(self.agarrarCarta())})})
		return true
		}
	method llenarMesa(){
		if(self.cantidadMesa() == 4)return false
		if(self.cantidadMazo() == 0)return false
		(1..4).forEach({cartas => self.anadirCartaMesa(self.agarrarCarta())})
		if(self.verificarEscobadeMano()) return jugadores.filter({jugador => jugador.hayEscobadeMano()}) //Aca se verifica luego de repartir las cartas a la mesa, si hay escoba de mano o no
		return true
		}

	method contarPuntaje(){//Aca agregamos que el tablero pueda aplica los criterios de puntuación a los jugadores sin tener que hacerlo individualmente con cada jugador
		jugadores.forEach({jugador => 
			if(jugador.tengoMayorCantidadCartas()) jugador.sumarPuntaje()
			if(jugador.tengo7deVelo()) jugador.sumarPuntaje()
			if(jugador.tengoSetenta()) jugador.sumarPuntaje()
			if(jugador.tengoTodosOros()){
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
	//metodo unicamente para el caso de pruebas
	method dar40cartas(jugador) = (1..40).forEach({carta => jugador.ponerCartasMonto(self.agarrarCarta())})
}


 class Cartas{
	const valor
	const palo
	var nombrevalor
	var nombrepalo
	method valorCarta() = valor
	method paloCarta() = palo
	method nombreCarta(){
		const valores = ["As","Dos","Tres","Cuatro","Cinco","Seis","Siete","Sota","Caballo","Rey"]
		nombrevalor = valores.get(valor)
		if(palo == "oro") nombrepalo = " de Oro"	
		if(palo == "basto") nombrepalo = " de Basto"	
		if(palo == "espada") nombrepalo = " de Espada"
		if(palo == "copa") nombrepalo = " de Copa"	
		return nombrevalor + nombrepalo 
		} 
} 

/*
class Jugador{
	const manojugador = []
	const montojugador = []
	const cartasLevantadas = []
	var mano = false
	var puntaje = 0
	var escobas = 0
	var idjugador		

	method idJugador() = idjugador
	method mostrarManoJugador() = manojugador
	method mostrarMontoJugador() =  montojugador 
	method cantidadMontoJugador() = montojugador.size()
	method cantidadManoJugador() = manojugador.size()
	method anadirCartaMonto(carta) = montojugador.add(carta)
	method anadirVariasCartasMonto(carta) = montojugador.addAll(carta)
	method eliminarCartaMano(carta) = manojugador.remove(carta)
	method anadirCartaMano(carta) = manojugador.add(carta)
	method puntajeJugador() = puntaje
	method detectarMano() = return mano
	method limpiarCartasLevantadas() = cartasLevantadas.clear()
	method cartasLevantadas() = cartasLevantadas
	method anadirCartasLevantadas(carta) = cartasLevantadas.add(carta)
	method cantidadEscobas() = escobas
	method saberPuntaje() = puntaje
	method ponerCartasMonto(carta) = montojugador.add(carta) // metodo solo para caso de prueba
	method sumarPuntaje() = puntaje++
        method resetearEscobas() = escobas = 0
	
	method convertirMano(){
		if(tablero.mostrarJugadores().copyWithout(tablero.mostrarJugadores().find({jugador => 
		jugador.idJugador() == self.idJugador()})).any({jugador => jugador.detectarMano()})) return false
	    if(mano) mano = false
	    else if(not mano) mano = true   //Corregimos el convertir al jugador en mano con tu recomendación. No pusimos el not mano ya que no convertia el atributo a fslso.
	    return true
	}
	method tirarCarta(carta){
   	self.eliminarCartaMano(carta)
   	tablero.anadirCartaMesa(carta)
   	return true
   }
	method levantarCarta(carta){
   	if(tablero.mostrarMesa().any({ccarta => ccarta.nombreCarta() == carta.nombreCarta()})){
   		self.anadirCartasLevantadas(carta)
   		tablero.eliminarCartaMesa(carta)
   	}else return false
   	return true
   	}
	method agarrarCartaMazo(carta){
		if(self.cantidadManoJugador() == 3)return false
		if(tablero.cantidadMazo() == 0)return false
		self.anadirCartaMano(carta)
		tablero.eliminarCartaMazo(carta)
		return true
		}
		
		
	method hayEscobadeMano(){//Este metodo devuelve true o false y la verificación se hace en el tablero
			if(self.detectarMano()){
				self.anadirVariasCartasMonto(tablero.mostrarMesa())
				tablero.limpiarMesa()
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

  /* //Esta es la parte del bot con sus respectivos metodos y atributos para que pueda jugar contra el jugador
  object bot inherits Jugador(0){
  	const jugadasDisponibles = []
  	const jugadasFiltradas = []
  	
  	method verJugadas() = jugadasDisponibles
  	method anadirJugadas(jugada) = jugadasDisponibles.add(jugada)
    method devolverCartaMano(carta) = return self.mostrarManoJugador().get(carta)
    method devolverCartaMesa(carta) = return tablero.mostrarMesa().get(carta)
    method buscarJugadas(){
    	const cartasMesa = []
   	(0..self.cantidadManoJugador()).forEach({x =>
   		cartasMesa.clear()
   		(0..tablero.cantidadMesa()).forEach({y =>
   			cartasMesa.add(self.devolverCartaMesa(y))
   			if(self.devolverCartaMano(x) + cartasMesa.map({carta => carta.valorCarta()}).sum() == 15){
   				if(not jugadasDisponibles.any({jugada => jugada == [self.devolverCartaMano(x),cartasMesa]}))		
   				self.anadirJugadas([self.devolverCartaMano(x),cartasMesa].flatten())
   			}
   		})
   	})
   }
   method elegirJugada(){
   	if(jugadasDisponibles.isEmpty()) return false
   	jugadasDisponibles.forEach({jugada => 
   		
   		if(self.hayTodosOros(jugada)){
   			return jugada
   		}
   		if(self.hayOros(jugada) and self.hay7deVelo(jugada)){
   			return jugada
   		}
   		if(self.hayOros(jugada) or self.hay7deVelo(jugada) or self.haySetenta(jugada)){
   			if(not jugadasFiltradas.any({jjugada => jjugada == jugada})){
   				jugadasFiltradas.add(jugada)
   			}
   		}
   	})
   	return if(not jugadasFiltradas.isEmpty()) jugadasFiltradas.anyOne() else jugadasDisponibles.anyOne()
   }
   method hacerJugada(){
   	if(self.detectarMano()){
   	 if(not self.elegirJugada()) return self.tirarCarta(self.mostrarManoJugador().anyOne())
   	 self.eliminarCartaMano(self.elegirJugada().get(0))
   	 tablero.eliminarCartaMesa(self.elegirJugada().copyWithout(self.elegirJugada().get(0)))
   	 self.anadirCartaMonto(self.elegirJugada().get(0))
   	 self.anadirVariasCartasMonto(self.elegirJugada().copyWithout(self.elegirJugada().get(0)))
   	 escobas = escobas + 1
   	 tablero.hacerMano()
   	 }
   	 return true
   }
   method hayMayorCantidadCartas(){
   		return jugadasDisponibles.map({jugada => jugada.size()}).sortBy{jugada1, jugada2 => jugada1 > jugada2}.get(0)
   }
   method hay7deVelo(jugada) = return (jugada.any({carta => carta.valorCarta() == 7 and carta.paloCarta() == "oro"}))
   method hayOros(jugada) = return (jugada.any({carta => carta.paloCarta() == "oro"}))   
   method hayTodosOros(jugada) = return (jugada.all({carta => carta.paloCarta() == "oro"}))
   method haySetenta(jugada) = return (jugada.any({carta => carta.valorCarta() == 7})) 
  }
*/