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
    location <-4, 3.5, 3.5>
    look_at <8, 1, -1>
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

#declare monitor_base = merge {
    cylinder {
        <0,0,0>, <0,0.05,0>, 0.2
        translate y*0.02
    }
    cylinder {
        <0,0.05,0>, <0,0.3,0>, 0.05
    }
    pigment { MyGray }
}

#declare monitor_frame = box {
    <-1,0,-1>, <1,2,1>
    scale <0.6, 0.5, 0.1>
}

#declare monitor_screen = box {
    <-1, 0, -1>, <1, 2, 1>
    scale <0.55, 0.45, 0.1>
    translate <0, .05, -.15>
}

#declare monitor_connect_screen_frame = merge {
    difference {
        object {
            monitor_frame
        }
        object {
            monitor_screen
        }
        pigment { MyGray }
    }
    intersection {
        object {
            monitor_screen
        }
        object {
            monitor_frame
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
    scale <1.3,0,0.35>
    translate 0.3*y
}

#declare monitor = merge {
    object {
        monitor_connect_screen_frame
    }
    object {
        monitor_base
    }
}

#declare cd_drive = box {
    <-1, 0, -1>, <1,2,1>
    scale <0.2, 0.05, 0.02>
    texture {Silver_Texture}
}

#declare status_diode = sphere {
    <0, 0, 0>, 0.02
    scale <0, 0, 0.2>
}

#declare pc = merge {
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <0.3, 0.5, 0.7>
        pigment { White }
    }
    object {
        cd_drive
        translate <0, 0.75, -0.7>
    }
    object {
        cd_drive
        translate <0, 0.6, -0.7>
    }
    // Power button
    sphere {
        <0, 0, 0>, 0.03
        scale <0, 0, 0.5>
        translate <0, 0.25, -0.7>
        texture {Silver_Texture}
    }
    object {
        status_diode
        translate <-0.05, 0.3, -0.7>
        pigment {Green}
    }
    object {
        status_diode
        translate <0.05, 0.3, -0.7>
        pigment { Red }
    }
}

#declare drawer_pull = difference {
    torus {
      4, 1
      rotate -90*x
    }
    box { <-5, -5, -1>, <5, 0, 1> }
    texture { Silver_Texture }
    scale 0.02
    rotate -180 * x
    translate <0, 0.1, 0>
}

#declare drawer = merge {
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <0.51, 0.2, 0.05>
        texture { T_Wood2 }
    }
    object {
        drawer_pull
        translate <0, 0.125, -0.06>
    }
}

#declare base_of_desk = difference {
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <2.5, 0.75, 1>
    }
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <1.35, 0.67, 5>
        translate y * -0.02
    }
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <0.51, 0.63, 0.9>
        translate <1.93, 0.05, -0.2>
    }
    texture { T_Wood2 }
}

#declare desk = merge {
    object {
        base_of_desk
    }
    object {
        drawer
        translate <-1.93, 1, -1>
    }
    object {
        drawer
        translate <-1.93, 0.55, -1>
    }
    object {
        drawer
        translate <-1.93, 0.1, -1>
    }
    object {
        monitor
        rotate -10*y
        translate <-0.8, 1.5, 0.3>
    }
    object {
        monitor
        rotate 10*y
        translate <0.8, 1.5, 0.3>
    }
    object {
        pc
        translate <1.93, 0.06, -0.25>
    }
}


#declare bed = merge {
    // Base of the bed
    box {
        <-1, 0, -1>, <1, 2, 1>
        texture { T_Wood2 }
        scale <2.5, 0.75, 1.25>
        scale y * 0.8
    }
    // Mattress
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <2.25, 0.1, 1.15>
        translate <0, 1.5, 0>
        texture {
            pigment { color White }
            normal { bumps 1 }
            finish { phong 1 }
        }
        scale y * 0.8
    }
    // Pillow
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <0.5, 0.1, 0.8>
        translate <-1.55, 1.7, 0>
        pigment { White }
        scale y * 0.8
    }
    // duvet
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <1.5, 0.05, 1.1>
        translate <0.7, 1.7, 0>
        pigment { MyGray }
        scale y * 0.8
    }
    object {
        drawer
        rotate 180*y
        scale <1.5, 0, 0>
        translate <-1.7, 0.1, 1.25>
    }
    object {
        drawer
        rotate 180*y
        scale <1.5, 0, 0>
        translate <0, 0.1, 1.25>
    }
    object {
        drawer
        rotate 180*y
        scale <1.5, 0, 0>
        translate <1.7, 0.1, 1.25>
    }
}

#declare wardrobe_base = difference {
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <1.75, 2, 0>
        translate <0, 0.02, 0>
    }
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <0.8, 1.90, 1.2>
        translate <-0.85, 0.1, -0.2>
    }
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <0.8, 1.90, 1.2>
        translate <0.85, 0.1, -0.2>
    }
}

#declare wardrobe_shelf = box {
    <-1, 0, -1>, <1, 2, 1>
    scale <0.8, 0.05, 0>
}

#declare wardrobe_hang = cylinder {
    <0,0,0>, <0,1,0>, 0.04
    scale y * 1.7
    rotate 90 * z
    translate <1.74, 3.75, 0.25>
    texture { Silver_Texture }
}

#declare vert_wardrobe_finish = cylinder {
    <0, 0, 0>, <0, 4, 0>, 0.02
    texture { Silver_Texture }
}

#declare horizon_wardrobe_finish = cylinder {
    <0, 0, 0>, <0, 2, 0>, 0.02
    rotate 90*z
    texture { Silver_Texture }
}

#declare wardrobe_door = merge {
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <1, 2, 0.02>
        translate <0, 0.02, -1>
        texture { T_Wood2 }
    }
    object {
        vert_wardrobe_finish
        translate <-1.02, 0.02, -1.01>
    }
    object {
        vert_wardrobe_finish
        translate <1.02, 0.02, -1.01> 
    }
    // TOP
    object {
        horizon_wardrobe_finish
        translate <1, 4.02, -1.01>
    }
    // BOTTOM
    object {
        horizon_wardrobe_finish
        translate <1, 0.02, -1.01>
    }
    // 1/4
    object {
        horizon_wardrobe_finish
        translate <1, 1.02, -1.01>
    }
    // 3/4
    object {
        horizon_wardrobe_finish
        translate <1, 3.02, -1.01>
    }
}

#declare wardrobe = merge {
    merge {
        object {
            wardrobe_base
        }
        object {
            wardrobe_shelf
            translate <0.85, 2, 0>
        }
        object {
            wardrobe_shelf
            translate <-0.85, 1, 0>
        }
        object {
            wardrobe_shelf
            translate <-0.85, 2, 0>
        }
        object {
            wardrobe_shelf
            translate <-0.85, 3, 0>
        }
        texture { T_Wood2 }
    }
    object {
        wardrobe_door
        translate <-0.73, 0, 0>
    }
    object {
        wardrobe_door
        translate <0.83, 0, -0.03>
    }
    object {
        wardrobe_hang
    }
}

#declare tv_hang = merge {
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <0.3, 0.3, 0.02>
    }
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <0.05, 0.05, 0.2>
        translate <0, 0.23, -0.2>
        rotate -30*y
    }
    box {
        <-1, 0, -1>, <1, 2, 1>
        scale <0.05, 0.048, 0.2>
        rotate 45*y
        translate <0, 0.23, -0.45>
    }
    scale 1.3 *z
    texture { Silver_Texture }
    translate <0, 1, 0>
}

#declare tv = merge {
    object {
        tv_hang
    }
    object {
        monitor_connect_screen_frame
        scale <1.5, 1.5, 0>
        rotate 45*y
        translate <-0.25, 0, -0.86>
    }
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
        rotate 90*y
        pigment { White }
        translate <0, 0, -5>
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
        rotate 90*y
        translate <-3.6, 0.12, 2.5>
    }
    object {
        desk
        rotate 90*y
        translate <4, 0.12, 2.35>
    }
    object {
        chair
        rotate 45*y
        translate <2, 0, 2.25>
    }
    object {
        tv
        rotate 90*y
        translate <4.9, 1.5, -1.3>
    }
    object {
        wardrobe
        rotate 180*y
        translate <-3, 0.12, -4>
    }
}

#declare cut_out_room = difference {
    object {
        room
    }
    box { 
        <-3, 0, -3>, <3, 6, 3>
        translate <0.8, 0, -8.7>
        rotate -45*y
        pigment { MyGray }
    }
}

#declare door_hole = box {
    <-1, 0, -1>, <1, 0.8, 1>
    scale <1.1, 0, 0>
    translate <0, 0.3, 0>
}

#declare door_with_holes = difference {
    box {
        <-1, 0, -1>, <1, 5, 1>
        scale <1.4, 0, 0.05>
    }
    object {
        door_hole
    }
    object {
        door_hole
        translate <0, 0.9, 0>
    }
    object {
        door_hole
        translate <0, 1.8, 0>
    }
    object {
        door_hole
        translate <0, 2.7, 0>
    }
    object {
        door_hole
        translate <0, 3.6, 0>
    }
    texture { T_Wood2 }
}

#declare door_glass = box {
    <-1, 0, -1>, <1, 0.8, 1>
    scale <1.1, 0, 0.05>
    translate <0, 0.3, 0>
    texture { 
        pigment { rgbf <0.98, 1.0, 0.99, 0> }
        finish {
            ambient 0.1
            diffuse 0.1
            reflection .25
            specular 1
            roughness .001
        }
    }
}

#declare door_knob = merge {
    cylinder {
        <0, 0, 0>, <0, 0.01, 0>, 0.06
        rotate 90*x
        translate <0, 0, 0.125>
    }
    cylinder {
        <0, 0, 0>, <0, 0.125, 0>, 0.02
        rotate 90*x
    }
    cylinder {
        <0, 0, 0>, <0, 0.25, 0>, 0.02
        rotate <90, -90, 0>
        translate <0, 0, 0.03>
    }
    texture { Silver_Texture }
}

#declare door = merge {
    object {
        door_with_holes
    }
    object {
        door_glass
    }
    object {
        door_glass
        translate <0, 0.9, 0>
    }
    object {
        door_glass
        translate <0, 1.8, 0>
    }
    object {
        door_glass
        translate <0, 2.7, 0>
    }
    object {
        door_glass
        translate <0, 3.6, 0>
    }
    object {
        door_knob
        translate <1.25, 2.5, -0.18>
    }
    object {
        door_knob
        rotate <0, 180, 180>
        translate <1.25, 2.5, 0.18>
    }
}

#declare room_finished = merge {
    object {
        cut_out_room
    }
    object {
        door
        scale x*0.9
        rotate -45*y
        translate <4.05, 0, -4.05>
    }
}

object {
    room_finished
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
    <0, 4.75, -2>
    color White
    //area_light <1, 0, 0>, <0, 1, 0>, 2, 2
    //jitter
    looks_like { Lightbulb }
}

//light_source {
//    <0,1,-4>
//    color White
//    spotlight
//    point_at <0, 2, 0>
//}