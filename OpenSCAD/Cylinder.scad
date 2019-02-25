/*
    WORK IN PROGRESS
    
    This code is part of  a collaborative project with Alexander Kutchera  (https://github.com/vektorious/lightM).
    (c) Fernan Federici, 2017- Released under the CERN Open Hardware License   
*/
include <threads.scad>
include <picam_2_push_fit.scad>  

//-------important parameters to change petri dish and  base dimensions below for customization

corr=0.2;// used to create extra fitting space for printing imperfections
petri_h=15;// petri dish height
petri_lid_d=92.4 + corr*3; //petri dish diameter, corr is added for extra space (e.g. parafilm)
LED_shield=40;//distance from illuminating hole to border used to hide the LEDs from the camera field of view
base_d=petri_lid_d+LED_shield*2;//diameter of printed light house cylinder


//-----------------secondary -parameters more unlikely to be changed

screw_d=21;//distance between screw holes in RPI camera holder
screw_r=2/2;//screw radius
screw_hold_r=2;
sensor_h=2; //space for sensor
sensor_x=8.5;//RPI camera sensor dim
wall_M12=1.5;
base_xy=16;
base_h=6;
M12_r=12/2;//radius of M12 lens
mount_h = 10;
screw_d=21;//distance between screw holes
screw_r=2/2;
screw_hold_r=2;
wall=0.75;
holder_x=54;//acrylic bed width to fit into holder
holder_y=54;//acrylic bed thickness to fit into holder, normally 3mm acrylic
holder_z=3;//acrylic bed thickness to fit into holder, normally 3mm acrylic
h_ring= petri_h*2;//petri dish-holding ring 
light_box_h=110;
view_d=petri_lid_d-8;// diameter of the illuminating hole, with a 4mm notch to hold the petri dish. It has to be smaller than petri_lid_d (Parkinson 2007 uses 82mm).
h_cam=110-h_ring;//height to camera
inner_r=petri_lid_d*1.2/2;
velvet_background_ring_h=28;
LED_base_h=9;
LED_ring_ext_d=base_d-wall*3;
LED_ring_int_d=LED_ring_ext_d-10;
velvet_background_ring_d=LED_ring_int_d-wall*3;
velvet_background_ring_stage_r=velvet_background_ring_d/2-10;
inner_h=petri_h/2;
$fn=100;

//------------uncomment items below to render pieces--------------------------

//cone();

//extension_ring();

camera_holder(type=3); //use type 1 for the RPI camera as it comes; type 2 for M12 lens (removing the native RPIlens) using puh-fit approach from R. Bowman; type 3 is for M12lens but using screws to attach it to camera

//lighting_base(); // we are working to remove this huge printed piece

//lid(printed=true);// we have two versions:  printed (expensive) or found (any cardboard).

//velvet_background_ring(type=1);// we have three version:  1=outword borders, 2=inward border, and 3=straight border.

//LED_base(); // to glue LED strips facing up in 45 º

//------------------------------------------------------------------------------------------------------


module lid(printed_base=true){
//--------------- top part holding the plate and interfacing with lid
   difference(){
       cylinder( r=petri_lid_d/2+wall, h=h_ring/2);
       color("red") cylinder( r=petri_lid_d/2-wall, h=h_ring/2+corr);
       color("cyan") cylinder(r=view_d/2, h=h_ring*1.5, center = true);   
      }
//--------------------------- interface between top and bottom 
      difference(){
       translate([ 0, 0, wall]) cylinder(r=base_d/2+wall*3, h=wall*2, center=true);
       color("cyan") cylinder(r=view_d/2, h=h_ring*3, center = true);// hole for illumination
      }
//--------------- bottom part sitting inside of the cut spaced in your box 
      difference(){
       translate([ 0, 0, -inner_h/2])  cylinder(r=inner_r, h=inner_h, center=true);;
       translate([ 0, 0, -inner_h/2-wall]) color("cyan") cylinder(r=inner_r-wall, h=inner_h, center=true);;// hole for illumination
       color("cyan") cylinder(r=view_d/2, h=inner_h, center = true);
}
//-------------------ring for top part sitting on printed cylinder 
if(printed_base==true)  {
    difference(){
       translate([ 0, 0, -inner_h/2])  cylinder(r=base_d/2+wall*3, h=inner_h, center=true);;
       translate([ 0, 0, -inner_h/2-wall]) color("cyan") cylinder(r=base_d/2, h=inner_h, center=true);
    color("cyan") cylinder(r=view_d/2, h=inner_h, center = true);// hole for illumination
    }}  
    else {
        //to do}
}}

module extension_ring(){
//---------------- top part holding the plate and interfacing with lid 
   difference(){
       cylinder( r=petri_lid_d/2+wall, h=h_ring/2);
       color("red") cylinder( r=petri_lid_d/2-wall, h=h_ring/2+corr);
       color("cyan") cylinder(r=view_d/2, h=h_ring*1.5, center = true);   
      }
 translate([ 0.00, 0.00, -h_ring]) difference(){
            color("blue")cylinder( r=petri_lid_d/2+wall*3, h=h_ring);
            translate([ 0.00, 0.00, h_ring/1.5]) color("blue") cylinder( r=petri_lid_d/2-wall*2, h=h_ring);
            translate([ 0.00, 0.00, -h_ring/3]) color("green") cylinder( r=petri_lid_d/2+wall+corr, h=h_ring);
            translate([ 0.00, 0.00, h_ring/2]) color("yellow") cylinder(r=petri_lid_d/2-wall*5, h=wall*3, center = true); 
           } 
}

module lighting_base(){
    difference(){
       cylinder(r=base_d/2-corr*2, h=light_box_h);
       translate([ 0, 0,  wall ]) color("red") cylinder( r=base_d/2-wall*2, h=light_box_h);
      translate([base_d/2-wall*3,0,wall*6]) rotate([90,90,90])  color("blue") cylinder(r=wall*4, h=wall*10);
           }    
    }

module cone(){
   union(){
       translate([ 0,0,h_ring]) difference(){
            union(){
                color("white") cylinder( r1=petri_lid_d/2, r2=base_xy, h=h_cam);
                translate([ 0.00, 0.00, h_cam-corr ])color("cyan")   cube([base_xy+wall*3, base_xy+wall*3, mount_h*1.5], center = true);}
            translate([ 0.00, 0.00, -wall ]) color("red") cylinder( r1=petri_lid_d/2-wall*2, r2=base_xy-wall*2, h=h_cam);
             translate([ 0.00, 0.00, h_cam-corr ])color("cyan")   color("Blue") cube([base_xy+corr*2, base_xy+corr*2, mount_h*3], center = true);

//       translate([ 0.00, 0.00, h_cam ])color("cyan") cube([base_xy+corr*1.5, base_xy+corr, wall*2+corr*1.5], center = true);
                }
       difference(){
            color("blue")cylinder( r=petri_lid_d/2+wall*3, h=h_ring);
            translate([ 0.00, 0.00, h_ring/1.5]) color("blue") cylinder( r=petri_lid_d/2-wall*2, h=h_ring);
            translate([ 0.00, 0.00, -h_ring/3]) color("green") cylinder( r=petri_lid_d/2+wall+corr, h=h_ring);
            translate([ 0.00, 0.00, h_ring/2]) color("yellow") cylinder(r=petri_lid_d/2-wall*5, h=wall*3, center = true); 
           }    
}}

 module velvet_background_ring(type){
     if(type==1){
          translate([ 0.00, 0.00, velvet_background_ring_h ]) rotate([ 0.00, 180.00, 0.00 ])velvet_background_ring_v1();}
     if(type==2){
         velvet_background_ring_v2();}
     if(type==3){
         velvet_background_ring_v3();}
     }       
  
 module camera_holder(type){
    if(type==1){
        RPI_lens();
    }
    if (type==2){
    M12_push_fit();
    }
     if (type==3){
    M12_screwed();
        }}
   
module RPI_lens(){
    difference() {
			union() {
                translate([0,0,wall]) 
                color("Blue") cube([base_xy, base_xy, wall*8], center = true);
               				rotate([ 0.00, 0.00, 45.00 ]) camera_mount_FF();
			}	
        translate([0, 0, -base_h/2])  cylinder (r1=((M12_r*2)+(corr*5))/2, r2=((M12_r*2)+(corr*5)), h=mount_h*2);
	}
}

//-----------------  M12lens holder by push-fit mechanism
module M12_push_fit(){
    difference() {
			union() {
                translate([0,0,mount_h/2]) 
                color("Blue") cube([base_xy, base_xy, mount_h], center = true);
               				rotate([ 0.00, 0.00, 45.00 ]) camera_mount_FF();
			}	
            // adjuted diameter reducing 3 to 3 corr (14 Feb 2019)
        translate([0, 0, -base_h/2])  english_thread (diameter=(((M12_r*2)+(corr*2))/25.4), threads_per_inch=50.8, length=mount_h*1.5/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
	}
}

//----------------- M12lens  holder by screws
module M12_screwed(){
    difference() {
			union() {
                translate([0,0,mount_h/2 + base_h]) 
               color("Blue") cube([base_xy, base_xy, mount_h], center = true);
				translate([0,0,base_h/2])
					color("Red")  cube([base_xy, base_xy, base_h], center = true);
				translate([screw_d/2, 0, 0])
					cylinder(r = screw_hold_r, h = base_h/2);
				translate(-[screw_d/2, 0, 0])
					cylinder(r = screw_hold_r, h = base_h/2);
					translate([0,0,base_h/2/2])
						cube([screw_d, 4, base_h/2], center = true);
			}
		translate([0,0,base_h/2])
			color("Green") cube([base_xy - wall*2, base_xy - wall*2, base_h], center = true);
		translate([screw_d/2, 0, 0])
			cylinder(r = screw_r, h = base_h);
		translate([-screw_d/2, 0, 0])
			cylinder(r = screw_r, h = base_h);
		translate([0, base_xy / 4, sensor_h/2])
			cube([sensor_x, base_xy / 2, sensor_h], center = true);
        translate([0, 0, base_h-corr])     english_thread (diameter=(((M12_r*2)+(corr*2))/25.4), threads_per_inch=50.8, length=mount_h*3/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
	}
}


module LED_base(){
     difference(){
         rotate_extrude($fn=200) polygon( points=[[LED_ring_ext_d/2,0],[LED_ring_int_d/2,0],[LED_ring_ext_d/2,LED_base_h]] );
        translate([LED_ring_int_d/2-wall*2,0,wall*6]) rotate([90,90,90])  color("blue") cube([ 15,10,15 ]);
     }
}

//------------------straight
module velvet_background_ring_v3(){
    difference(){
        cylinder( r=velvet_background_ring_d/2, h=velvet_background_ring_h);
        translate([ 0.00, 0.00, wall*2 ]) cylinder( r=velvet_background_ring_d/2-wall, h=velvet_background_ring_h); 
        }}
//---------------------inward     
module velvet_background_ring_v2(){
    difference(){
        rotate_extrude($fn=200) polygon( points=[[0,0],[velvet_background_ring_d/2,0],[velvet_background_ring_stage_r,velvet_background_ring_h],[0,velvet_background_ring_h]] );
      translate([ 0.00, 0.00, wall*2 ]) cylinder(r1= velvet_background_ring_stage_r+wall*4, r2=velvet_background_ring_stage_r, h=velvet_background_ring_h+wall); 
        }
}
//----------------------outward
module velvet_background_ring_v1(){
    difference(){
        rotate_extrude($fn=200) polygon( points=[[0,0],[velvet_background_ring_d/2,0],[velvet_background_ring_stage_r,velvet_background_ring_h],[0,velvet_background_ring_h]] );
          rotate_extrude($fn=200) polygon( points=[[0,0],[velvet_background_ring_d/2-wall*2,0],[velvet_background_ring_stage_r-wall*2,velvet_background_ring_h-wall*2],[0,velvet_background_ring_h-wall*2]] ); 
        }
}

/*--------------------------------------------------------------------------------------------------------
These modules below use Richard Bowman's code to make push fit camera holder and cover. See openflexure for mor einformation (https://github.com/rwb27/openflexure_microscope). Module camera_mount_FF and RPIcam_cover were modified from Richard ´s code
--------------------------------------------------------------------------------------------------------*/

module camera_mount_FF(){
    // A mount for the pi camera v2
    // This should finish at z=0+d, with a surface that can be
    // hull-ed onto the lens assembly.
    h = 24;
    w = 25;
    rotate(45) difference(){
        translate([0,2.4,0]) sequential_hull(){
            translate([0,0,bottom]) cube([w,h,d],center=true);
            translate([0,0,bottom+1.5]) cube([w,h,d],center=true);
            translate([0,0,0]) cube([w-(-1.5-bottom)*2,h,d],center=true);
        }
        translate([0,0,bottom]) picam2_push_fit_FF();
    }
}

module RPIcam_cover(){
    fit_corr=1;//makes it bigger to fit and avoid damaging the PCB
    // A cover for the camera PCB, slips over the bottom of the camera
    // mount.  This version should be compatible with v1 and v2 of the board
    start_y=-12+2.4;//-3.25;
    l=-start_y+12+2.4; //we start just after the socket and finish at 
    //the end of the board - this is that distance!
    difference(){
        union(){
            //base
            translate([-15,start_y,-4.3]) cube([25+5,l,4.3+d]);
            //grippers
            reflect([1,0,0]) translate([-15,start_y,fit_corr]){
                translate([0,0,-fit_corr]) cube([2,l,4.5-d]);
                hull(){
                    translate([0,0,1.5]) cube([2,l,3]);
                    translate([0,0,4]) cube([2+2.5,l,0.5]);
                }
            }
        }
        translate([0,0,-1]) picam2_pcb_bottom();
        //chamfer the connector edge for ease of access
        translate([-999,start_y,0]) rotate([-135,0,0]) cube([9999,999,999]);
    }
} 


 module picam2_push_fit_FF( beam_length=15){
    // This module is designed to be subtracted from the bottom of a shape.
    // The z=0 plane should be the print bed.
    // It includes cut-outs for the components on the PCB and also a push-fit hole
    // for the camera module.  This uses flexible "fingers" to grip the camera firmly
    // but gently.  Just push to insert, and wiggle to remove.  You may find popping 
    // off the brown ribbon cable and removing the PCB first helps when extracting
    // the camera module again.
    camera = [8.5,8.5,2.8]; //size of camera box (NB it's now propped up on foam)
	cw = camera[0]+1; //side length of camera box at bottom (slightly larger)
	finger_w = 1.5; //width of flexure "fingers"
	flex_l = 1; //width of flexible part
    hole_r = camera[0]/2-0.4;
	union(){
       
		//cut-out for camera
        /*hull(){
            translate([0,0,-d]) cube([cw+0.5,cw+0.5,d],center=true); //hole for camera
            translate([0,0,1]) cube([cw-0.5,cw-0.5,d],center=true); //hole for camera
        }
        */
        rotate(180/16) cylinder(r=hole_r,h=beam_length,center=true,$fn=100); //hole for light
        
        //looser cut-out for camera, with gripping "fingers" on 3 sides
        difference(){
            //cut-out big enough to include gripping fingers
           /* intersection(){
                hull(){
                    translate([0,-(finger_w+flex_l)/2,0.5+d])
                        cube([cw+2*finger_w+2*flex_l, cw+finger_w+flex_l, 2*d],center=true);
                    translate([0,0,0.5+3*(finger_w+flex_l)]) cube([cw, cw, d],center=true);
                }
                //fill in the corners of the void first, to give an endstop for the camera
                
                //build up the roof gradually so we get a nice hole
                rotate(90) translate([0,0,camera[2]+1.0]) 
                    hole_from_bottom(r=hole_r,h=beam_length - camera[2]-1.5);
            }
            */
                
            //gripping "fingers" (NB we subtract these from the cut-out)
           /* for(a=[90:90:270]) rotate(a) hull(){
                translate([-cw/2+0.5,cw/2,0]) cube([cw-1,finger_w,d]);
                translate([-cw/2+1,camera[0]/2-0.1,camera[2]]) cube([cw-2,finger_w,d]);
            }
            */
            //there's no finger on the top, so add a dimple on the fourth side
            /*hull(){
                translate([-cw/2+1,cw/2,4.3/2]) cube([cw-2,d,camera[2]-1.5]);
                translate([-cw/2+2,camera[1]/2,camera[2]-0.5]) cube([cw-4,d,0.5]);
                translate([-21/2,cw/2,camera[2]-1.5]) cube([21,d,camera[2]-1.5]);
                translate([-21/2,camera[1]/2,camera[2]-0.5]) cube([21,d,0.5]);
            }
            */
		}
        
		//ribbon cable at top of camera
        sequential_hull(){
            translate([0,-5,0]) cube([cw-1,d,5],center=true);
            translate([0,cw/2+1,0]) cube([cw-1,d,5],center=true);
            translate([0,9.4-(4.4/1)/2,0]) cube([cw-1,1,5],center=true);
        }
        //flex connector
        translate([-1.25,9.4,0]) cube([cw-1+2.5, 4.4+1, 5],center=true);
        
		//screw holes for safety (M2 "threaded")
		reflect([1,0,0]) translate([21/2,0,0]){
            cylinder(r1=2.5, r2=1, h=2, center=true, $fn=100);
            cylinder(r=1, h=7, $fn=100);
        }
	}
}

//---------------------------deprecated modules

module Cylindrical_lid(){
   union(){
       translate([ 0,0,h_ring]) difference(){
       cylinder( r=petri_lid_d/2+wall*2, h=h_cam);
       translate([ 0.00, 0.00, -wall ]) color("red") cylinder( r=petri_lid_d/2, h=h_cam);
       translate([ 0.00, 0.00, h_cam ])color("red") cube([base_xy+corr, base_xy+corr, wall*2+corr], center = true);}
       difference(){
       cylinder( r=petri_lid_d/2+wall*3, h=h_ring);
       translate([ 0.00, 0.00, h_ring/2]) color("blue") cylinder( r=petri_lid_d/2, h=h_ring);
       translate([ 0.00, 0.00, -h_ring/2-wall]) color("green") cylinder( r=petri_lid_d/2+wall+corr, h=h_ring);
       color("red") cylinder(r=petri_lid_d/2-wall*5, h=h_ring*3, center = true); 
           }    
}}

module plate_ring(type){
     if(type==1){
//to do
         }
    if(type==2){
        ring_v2();
}
    if(type==3){
        ring_v3();
}
    }
    
//-----------------------big ring
module ring_v3(){
  difference(){// top part holding the plate and interfacing with lid
       translate([ 0.00, 0.00, h_ring/2])  cylinder( r=petri_lid_d/2+wall, h=h_ring/2);
       translate([ 0.00, 0.00, h_ring/2]) color("cyan") cylinder( r=petri_lid_d/2-wall, h=h_ring*1.5);
       color("cyan") cylinder(r=view_d/2, h=h_ring*3, center = true);   
      }
      difference(){//bottom part sitting on top of base
       cylinder( r=base_d/2+wall*3, h=h_ring/2);
     
       translate([ 0.00, 0.00, -h_ring/2-wall*3]) color("blue") cylinder( r=base_d/2, h=h_ring);
       color("cyan") cylinder(r=view_d/2, h=h_ring*3, center = true);// hole for illumination
}}
 
//---------------------ring to be inserted in cardboard box hole
module ring_v2(){
  difference(){
      union(){
          translate([ 0.00, 0.00, h_ring/2])  cylinder( r=petri_lid_d/2+wall, h=h_ring/2);
          translate([ 0.00, 0.00, h_ring/2])  cube([ petri_lid_d*1.5, petri_lid_d*1.5, wall*2 ], center=true);
          }
       translate([ 0.00, 0.00, h_ring/2]) color("red") cylinder( r=petri_lid_d/2-wall, h=h_ring*1.5);
       color("cyan") cylinder(r=view_d/2, h=h_ring*3, center = true);   
      }
      difference(){
       cylinder( r=petri_lid_d/2+wall*2, h=h_ring/2);
      
       translate([ 0.00, 0.00, -h_ring/2-wall]) color("blue") cylinder( r=petri_lid_d/2, h=h_ring);
       color("cyan") cylinder(r=view_d/2, h=h_ring*3, center = true);   
}}





