extends Node2D

func _ready():
	pass

func play():
	$ParticleAnimation.play("star_particle")

func particle_visible():
	$ParticleAnimation.visible = true
