#include "colors.inc"
#include "stones.inc"
#include "textures.inc"

#declare MyGray = rgb<53/255, 58/255, 55/255>;

camera {
//    location <0, 7, 5>
//    look_at <0, 0, 5>
    location <0, 2, -12>
    look_at <0, 1, 2>
}

background { SkyBlue }

plane {
    <0, 1, 0>, 0
    texture { Cork }
}

#declare ground_ceiling = box {
    <-1, -1, -1>, <1, 1, 1>
    scale <0, 0.02, 0>
}

#declare wall = box {
    <-1, -1, -1>, <1, 1, 1>
    scale <0.02, 0, 0>
}

#declare room = merge {
    object { 
        ground_ceiling
        texture { DMFLightOak scale 0.5 }
    }
    object { 
        ground_ceiling
        pigment { White }
        translate <0, 1, 0>
    }
    object { 
        wall
        pigment { MyGray }
        rotate 90*y
        translate <0, 0, 1>
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