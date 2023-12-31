package shapes

import "../types"

World :: struct {
	hittables: [dynamic]Hittable,
}

hit_world :: proc(world: World, r: types.Ray, interval: types.Interval) -> Maybe(types.Hit) {
	ret: Maybe(types.Hit)
	for hittable in world.hittables {
		hit := hit_hittable(hittable, r, interval)
		if hit != nil && (ret == nil || hit.?.distance < ret.?.distance) {
			ret = hit
		}
	}
    return ret
}
