package main

import "core:fmt"
import "core:io"
import "core:os"

image_height :: 256
image_width :: 256
tot_pixels :: image_height*image_width
// progress::proc(i: u32){
//     for n in 0..=i{
//         fmt.print("=")
//     }
//     io.flush(os.stdout)
// }

main :: proc() {
    f, err := os.open("image.ppm", mode = os.O_WRONLY)
    if err != os.ERROR_NONE {
        fmt.eprintln("Could not open directory for writting", err)
        os.exit(2)
    }
    defer os.close(f)

	fmt.fprintf(f, "P3\n{} {}\n255\n", image_width, image_height)
    
    for j in f32(0.0)..<image_height{
        for i in f32(0.0)..<image_width{
            r, g, b :f32= i/(image_width-1), j/(image_height-1), 0

            ir, ig, ib := int(255.999*r), int(255.999*g), int(255.999*b)

            fmt.fprintf(f, "{} {} {}\n", ir, ig, ib)
            // progress(u32())
        }
    }
}
