resource "random_string" "rand-str" {
	length = 21
	special = true
	override_special = "<>[]{!@$#%&*_+=-"
}

output "rand-str" {
	value=random_string.rand-str[*].result
}