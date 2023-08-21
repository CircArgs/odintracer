package main

import "core:fmt"

image_height :: 256
image_width :: 256

main :: proc() {
	fmt.printf("P3\n{} {}\n255\n", image_width, image_height)
    for j in f32(0.0)..<image_height{
        for i in f32(0.0)..<image_width{
            r, g, b :f32= i/(image_width-1), j/(image_height-1), 0

            ir, ig, ib := int(255.999*r), int(255.999*g), int(255.999*b)

            fmt.printf("{} {} {}\n", ir, ig, ib)
        }
    }
}
