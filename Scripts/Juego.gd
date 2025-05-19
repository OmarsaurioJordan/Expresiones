extends Panel

var raiz = null
var relojFin = 40.0
var carasSeg = 0.6
var caritas = []
var puntos = [40, 40]

func _ready():
	raiz = get_parent()
	if raiz.modo == raiz.REC_RND:
		$Titulo.text = "Aleatorio"
	else:
		$Titulo.text = "Ordenado"
	ordenCaras()
	newCara()
	$CaraFrente.modulate.a = 0.0
	$Glow.modulate.a = 0.0

func ordenCaras():
	var tot = ceil(relojFin * carasSeg / 4.0)
	var ant = -1
	for lvl in range(4):
		for _t in range(tot):
			caritas.append(caraLevel(lvl, ant))
			ant = caritas[-1]

func caraLevel(level, anterior=-1):
	var cara
	while true:
		cara = randi_range(0, 5) * 4 + 3 - level
		if cara != anterior:
			break
	return cara

func _process(delta):
	var a = $CaraFrente.modulate.a
	if a != 0:
		$CaraFrente.modulate.a = max(0.0, a - delta * 2.0)
	a = $Glow.modulate.a
	if a != 0:
		$Glow.modulate.a = max(0.0, a - delta * 2.0)
	if relojFin != 0:
		relojFin -= delta
		if relojFin <= 0:
			relojFin = 0.0
			finalizacion()
		else:
			$Display.text = str(ceil(relojFin))

func finalizacion():
	$Botones.visible = false
	if puntos[raiz.modo] > raiz.record[raiz.modo]:
		raiz.record[raiz.modo] = puntos[raiz.modo]
		raiz.escribirMemoria()
	$Display.text = str(puntos[raiz.modo])
	if puntos[raiz.modo] != raiz.record[raiz.modo]:
		$Display.text += " / " + str(raiz.record[raiz.modo])
	$AudMusica.queue_free()
	$AudReloj.queue_free()

func _on_btn_menu_pressed():
	var aux = raiz.objMenu.instantiate()
	get_parent().add_child(aux)
	queue_free()

func seleccion(ind):
	var lvl = 3 - ($CaraFondo.frame - emocionAct() * 4)
	var pts = 8 + lvl * 2
	if ind == emocionAct():
		puntos[raiz.modo] += pts
		$Glow.modulate = Color(0, 1, 0, 1)
		$AudAcierto.play()
	else:
		puntos[raiz.modo] = max(0, puntos[raiz.modo] - pts)
		$Glow.modulate = Color(1, 0, 0, 1)
		$AudFallo.play()
	newCara()

func emocionAct():
	return floor($CaraFondo.frame / 4)

func newCara():
	$CaraFrente.setCara($CaraFondo.frame)
	$CaraFrente.modulate.a = 1.0
	if raiz.modo == raiz.REC_RND:
		newRnd()
	else:
		newOrd()
	print(floor($CaraFondo.frame / 4))

func newOrd():
	if caritas.is_empty():
		newRnd()
	else:
		$CaraFondo.setCara(caritas[0])
		caritas.remove_at(0)

func newRnd():
	var ant = $CaraFondo.frame
	while true:
		$CaraFondo.setCara(randi_range(0, 23))
		if $CaraFondo.frame != ant:
			break

func _on_btn_0_pressed():
	seleccion(0)

func _on_btn_1_pressed():
	seleccion(1)

func _on_btn_2_pressed():
	seleccion(2)

func _on_btn_3_pressed():
	seleccion(3)

func _on_btn_4_pressed():
	seleccion(4)

func _on_btn_5_pressed():
	seleccion(5)
