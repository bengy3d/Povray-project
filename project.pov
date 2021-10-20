#include "colors.inc"
#include "woods.inc"
#include "textures.inc"
#include "skies.inc"
#include "stones.inc"
#include "shapes.inc"
#include "metals.inc"

#declare MyGray = rgb<53/255, 58/255, 55/255>;

camera {
//    location <0, 7, 5>
//    look_at <0, 0, 5>
    //location <2.5, 2.5, 3> // camera wall near the window
    //look_at <-2.5, 0, 5> // camera wall near the window
    //location <5, 2, 0> // room from the side
    //look_at <-2, 1, 0> // room from the side
    location <0, 2, -5>
    look_at <0, 1, 2>
}

sky_sphere { S_Cloud2 }

plane {
    <0, 1, 0>, 0
    pigment { Green }
}

#declare ground_ceiling = box {
    <-1, 0, -1>, <1, 2, 1>
    scale <5, 0.05, 5>
}

#declare wall = box {
    <-1, 0, -1>, <1, 2, 1>
    scale <0.1, 2.5, 5>
}
// Glass of the window
#declare glass = intersection {
    object {
        box {
            <-1, 0, -1>, <1, 2, 1>
            translate 1.25 * y
            scale <1.25, 1.25, 2.5>
        }
    }
    object {
        wall
    }
    texture { Glass }
}
// Sill of the window
#declare sill = object {
    Round_Box(<-1, 0, -1>, <1, 2, 1>, 0.125, 0)
    scale <2.5, 0.1, 0.25>
    texture { T_Grnt20 scale .4}
    rotate 90*y
    translate <0, 1.35, 0>
}
// merging glass and sill into window
#declare window = merge {
    object {
        glass
    }
    object {
        sill
    }
}

// Wall with a hole
#declare wall_with_a_hole = difference {
    object {
        wall
    }
    object {
        glass
        scale <10, 0, 0>
    }
}

#declare window_wall = merge {
    object {
        wall_with_a_hole 
        pigment { MyGray }
    }
    object {
        window
    }
}

#declare bed = merge {
    // Base of the bed
    object {
        box {
            <-1, 0, -1>, <1, 2, 1>
        }
        texture { T_Wood2 }
        scale <2.5, 0.75, 1.25>
    }
    // Mattress
    object {
        box {<-1, 0, -1>, <1, 2, 1>}
        scale <2.25, 0.2, 1.15>
        translate <0, 1.25, 0>
        texture {
            pigment { color White }
            normal { bumps 1 }
            finish { phong 1 }
        }
    }
    scale y * 0.8
    rotate 90*y
}

#declare base_of_desk = difference {
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <2.5, 0.75, 1>
    }
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <1.25, 0.6, 5>
    } 
    texture { T_Wood2 }
}

#declare chair_wheel = difference {
    sphere {
        <0,1,0>, 1   
    }
    box {
        <-1,0,-1>,<1,2,1>
        translate 1.5 * x
    }
    box {
        <-1,0,-1>,<1,2,1>
        translate -1.5 * x
    }
    pigment { MyGray }
    translate 0.8 * y
    scale 0.15
}

#declare chair_leg = union {
    cylinder {
        <0,0,0>, <0,1,0>, 0.05
        scale <1, 0.5, 1>
        texture { Silver_Texture }
        rotate 80*x
        translate 0.25*y
    }
    object {
        chair_wheel
        scale 0.6
        rotate -45*y
    }
}

#declare chair_all_legs = union {
    object {
        chair_leg
        rotate <0, 90, 0>
        translate x * -0.5
    }
    object {
        chair_leg
        rotate <0, 270, 0>
        translate x * 0.5
    }
    object {
        chair_leg
        rotate <0, 180, 0>
        translate z * 0.5
    }
    object {
        chair_leg
        translate z * -0.5
    }
}

#declare chair_mid = merge {
    cylinder {
        <0,0,0>, <0,1,0>, 0.1
        pigment { MyGray }
    }
    cylinder {
        <0,1,0>, <0,1.5,0>, 0.05
        texture { Silver_Texture }
    }
    cylinder {
        <0,-0.2,0>, <0,0,0>, 0.075
        texture { Silver_Texture }
    }
    scale <1, 0.5, 1>
}


#declare handle = merge {
    difference {
        torus {
            1, 0.25
            translate 1*y
        }
        box {
            <-1.25,0,-1.25>, <1.25,2,1.25>
            translate 1*x
        }
        box {
            <-1.25,0,-1.25>, <1.25,2,1.25>
            translate 1*z
        }
    }
    cylinder {
        <0,0,0>,<0,2,0>, 0.25
        rotate 90*z
        translate <1.55, 1, -1>
    }
    cylinder {
        <0,0,0>,<0,2,0>, 0.25
        rotate 90*x
        translate <-1,1,-0.2>
    }
    object {
        Round_Box(<1,0,1>,<-1,1,-1>, .125, 1)
        pigment { MyGray }
        scale <0.5,0.15,0>
        translate <-1, 1.75, -1>
        rotate 90*x
    }
    texture { Silver_Texture }
    rotate <-90,90,0>
    translate <0, 1.5, 0>
    scale 0.25
}

#declare seat = union {
    object {
        Round_Box(<-1,0,-1>,<1,2,1>, 0.125, 0)
        scale <0.5,0.05,0.5>
        translate 0.1*y
        pigment { MyGray }
    }
    object {
        Round_Box(<-1,0,-1>,<1,2,1>, 0.125, 0)
        scale <0.5,0.05,0.625>
        rotate <90, 90, 0>
        translate <-0.6, 0.7, 0>
        pigment { MyGray }
    }
    object {
        handle
        scale 0.8
        translate <0.2,0,0.45>
    }
    object {
        handle
        scale 0.8
        rotate 180*y
        translate <-0.2,0,-0.45>
    }
}

#declare chair = union {
    object {
        chair_all_legs
        translate 0.1*y
    }
    object {
        chair_mid
        scale 0.8
        translate 0.5*y
    }
    object {
        seat
        translate 1*y
    }
    translate -0.075*y
}

#declare monitor = union {
    difference {
        box {
            <-1,0,-1>, <1,2,1>
            scale <0.6, 0.5, 0.1>
        }
        box {
            <-1, 0, -1>, <1, 2, 1>
            scale <0.55, 0.45, 0.1>
            translate <0, .08, -.15>
        }
        pigment { MyGray }
    }
    intersection {
        box {
            <-1,0,-1>, <1,2,1>
            scale <0.55, 0.45, 0.1>
            translate <0, .025, -.16>
        }
        box {
            <-1,0,-1>, <1,2,1>
            scale <0.6, 0.5, 0.1>
        }
        texture { 
            finish {
                specular 1
                roughness 0.001
                ambient 0
                diffuse 0
            }
        }
    }
    translate 0.5*y
} 

#declare room = merge {
    object { 
        ground_ceiling
        texture {
            DMFLightOak scale 0.3
        }
    }
    object { 
        ground_ceiling
        pigment { White }
        finish { ambient 0.5 }
        translate <0, 5, 0>
    }
    object {
        window_wall
        rotate 90*y
        translate <0, 0, 5>
    }
    object {
        wall
        pigment { White }
        translate <5, 0, 0>
    }
    object {
        wall
        pigment { White }
        translate <-5, 0, 0>
    }
    object {
        bed
        translate <-3.6, 0, 2.5>
    }
    object {
        base_of_desk
        rotate 90*y
        translate <4, 0, 2.5>
    }
    object {
        chair
        rotate 45*y
        translate <2, 0, 2.25>
    }
    object {
        monitor
    }
}

object {
    room
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
    //area_light <1, 0, 0>, <0, 1, 0>, 2, 2
    //jitter
    looks_like { Lightbulb }
}

light_source {
    <0,1,-2>
    color White
    spotlight
    point_at <0, 0, 0>
}