package types

import "core:math"

Interval :: struct{
    min: f32,
    max: f32
}

interval_contains::proc(interval: Interval, v: f32)->bool{
    return v>=interval.min && v<=interval.max
}

interval_surrounds::proc(interval: Interval, v: f32)->bool{
    return v>interval.min && v<interval.max
}

default_interval::proc()->Interval{
    return Interval{0, math.inf_f32(1)}
}