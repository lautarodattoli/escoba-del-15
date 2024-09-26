object oro1 {
  var position = game.at(7,0.5)

  method position()= position

  var image  ="o1.png"

  method image() =image
}

object oro2 {
  var position = game.at(9,0.5)

  method position()= position

  var image ="o2.png"
  method image()=image
  
}


object oro7 {
  var position = game.at(11,0.5)

  method position()= position

  var image ="o7.png"
  method image()=image
  
}

object mazo {
  method position()= game.at(1,7)
  var image ="mazo.png"
  method image()=image
}

object pos1 {
   method position()= game.at(5,6)
  var image ="b3m.png"
  method image()=image
  
}
object pos2 {
   method position()= game.at(9,6)
  var image ="e7m.png"
  method image()=image
  
}
object pos3 {
   method position()= game.at(5,9)
  var image ="o6m.png"
  method image()=image
  
}
object pos4 {
  method position()= game.at(9,9)
  var image ="c12m.png"
  method image()=image
  
}
object versus {
  method position()= game.at(8,15)
  var image ="mano3.png"
  method image()=image
  
}