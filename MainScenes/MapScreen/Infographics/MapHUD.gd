extends HBoxContainer

onready var wallet_label = $Wallet/Amount
onready var coal_label = $Coal/Amount
onready var scrap_label = $Scrap/Amount
onready var ammo_label = $Ammo/Amount

func update_display()->void:
	wallet_label.set_text("%s" % Global.money)
	coal_label.set_text("%s" % Global.coal)
	scrap_label.set_text("%s " % Global.scrap)
	ammo_label.set_text("%s" % Global.ammo)
