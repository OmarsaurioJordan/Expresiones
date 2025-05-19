extends Panel

var relojAni = 0.0
var raiz = null

func _ready():
	raiz = get_parent()
	$RecordOrd.text = str(raiz.record[raiz.REC_ORD])
	$RecordRnd.text = str(raiz.record[raiz.REC_RND])

func _process(delta):
	relojAni -= delta
	if relojAni <= 0:
		relojAni += 0.333
		if $CaraAni.frame == 23:
			$CaraAni.setCara(0)
		else:
			$CaraAni.setCara($CaraAni.frame + 1)

func _on_btn_rnd_pressed():
	juegoModo(raiz.REC_RND)

func _on_btn_ord_pressed():
	juegoModo(raiz.REC_ORD)

func juegoModo(modo):
	raiz.modo = modo
	var aux = raiz.objJuego.instantiate()
	get_parent().add_child(aux)
	queue_free()
