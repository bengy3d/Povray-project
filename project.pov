#include "colors.inc"
#include "woods.inc"
#include "textures.inc"
#include "skies.inc"
#include "stones.inc"
#include "shapes.inc"

#declare MyGray = rgb<53/255, 58/255, 55/255>;

camera {
//    location <0, 7, 5>
//    look_at <0, 0, 5>
    //location <2.5, 2.5, 3> // camera wall near the window
    //look_at <-2.5, 0, 5> // camera wall near the window
    location <0, 2, -12>
    look_at <0, 1, 2>
}

sky_sphere { S_Cloud2 }

plane {
    <0, 1, 0>, 0
    pigment { Green }
}

#declare ground_ceiling = box {
    <-1, -1, -1>, <1, 1, 1>
    scale <0, 0.02, 0>
}

#declare wall = box {
    <-1, -1, -1>, <1, 1, 1>
    scale <0.02, 0, 0>
}

#declare window = intersection {
    object {
        box {
            <-1, -1, -1>, <1, 1, 1>
            translate 2.25 * y
            scale <0.25, 0.25, 0.5>
        }
    }
    object {
        wall
    }
}

// Wall with a hole
#declare wall_with_a_hole = difference {
    object {
        wall
    }
    object {
        box {
            <-1, -1, -1>, <1, 1, 1>
            translate 2.25 * y
            scale <0.25, 0.25, 0.5>
        }
    }
}

#declare sill = object {
    Round_Box(<-1, 0, -1>, <1, 2, 1>, 0.125, 0)
    scale <0.5, 0.02, 0.05>
    texture { T_Grnt20 scale .4}
}


#declare window_wall = merge {
    object {
        wall_with_a_hole 
        pigment { MyGray }
    }
    object {
        window
        texture { Glass }
    }
}

#declare bed = merge {
    // Base of the bed
    object {
        box {
            <-1, -1, -1>, <1, 1, 1>
        }
        texture { T_Wood2 }
        scale <0.5, 0.25, 0.25>
    }
    // Mattress
    object {
        Round_Box(<1, 1, 1>, <-1, -1, -1>, 0.125, 0)
        scale <0.45, 0.04, 0.23>
        pigment { White }
        translate <0, 0.25, 0>
        texture {
            pigment { color White }
            normal { bumps 1 scale 0.2 }
            finish { phong 1 }
        }
    }
    scale y * 0.8
    rotate 90*y
}

#declare room = merge {
    object { 
        ground_ceiling
        texture {
            DMFLightOak scale 0.5
            finish { phong 1 }
        }
    }
    object { 
        ground_ceiling
        pigment { White }
        translate <0, 1, 0>
    }
    object {
        window_wall
        rotate 90*y
        translate <0, 0, 1>
    }
    object {
        sill
        translate <0, 0.27, 0.95>
    }
    object {
        wall
        pigment { White }
        rotate 90*x
        translate <1, 0, 0>
    }
    object {
        wall
        pigment { White }
        rotate 90*x
        translate <-1, 0, 0>
    }
    object {
        bed
        translate <-0.72, 0, 0.5>
    }
}

object {
    room
    scale 5
}

#declare Lightbulb = union {
    merge {
        sphere { <0, 0, 0>, 1 }
        cylinder {
            <0, 0, 1>, <0, 0, 0>, 1
            scale <0.35, 0.35, 1.0>
            translate 0.5*z
        }
        texture {
            pigment { color rgb<1, 1, 1> }
            finish { ambient .9 diffuse .6 }
        }
    }
    cylinder {
        <0, 0, 1>, <0, 0, 0>, 1
        scale <0.4, 0.4, 0.5>
        texture { Brass_Texture }
        translate 1.5*z
    }
    rotate -90 * x
    scale .2
}

light_source {
    <0, 4, 0>
    color White
    area_light <1, 0, 0>, <0, 1, 0>, 2, 2
    jitter
    looks_like { Lightbulb }
}