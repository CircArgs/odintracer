package main

import "core:fmt"

print_progress :: proc(p: f32) {
	pcnt := u32(p * 100)
	for i in 0 ..= pcnt {
		fmt.print('=')
	}
	fmt.printf(" {}%%\r", pcnt)
}