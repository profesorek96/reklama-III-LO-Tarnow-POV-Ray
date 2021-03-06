 // PoVRay 3.7 Scene File " ... .pov"
// author:  ...
// date:    ...
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <1.0 , 3.5 ,-3.5>
                            right     x*image_width/image_height
                            look_at   <1.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <-2.0 , 2.5 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<-1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <1.0,1.0,1.0>]
                                   [0.30 rgb <0.0,0.1,1.0>]
                                   [0.70 rgb <0.0,0.1,1.0>]
                                   [1.00 rgb <1.0,1.0,1.0>] 
                                 } 
                       scale 2         
                     } // end of pigment
           } //end of skysphere                  
           

global_settings {
    assumed_gamma 1.8
    max_trace_level 32
}


// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ color rgb <1.00,0.95,0.8>}
                normal { bumps 0.75 scale 0.025  }
                finish { phong 0.1 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



    
    
    
#macro MakeBall(Text, SpotSize, SpotClearance, ColorTex, WhiteTex)
    #local Mn = min_extent(Text);
    #local Mx = max_extent(Text);
    #local PatternObj =
    union {
        object {Text
            translate -Mn - 0.5*(Mx-Mn)
            scale  x + y + z*1/(Mx.z - Mn.z)
            scale (x+y)*(SpotSize-SpotClearance)/vlength(<Mx.x, Mx.y, 0> - <Mn.x, Mn.y, 0>) + z
            translate -z*1
        }
        #debug "\n"
        #debug str((Mx.z - Mn.z),0,0)
        #debug "\n"
        object {Text
            translate -Mn - 0.5*(Mx-Mn)
            scale  -x + y + z*1/(Mx.z - Mn.z)
            scale (x+y)*(SpotSize-SpotClearance)/vlength(<Mx.x, Mx.y, 0> - <Mn.x, Mn.y, 0>) + z
            translate z*1
        }
        difference {
            cylinder {-z*2, z*2, 5}
            cylinder {-z*2, z*2, SpotSize/2}
        }
    }
    sphere  {< 0, 0, 0>, 1
        texture {
            object {PatternObj texture {WhiteTex}, texture {ColorTex}}
        } 
    }
#end


#macro MakeTextBall(Text, SpotSize, SpotClearance, ColorTex, WhiteTex)
    #local TextObj =
    text {ttf "crystal.ttf", Text, 1, 0}
    MakeBall(TextObj, SpotSize, SpotClearance, ColorTex, WhiteTex)
#end


#declare RedTex =
texture {
    pigment {color rgb<1, 0.3, 0>}
}               
#declare RedTex2 =
texture {
    pigment {color rgb<0, 0.3, 0>}
}
#declare RedTex3 =
texture {
    pigment {color rgb<0, 0, 0.3>}
}



#declare WhiteTex =
texture {
    pigment {color White}
}      




object {MakeTextBall("MAT", 0.75, 0.1, RedTex, WhiteTex)
    translate y*1
    translate -x*1    
   
}
object {MakeTextBall("FIZ", 0.75, 0.1, RedTex2, WhiteTex)
    rotate y*180
    translate y*1
    translate x*1  

}                    
object {MakeTextBall("INF", 0.75, 0.1, RedTex3, WhiteTex)
    rotate y*180
    translate y*1
    translate x*3
}
//*******************************************

light_source {<-20, 15, -100 > color White}
 




//Bevelled_Text(Font, String, Cuts, BevelAng, BevelDepth, Depth, Offset, UseMerge)
object{ 
        Bevelled_Text("arial.ttf", "III LO w Tarnowie", 10 , 35, 0.045, 1, 0.00, 0)
        texture{ pigment{ Blue} 
                 normal { bumps 0.5 scale 0.005}
                 finish { specular 1 reflection 0.2}
               } // end of texture
        rotate<0,0,0>
        scale<1.5,2.0,1>*1 
        translate<-4, 0.2,5>
      } // end of Bevelled_Text object -------------------------------------------


//http://objects.povworld.org  
