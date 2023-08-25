package utils

import "core:fmt"
import "core:math/rand"

print_progress :: proc(p: f32) {
	pcnt := u32(p * 100)
	for i in 0 ..= pcnt {
		fmt.print('=')
	}
	fmt.printf(" {}%%\r", pcnt)
}

random_range::proc(min:f32 = 0.0, max:f32 = 1.0)->f32{
    return rand.float32()*(max-min)+min
}