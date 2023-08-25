package types

import "core:os"
import "core:fmt"
import "../utils"

Color3 :: [3]f32

COLOR_INTERVAL::Interval{0,1}

write_color::proc(color: Color3, handle: os.Handle){
    ir, ig, ib := int(255.999 * interval_clamp(COLOR_INTERVAL, color.r)), int(255.999 * interval_clamp(COLOR_INTERVAL, color.g)), int(255.999 * interval_clamp(COLOR_INTERVAL, color.b))
    fmt.fprintf(handle, "{} {} {}\n", ir, ig, ib)
}