

class Nave{
	var velocidad = 0
	var direccion 
	var combustible= 0
	method estaTranquila(){return combustible >= 4000 and velocidad <= 12000}
	method cargarCombustible(litros){
		combustible = combustible + litros
	}
	method descargarCombustible(litros){
		combustible = combustible - litros
	}
	method acelerar(cuanto){
		velocidad = 100000.min(velocidad + cuanto )
	}
	method desacelerar(cuanto){
		velocidad=0.max(velocidad - cuanto )
	}
	method irHaciaElSol(){
		direccion = 10
	}
	method escaparDelSol(){
		direccion = -10
	}
	method ponerseParaleloAlSol(){
		direccion = 0
	}
	method acercarseUnPocoAlSol(){ direccion = 10.min(direccion +1)}
	method alejarseUnPocoAlSol(){ direccion = -10.max(direccion -1)}
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	method recibirAmenaza()
	method estaDeRelajo(){
		return self.estaTranquila()
	}
}

class NaveBaliza inherits Nave{
	var color
	var cambiosHechos = 0
	method cambiarColorDeBaliza(colorNuevo){
		color = colorNuevo
		cambiosHechos = cambiosHechos + 1
	}
	override method prepararViaje(){
		color = "verde"
		self.ponerseParaleloAlSol()
	}
	override method estaTranquila(){
		return super() and color != "rojo"
	}
	override method recibirAmenaza(){
		self.irHaciaElSol()
		self.cambiarColorDeBaliza("rojo")
	}
	override method estaDeRelajo(){
		return super() and cambiosHechos == 0
	}
}

class NavesPasajeros inherits Nave{
	var cantidadDePasajeros
	const cantRacionComida = []
	const cantRacionBebida = []
	const comidasServidas=[]
	method cargarComida(cant){
		cantRacionComida.add(cant)	
	}
	method descargarComida(cant){
		cantRacionComida.remove(cant)
		comidasServidas.add(cant)	
	}
	method cargarBebida(cant){
		cantRacionBebida.add(cant)	
	}
	method descargarBebida(cant){
		cantRacionBebida.remove(cant)	
	}
	override method prepararViaje(){
		self.cargarComida(4*cantidadDePasajeros)
		self.cargarBebida(6*cantidadDePasajeros)
		self.acercarseUnPocoAlSol()
	}
	override method recibirAmenaza(){
		self.acelerar(velocidad*2)
		self.descargarComida(1*cantidadDePasajeros)
		self.descargarBebida(2*cantidadDePasajeros)
	}
	override method estaDeRelajo(){
		return comidasServidas.size()<=50
	}
}
class NaveCombate inherits Nave{
	var estaInvisible
	var estanDesplegado
	const mensajes = []
	method ponerseVisible(){
		estaInvisible = false
	}
	method ponerseInvisible(){
		estaInvisible = true
	}
	method estaInvisible(){
		return estaInvisible
	}
	method desplegarMisiles(){
		estanDesplegado = true
	}
	method replegarMisiles(){
		estanDesplegado = false 
	}
	method misilesDesplegados(){
		return estanDesplegado
	}
	method emitirMensaje(mensaje){
		mensajes.add(mensaje)
	}
	method mensajesEmitidos(){
		mensajes.size()
	}
	method primerMensajeEmitido(){
		mensajes.first()
	}
	method ultimoMensajeEmitido(){
		mensajes.last()
	}
	method esEscueta(){
		return mensajes.all({m=>m.size()<30}) 
	}
	method emitioMensaje(mensaje){
		mensajes.contains(mensaje)
	}
	override method estaTranquila(){
		return super() and not self.misilesDesplegados()
	}
	override method prepararViaje(){
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("saliento en mision")
	}
	override method recibirAmenaza(){
		self.irHaciaElSol()
		self.irHaciaElSol()
		self.emitirMensaje("Amenaza recibida")
	}
	override method estaDeRelajo(){
		return
		super() and
		self.esEscueta()
	}
}

class NaveHospital inherits NavesPasajeros{
	var quirofanoListo
	method alistarQuirofano(){
		quirofanoListo = true
	}
	method quirofanoDesactivado(){
		quirofanoListo = false
	}
	method quierofanoListo(){
		return quirofanoListo
	}
	override method estaTranquila(){
		return not self.quierofanoListo()
	}
	override method recibirAmenaza(){
		super() 
		self.alistarQuirofano() 
	}
}

class NaveCombateSiguilosa inherits NaveCombate{
	override method estaTranquila(){
		return super() and not self.estaInvisible()
	}
	override method recibirAmenaza(){
		super() 
		self.desplegarMisiles()
		self.ponerseVisible()
	}
}







