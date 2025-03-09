package main

import "core:fmt"

Animal :: struct {
	name: string,
	kind: union {
		^Cat,
		^Dog,
	},
}

Dog :: distinct struct {
	using animal: Animal,
	age:          u8,
}

Cat :: distinct struct {
	using animal: Animal,
	lives:        u8,
}

new_dog :: proc(name: string, age: u8) -> ^Dog {
	e := new(Dog)
	e.age = age
	e.kind = e
	return e
}

new_cat :: proc(name: string, lives: u8) -> ^Cat {
	e := new(Cat)
	e.lives = lives
	e.kind = e
	return e
}

speak_cat :: proc(cat: ^Cat) {
	fmt.printf("cat")
}

speak_dog :: proc(dog: ^Dog) {
	fmt.printf("dog")
}

main :: proc() {
	animals: [2]^Animal = {new_cat("Yolo", 17), new_dog("Rex", 7)}
	for animal in animals {
		switch e in animal.kind {
		case ^Dog:
			speak_dog(e)
		case ^Cat:
			speak_cat(e)
		}}
	// animals: [dynamic]Animal

	// append(&animals, Dog{name="Rex", age=10})
	// append(&animals, Cat{name="Mittens", lives=7})
	// fmt.printf("{}", animals)
	// for animal in &animals {
	//     switch e in animal.kind{
	//         case ^Dog: speak_dog(e.kind)
	//         case ^Cat: speak_cat(e.kind)
	//     }
	//     speak(animal)
	// }

}
