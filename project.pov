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
    //location <15, 2, 0> // room from the side
    //look_at <0, 1, 0> // room from the side
    location <0, 2, -4>
    look_at <0, 1, 2>
}

sky_sphere { S_Cloud2 }

plane {
    <0, 1, 0>, 0
    pigment { Green }
}

#declare ground_ceiling = box {
    <-1, 0, -1>, <1, 2, 1>
    scale <0, 0.01, 0>
}

#declare wall = box {
    <-1, 0, -1>, <1, 2, 1>
    scale <0.02, 0.5, 0>
}
// Glass of the window
#declare glass = intersection {
    object {
        box {
            <-1, 0, -1>, <1, 2, 1>
            translate 1.25 * y
            scale <0.25, 0.25, 0.5>
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
    scale <0.5, 0.02, 0.05>
    texture { T_Grnt20 scale .4}
    rotate 90*y
    translate <0, 0.27, 0>
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
        scale <2, 0, 0>
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
        scale <0.5, 0.15, 0.25>
    }
    // Mattress
    object {
        box {<-1, 0, -1>, <1, 2, 1>}
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

#declare base_of_desk = difference {
    object {
        box {
            <-1, 0, -1>, <1, 2, 1>
            scale <0.5, 0.15, 0.20>
        }
    }
    object {
        box {
            <-1, 0, -1>, <1, 2, 1>
            scale <0.25, 0.12, 0>
        } 
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
    scale 0.03
}

#declare chair_leg = union {
    cylinder {
        <0,0,0>, <0,1,0>, 0.05
        scale <0.2, 0.1, 0.2>
        texture { Silver_Texture }
        rotate 80*x
        translate 0.05*y
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
        translate x * -0.1
    }
    object {
        chair_leg
        rotate <0, 270, 0>
        translate x * 0.1
    }
    object {
        chair_leg
        rotate <0, 180, 0>
        translate z * 0.1
    }
    object {
        chair_leg
        translate z * -0.1
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
    scale <0.2, 0.1, 0.2>
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
    scale 0.05
}

#declare seat = union {
    object {
        Round_Box(<-1,0,-1>,<1,2,1>, 0.125, 0)
        scale <0.1,0.01,0.1>
        translate 0.02*y
        pigment { MyGray }
    }
    object {
        Round_Box(<-1,0,-1>,<1,2,1>, 0.125, 0)
        scale <0.1,0.01,0.125>
        rotate <90, 90, 0>
        translate <-0.12, 0.14, 0>
        pigment { MyGray }
    }
    object {
        handle
        scale 0.8
        translate <0.04,0,0.09>
    }
    object {
        handle
        scale 0.8
        rotate 180*y
        translate <-0.04,0,-0.09>
    }
}

#declare chair = union {
    object {
        chair_all_legs
        translate 0.02*y
    }
    object {
        chair_mid
        scale 0.8
        translate 0.1*y
    }
    object {
        seat
        translate 0.2*y
    }
}


#declare room = merge {
    object { 
        ground_ceiling
        texture {
            DMFLightOak scale 0.3
            //finish { phong 1 }
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
        wall
        pigment { White }
        translate <1, 0, 0>
    }
    object {
        wall
        pigment { White }
        translate <-1, 0, 0>
    }
    object {
        bed
        translate <-0.72, 0, 0.5>
    }
    object {
        base_of_desk
        rotate 90*y
        translate <0.8, 0, 0.5>
    }
    object {
        chair
        rotate 45*y
    }
}

object {
    room
    scale <5, 5, 5>
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
    //looks_like { Lightbulb }
}