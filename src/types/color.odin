package types

import "core:os"
import "core:fmt"

Color3 :: [3]f32

write_color::proc(color: Color3, handle: os.Handle){
    ir, ig, ib := int(255.999 * color.r), int(255.999 * color.g), int(255.999 * color.b)
    fmt.fprintf(handle, "{} {} {}\n", ir, ig, ib)
}