package types

import "core:os"
import "core:fmt"
import "core:math"
import "../utils"

Color3 :: [3]f32

COLOR_INTERVAL::Interval{0,1}

gamma_correction::proc(component: f32)->f32{
    return math.sqrt(component)
}

write_color::proc(color: Color3, handle: os.Handle){
    r:= interval_clamp(COLOR_INTERVAL, color.r)
    r=gamma_correction(r)
    g:= interval_clamp(COLOR_INTERVAL, color.g)
    g=gamma_correction(g)
    b:= interval_clamp(COLOR_INTERVAL, color.b)
    b=gamma_correction(b)
    ir, ig, ib := int(255.999 *r), int(255.999 * g), int(255.999 * b)
    fmt.fprintf(handle, "{} {} {}\n", ir, ig, ib)
}