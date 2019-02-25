/*
This is part of the project Comunicaciones Especulativas: http://interspecifics.cc/comunicacionesespeculativas/ and https://osf.io/c542q/

This file creates a 3D printed version of the optical pieces used by Alexandre Kabla and his team for the openlabtools microscope (http://openlabtools.eng.cam.ac.uk/Instruments/Microscope/Optics/)
We used:

1- <picam_2_push_fit.scad> from  OpenFlexure Microscope: Raspberry Pi Camera v2 push-fit mount (c) Richard Bowman, January 2016 Released under the CERN Open Hardware License  

2- <threads.scad> from http://dkprojects.net/openscad-threads/

    english_thread is in inches that´s why all mmm values are divided by 25,4

    Normally one male thread fitting into another (e.g. housing a lens)  requires some extra mm in between. Normally this is done by reducing male by 3*corr (corr= 0.2mm). The only exception is at joints where an outsourced piece is hosted (e.g. lens). In this case, the corr is applied to the female.

(c) Fernan Federici, 2017- Released under the CERN Open Hardware License   

*/

use <threads.scad>
include <picam_2_push_fit.scad>         

corr=0.2;// sometimes used for printing imperfections
int_r=22/2;// internal r of cylinder according to edmund optics
RMS_r=(0.8*25.4)/2; //10,16 mmm of r for DIN (and JIS) objectives that uses RMS, this is about 20.3mm (with thread step of about 0.7mm).
tube_r=29.85/2;//external size
c_mount_r=25.4/2; //for 1 inch standard C-mount diameter
internal_lens_hol=26; //where the Comar lens stays
RMS_mount_h=6; 
c_mount_h=4;
M27_r=27/2; //M27 threads
lens_holder_male_len=3.5; //length of male cylinder end that goes inside top part and holds the lens against the notch of top part 
focus_reg_len=19;// thread for focus adjustment
M3_brass_push_h=4;//for M3 screws
M3_brass_push_w=4;//for M3 screws
tot_len_top=15+5+10+11.3+4;//total len of a single piece A
ext_bot_len=11.3+10+5;
aper_int_h=22.5; //h of internal space 
foc_adj_r=21.5/2;//width of thread for focus control
int_focal_corr_h=16;//total length to adjust focus without crashing to lens of top bottom piece
int_focal_corr_r=18/2;
lens_holder_pos=8.5; //distance of lens holder notch from bottom end of top part 
tot_len_focus_adjust_tube=4+15+16;//16mm to not crash the lens inside the top bottom part
tot_len_bottom=6+40+5;//total length of the ext_tube section
fluo_top_h=26;
pol_ring_h=10;
fluo_bottom_h=25;//ext_fluo_bottom height
sens_x=8.5;
filter_cube_x=40;
filter_cube_y=40;
filter_cube_z=24;
x_triangle=19;//to have hipotenuse of >25
y_triangle=19;//to have hipotenuse of >25
collimated_r=x_triangle/2-x_triangle*0.05;
M3_r=3/2;
M3_h=10;
joint_x=5;
joint_y=5;
joint_z=2;
filter_cube_top_z=10;  
extra_doublet=10; 
MM_h=5;
$fn=60;


/* The organization of each module can be found here: http://interspecifics.cc/comunicacionesespeculativas/2018/03/09/tutorial-7-codigo-openscad-para-tubo-optico/

The order of modules - from top to bottom - is:

RPIcam_cover();
cam_adapter();
focus_adjust_tube();
lens_holder_ring();
CE_ext_tube();

*/


//RPIcam_cover();
//cam_adapter();
//focus_adjust_tube();
//lens_holder(); // or lens_holder_V2()
//lens_holder_ring();
//ext_tube(); // or ext_fluo_top() and ext_fluo_bottom() is using polarizers/filters
//camera_mount_FF();

module RPIcam_cover(){
    fit_corr=1.5;//makes it bigger to fit and avoid damaging the PCB
    
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
 
module cam_adapter(){

difference(){
union(){ 
       rotate([ 0.00, 0.00, 45.00 ])camera_mount_FF();
   color("lightblue") english_thread (diameter=((int_focal_corr_r*2)-(3*corr))/25.4, threads_per_inch=32, length=M3_brass_push_h/1.5/25.4,internal=false, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
}
   cylinder(r1=sens_x/2,r2=sens_x,h=sens_x, center=true,$fn=100);
}}
  

module focus_adjust_tube(){
    difference() {
    union(){ 
        translate([0,0,int_focal_corr_h]) color("lightblue") english_thread (diameter=(foc_adj_r*2)/25.4, threads_per_inch=32, length=16/25.4,internal=false, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
     cylinder(r=tube_r,h=int_focal_corr_h,$fn=100);}
    translate ([0.00,0.00,-(corr)]) color("red") english_thread (diameter=(int_focal_corr_r*2)/25.4, threads_per_inch=32, length=((tot_len_focus_adjust_tube)+(2*corr))/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
     }    
    }
    
module lens_holder(){//top part merges top part of Lens_mount (11.3mm), 10_ext and fine_focus
//render() {
echo(str ("tot_len_top is ",tot_len_top));
difference() {
     cylinder(r=tube_r,h=ext_bot_len,$fn=100);
     translate([ 0.00, 0.00, -corr ])   color ("lightblue") english_thread (diameter=(M27_r*2)/25.4, threads_per_inch=32, length=(lens_holder_pos+corr)/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
    translate([ 0.00, 0.00, corr ]) color ("red") english_thread (diameter=((foc_adj_r*2)+(3*corr))/25.4, threads_per_inch=32, length=((ext_bot_len)+(2*corr))/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
    translate([0,tube_r, ext_bot_len- M3_brass_push_h]) rotate([90,90,0]) cylinder(r=M3_brass_push_h/2,h=(M3_brass_push_h)*2,$fn=100);
    }}//} //uncomment if you want to use render() while editing
  
// lens_holderV2();     
module lens_holderV2(){//for doublet
    difference() {
        color("green") cylinder(r=tube_r,h=ext_bot_len+extra_doublet*2-corr,$fn=100);
        translate([ 0,0,-corr]) union(){ 
         translate([ 0.00, 0.00, -corr])   color ("lightblue") english_thread (diameter=(M27_r*2)/25.4, threads_per_inch=32, length=(lens_holder_pos+extra_doublet+corr)/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
    translate([ 0.00, 0.00, corr ]) color ("red") english_thread (diameter=((foc_adj_r*2)+(3*corr))/25.4, threads_per_inch=32, length=(ext_bot_len+extra_doublet*2+2*corr)/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
    translate([0,tube_r, ext_bot_len+extra_doublet- M3_brass_push_h]) rotate([90,90,0]) cylinder(r=M3_brass_push_h/2,h=(M3_brass_push_h)*2,$fn=100);
    }}}


  
module lens_holder_ring(){//internal lens retainer ring
tot_len=2.5;
difference() {
    color("red") english_thread (diameter=(((M27_r*2)-(corr*3))/25.4), threads_per_inch=32, length=tot_len/25.4,internal=false, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);// this creates an internal RMS thread for DIN objectives
    translate([ 0.00, 0.00, -corr ])cylinder(r=int_r,h=tot_len+corr*2);
    cube([ 1, 100, 2 ], center=true);
}}


module ext_tube(){//Bottom part replaces edmund optics parts: DIN_C_mount, 40_ext and the bottom half of Lens_mount
//render() {
difference() {
    union(){ 
        translate([0,0,tot_len_bottom/2]) color("lightblue") english_thread (diameter=((M27_r*2)-(3*corr))/25.4, threads_per_inch=32, length=3.5/25.4,internal=false, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
     cylinder(r=tube_r,h=tot_len_bottom, center=true,$fn=100);}
    union() { // this union is the complete internal thread, RMS for objective and anti-reflective internal surface
    translate ([0.00,0.00,-(tot_len_bottom/2)]) color("red") english_thread (diameter=((RMS_r*2)+corr*3)/25.4, threads_per_inch=36, length=(RMS_mount_h)/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);// this creates an internal RMS thread for DIN (and JIS) objectives 20.1mm / 0.7965" dia. 36 TPI, 55° Whitworth
    translate ([ 0.00, 0.00,-(tot_len_bottom/2) + RMS_mount_h])  color("green") english_thread (diameter=(int_r*2)/25.4, threads_per_inch=32, length=(tot_len_bottom *1.1)/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);// this creates an internal rough anti-reflective surface 
    }}}
 
module ext_fluo_top(){
    difference() {
    union(){ 
     translate([0,0,fluo_top_h/2]) color("lightblue") english_thread (diameter=((M27_r*2)-(3*corr))/25.4, threads_per_inch=32, length=3.5/25.4,internal=false, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
     cylinder(r=tube_r,h=fluo_top_h, center=true,$fn=100);}
    union() { // this union is the complete internal thread: anti-reflective internal surface + M27 for trapping the polarizer (or fluo filter) with the fluo_bottom
    translate ([0.00,0.00,-(fluo_top_h/2)]) color("red") english_thread (diameter=(int_r*2)/25.4, threads_per_inch=32, length=(fluo_top_h*2)/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);// this creates an internal M27 thread
    translate([ 0.00, 0.00, -((fluo_top_h/2)+corr)])   color ("green") english_thread (diameter=(M27_r*2)/25.4, threads_per_inch=32, length=(pol_ring_h+corr)/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
    }}}
    
module ext_fluo_bottom(){//Bottom part for fluorescent or polarizing filters
difference() {
    union(){ 
        translate([0,0,fluo_bottom_h/2]) color("lightblue") english_thread (diameter=((M27_r*2)-(3*corr))/25.4, threads_per_inch=32, length=3.5/25.4,internal=false, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);
     cylinder(r=tube_r,h=fluo_bottom_h, center=true,$fn=100);}
    union() { // this union is the complete internal thread, RMS for objective and anti-reflective internal surface
    translate ([0.00,0.00,-(fluo_bottom_h/2)]) color("red") english_thread (diameter=((RMS_r*2)+corr*3)/25.4, threads_per_inch=36, length=(RMS_mount_h)/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);// this creates an internal RMS thread for DIN (and JIS) objectives 20.1mm / 0.7965" dia. 36 TPI, 55° Whitworth
    translate ([ 0.00, 0.00,-(fluo_bottom_h/2) + RMS_mount_h])  color("green") english_thread (diameter=(int_r*2)/25.4, threads_per_inch=32, length=(fluo_bottom_h *1.1)/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);// this creates an internal rough anti-reflective surface 
    }}}
    

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




/* ------------------------------------------------------------------------
* ------------------------------------------------------------------------
* ------------------------------------------------------------------------
* all the modules below are to test your printing resolution
* ------------------------------------------------------------------------
* ------------------------------------------------------------------------
* ------------------------------------------------------------------------ */
    
module test_print_femaleC(){
//render() {
tot_len_bottom=10;//total len of a single piece bottom
difference() {
    cylinder(r=tube_r,h=tot_len_bottom,$fn=100);
    translate ([0.00,0.00,-(tot_len_bottom/3)]) color("red") 
    english_thread (diameter=(((c_mount_r*2)+(corr*3))/25.4), threads_per_inch=32, length=(tot_len_bottom *1.1)/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);// this creates an internal rough antireflective surface 
 }}
    
module test_print_femaleM27(){//Bottom part merges DIN_C_mount, 40_ext and the bottom half of Lens_mount
//render() {
tot_len_bottom=10;//total len of a single piece bottom
difference() {
    cylinder(r=tube_r,h=tot_len_bottom,$fn=100);
    translate ([0.00,0.00,-(tot_len_bottom/3)]) color("red") 
    english_thread (diameter=(((M27_r*2)+(corr*0))/25.4), threads_per_inch=32, length=(tot_len_bottom *1.1)/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);// this creates an internal rough antireflective surface 
 }}
 
 module test_femaleRMS(){//test printing resolution and fitting with RMS objectives, etc
tot_len_bottom=10;
echo(str ("int thread is ",((RMS_r*2)+corr*3))); 
difference() {
         cylinder(r=tube_r,h=tot_len_bottom/2);
    color("red") english_thread (diameter=((RMS_r*2)+corr*3)/25.4, threads_per_inch=36, length=tot_len_bottom/2/25.4,internal=true, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);// this creates an internal RMS thread for DIN (and JIS) objectives
}
}

module test_print_thread(){//test printing resolution and fitting between male and female threads 
    tot_len_bottom=10;
        translate([0,0,tot_len_bottom/2]) color("lightblue") english_thread (diameter=((c_mount_r*2)+2*corr)/25.4, threads_per_inch=32, length=(lens_holder_male_len)/25.4,internal=false, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);//this size (printed in a Zortrax M200 in high quality Z-ABS) fits perfectly in female Edmunds optics metallic parts 
         cylinder(r=tube_r,h=tot_len_bottom/2,$fn=100);
     }
     
module test_maleM27(){//test printing resolution and fitting between male and female threads 
    tot_len_bottom=10;
        translate([0,0,tot_len_bottom/2]) color("lightblue") english_thread (diameter=((M27_r*2)-3*corr)/25.4, threads_per_inch=32, length=(lens_holder_male_len*1.5)/25.4,internal=false, n_starts=1, thread_size=-1, groove=true,square=false, rectangle=0, angle=30, taper=0, leadin=1);//this size (printed in a Zortrax M200 in high quality Z-ABS) fits perfectly in female Edmunds optics metallic parts 
         cylinder(r=tube_r,h=tot_len_bottom/2,$fn=100);
     }
     

