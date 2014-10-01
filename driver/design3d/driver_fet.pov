//POVRay-File created by 3d41.ulp v###VERSIONDUMMY###
///home/kubuntu/Projects/tugas_akhir/driver/design3d/driver_fet.brd
//10/1/14 1:07 PM

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

#declare global_use_radiosity = on;

#declare global_ambient_mul = 1;
#declare global_ambient_mul_emit = 0;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare e3d_environment = off;

#local cam_x = 0;
#local cam_y = 222;
#local cam_z = -103;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -4;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#local pcb_wire_bridges = off;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 26;
#local lgt1_pos_y = 39;
#local lgt1_pos_z = 23;
#local lgt1_intense = 0.744743;
#local lgt2_pos_x = -26;
#local lgt2_pos_y = 39;
#local lgt2_pos_z = 23;
#local lgt2_intense = 0.744743;
#local lgt3_pos_x = 26;
#local lgt3_pos_y = 39;
#local lgt3_pos_z = -16;
#local lgt3_intense = 0.744743;
#local lgt4_pos_x = -26;
#local lgt4_pos_y = 39;
#local lgt4_pos_z = -16;
#local lgt4_intense = 0.744743;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 69.469000;
#declare pcb_y_size = 45.085000;
#declare pcb_layer1_used = 0;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(568);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "e3d_tools.inc"
#include "e3d_user.inc"

global_settings{charset utf8}

#if(e3d_environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-34.734500,0,-22.542500>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro DRIVER_FET(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<13.716000,23.241000><83.185000,23.241000>
<83.185000,23.241000><83.185000,68.326000>
<83.185000,68.326000><13.716000,68.326000>
<13.716000,68.326000><13.716000,23.241000>
texture{col_brd}}
}//End union(PCB)
//Holes(real)/Parts
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_JP1) #declare global_pack_JP1=yes; object {CON_PH_1X7()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<47.117000,0.000000,28.829000>}#end		//Header 2,54mm Grid 7Pin 1Row (jumper.lib) JP1  1X07
#ifndef(pack_MO1) #declare global_pack_MO1=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<31.750000,0.000000,54.610000>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) MO1  1X02
#ifndef(pack_MO2) #declare global_pack_MO2=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<64.770000,0.000000,54.610000>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) MO2  1X02
#ifndef(pack_OKA1) #declare global_pack_OKA1=yes; object {IC_DIS_DIP4("PC817","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<21.590000,0.000000,39.370000>}#end		//DIP4 OKA1 PC817 DIL04
#ifndef(pack_OKA2) #declare global_pack_OKA2=yes; object {IC_DIS_DIP4("PC817","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<54.610000,0.000000,39.370000>}#end		//DIP4 OKA2 PC817 DIL04
#ifndef(pack_OKB1) #declare global_pack_OKB1=yes; object {IC_DIS_DIP4("PC817","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<43.180000,0.000000,39.370000>}#end		//DIP4 OKB1 PC817 DIL04
#ifndef(pack_OKB2) #declare global_pack_OKB2=yes; object {IC_DIS_DIP4("PC817","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<76.200000,0.000000,39.370000>}#end		//DIP4 OKB2 PC817 DIL04
#ifndef(pack_QA1) #declare global_pack_QA1=yes; object {TR_TO220_3_V("IRF9530",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<25.400000,0.000000,60.960000>}#end		//TO220 vertical straight leads QA1 IRF9530 TO220BV
#ifndef(pack_QA2) #declare global_pack_QA2=yes; object {TR_TO220_3_V("IRF9530",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<57.150000,0.000000,60.960000>}#end		//TO220 vertical straight leads QA2 IRF9530 TO220BV
#ifndef(pack_QB1) #declare global_pack_QB1=yes; object {TR_TO220_3_V("IRF9530",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<35.560000,0.000000,60.960000>}#end		//TO220 vertical straight leads QB1 IRF9530 TO220BV
#ifndef(pack_QB2) #declare global_pack_QB2=yes; object {TR_TO220_3_V("IRF9530",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<68.580000,0.000000,60.960000>}#end		//TO220 vertical straight leads QB2 IRF9530 TO220BV
#ifndef(pack_QC1) #declare global_pack_QC1=yes; object {TR_TO220_3_V("IRF530",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<25.400000,0.000000,48.260000>}#end		//TO220 vertical straight leads QC1 IRF530 TO220BV
#ifndef(pack_QC2) #declare global_pack_QC2=yes; object {TR_TO220_3_V("IRF530",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<57.150000,0.000000,48.260000>}#end		//TO220 vertical straight leads QC2 IRF530 TO220BV
#ifndef(pack_QD1) #declare global_pack_QD1=yes; object {TR_TO220_3_V("IRF530",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<35.560000,0.000000,48.260000>}#end		//TO220 vertical straight leads QD1 IRF530 TO220BV
#ifndef(pack_QD2) #declare global_pack_QD2=yes; object {TR_TO220_3_V("IRF530",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<68.580000,0.000000,48.260000>}#end		//TO220 vertical straight leads QD2 IRF530 TO220BV
#ifndef(pack_RA1) #declare global_pack_RA1=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<17.780000,-1.500000,39.370000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RA1 330 R1206
#ifndef(pack_RA2) #declare global_pack_RA2=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<50.419000,-1.500000,39.243000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RA2 330 R1206
#ifndef(pack_RB1) #declare global_pack_RB1=yes; object {RES_SMD_CHIP_1206("472",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<20.574000,-1.500000,49.276000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RB1 4k7 R1206
#ifndef(pack_RB2) #declare global_pack_RB2=yes; object {RES_SMD_CHIP_1206("472",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<52.959000,-1.500000,49.530000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RB2 4k7 R1206
#ifndef(pack_RC1) #declare global_pack_RC1=yes; object {RES_SMD_CHIP_1206("472",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<44.450000,-1.500000,49.530000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RC1 4k7 R1206
#ifndef(pack_RC2) #declare global_pack_RC2=yes; object {RES_SMD_CHIP_1206("472",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<77.470000,-1.500000,49.530000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RC2 4k7 R1206
#ifndef(pack_RD1) #declare global_pack_RD1=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<39.243000,-1.500000,38.735000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RD1 330 R1206
#ifndef(pack_RD2) #declare global_pack_RD2=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<71.120000,-1.500000,38.100000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RD2 330 R1206
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<54.737000,0,28.829000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<52.197000,0,28.829000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<49.657000,0,28.829000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<47.117000,0,28.829000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<44.577000,0,28.829000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<42.037000,0,28.829000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<39.497000,0,28.829000> texture{col_thl}}
#ifndef(global_pack_MO1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_MO1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_MO2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.500000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_MO2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.040000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_OKA1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<20.320000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_OKA1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<22.860000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_OKA1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_OKA1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_OKA2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<53.340000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_OKA2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<55.880000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_OKA2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<55.880000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_OKA2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<53.340000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_OKB1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<41.910000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_OKB1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<44.450000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_OKB1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<44.450000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_OKB1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<41.910000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_OKB2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<74.930000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_OKB2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-270.000000,0>translate<77.470000,0,35.560000> texture{col_thl}}
#ifndef(global_pack_OKB2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<77.470000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_OKB2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,4+global_tmp,100) rotate<0,-90.000000,0>translate<74.930000,0,43.180000> texture{col_thl}}
#ifndef(global_pack_QA1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<27.940000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_QA1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<27.940000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_QA1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<27.940000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_QA2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<59.690000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_QA2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<59.690000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_QA2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<59.690000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_QB1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<38.100000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_QB1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<38.100000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_QB1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<38.100000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_QB2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<71.120000,0,60.960000> texture{col_thl}}
#ifndef(global_pack_QB2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<71.120000,0,58.420000> texture{col_thl}}
#ifndef(global_pack_QB2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<71.120000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_QC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<27.940000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_QC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<27.940000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_QC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<27.940000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_QC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<59.690000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_QC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<59.690000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_QC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<59.690000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_QD1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<38.100000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_QD1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<38.100000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_QD1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<38.100000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_QD2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<71.120000,0,48.260000> texture{col_thl}}
#ifndef(global_pack_QD2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<71.120000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_QD2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<71.120000,0,50.800000> texture{col_thl}}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<17.780000,-1.537000,37.948000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<17.780000,-1.537000,40.792000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<50.419000,-1.537000,37.821000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<50.419000,-1.537000,40.665000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<20.574000,-1.537000,47.854000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<20.574000,-1.537000,50.698000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<52.959000,-1.537000,48.108000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<52.959000,-1.537000,50.952000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<44.450000,-1.537000,48.108000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<44.450000,-1.537000,50.952000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<77.470000,-1.537000,48.108000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<77.470000,-1.537000,50.952000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<39.243000,-1.537000,37.313000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<39.243000,-1.537000,40.157000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<71.120000,-1.537000,36.678000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<71.120000,-1.537000,39.522000>}
//Pads/Vias
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,35.433000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,47.117000>}
box{<0,0,-0.304800><11.684000,0.035000,0.304800> rotate<0,90.000000,0> translate<15.240000,-1.535000,47.117000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,37.948000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.882000,-1.535000,37.846000>}
box{<0,0,-0.304800><0.144250,0.035000,0.304800> rotate<0,44.997030,0> translate<17.780000,-1.535000,37.948000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,47.117000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.796000,-1.535000,50.673000>}
box{<0,0,-0.304800><5.028943,0.035000,0.304800> rotate<0,-44.997030,0> translate<15.240000,-1.535000,47.117000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.882000,-1.535000,37.846000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,-1.535000,37.846000>}
box{<0,0,-0.304800><1.803000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.882000,-1.535000,37.846000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.240000,-1.535000,35.433000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.066000,-1.535000,30.607000>}
box{<0,0,-0.304800><6.824995,0.035000,0.304800> rotate<0,44.997030,0> translate<15.240000,-1.535000,35.433000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.685000,-1.535000,37.846000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,37.211000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<19.685000,-1.535000,37.846000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,37.211000>}
box{<0,0,-0.304800><1.651000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,37.211000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,47.600000>}
box{<0,0,-0.304800><4.420000,0.035000,0.304800> rotate<0,90.000000,0> translate<20.320000,-1.535000,47.600000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.796000,-1.535000,50.673000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.549000,-1.535000,50.673000>}
box{<0,0,-0.304800><1.753000,0.035000,0.304800> rotate<0,0.000000,0> translate<18.796000,-1.535000,50.673000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.320000,-1.535000,47.600000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.574000,-1.535000,47.854000>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,-44.997030,0> translate<20.320000,-1.535000,47.600000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.549000,-1.535000,50.673000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.574000,-1.535000,50.698000>}
box{<0,0,-0.304800><0.035355,0.035000,0.304800> rotate<0,-44.997030,0> translate<20.549000,-1.535000,50.673000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.574000,-1.535000,60.452000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.574000,-1.535000,50.698000>}
box{<0,0,-0.304800><9.754000,0.035000,0.304800> rotate<0,-90.000000,0> translate<20.574000,-1.535000,50.698000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.574000,-1.535000,47.854000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.726000,-1.535000,48.006000>}
box{<0,0,-0.304800><0.214960,0.035000,0.304800> rotate<0,-44.997030,0> translate<20.574000,-1.535000,47.854000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.726000,-1.535000,48.006000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,48.006000>}
box{<0,0,-0.304800><0.864000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.726000,-1.535000,48.006000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.590000,-1.535000,48.006000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.241000,-1.535000,49.657000>}
box{<0,0,-0.304800><2.334867,0.035000,0.304800> rotate<0,-44.997030,0> translate<21.590000,-1.535000,48.006000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.241000,-1.535000,47.371000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.241000,-1.535000,49.657000>}
box{<0,0,-0.304800><2.286000,0.035000,0.304800> rotate<0,90.000000,0> translate<23.241000,-1.535000,49.657000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.241000,-1.535000,49.657000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.304500,-1.535000,49.720500>}
box{<0,0,-0.304800><0.089803,0.035000,0.304800> rotate<0,-44.997030,0> translate<23.241000,-1.535000,49.657000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.304500,-1.535000,49.720500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.368000,-1.535000,49.784000>}
box{<0,0,-0.304800><0.089803,0.035000,0.304800> rotate<0,-44.997030,0> translate<23.304500,-1.535000,49.720500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.368000,-1.535000,53.467000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.368000,-1.535000,49.784000>}
box{<0,0,-0.304800><3.683000,0.035000,0.304800> rotate<0,-90.000000,0> translate<23.368000,-1.535000,49.784000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.574000,-1.535000,60.452000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.622000,-1.535000,63.500000>}
box{<0,0,-0.304800><4.310523,0.035000,0.304800> rotate<0,-44.997030,0> translate<20.574000,-1.535000,60.452000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.241000,-1.535000,47.371000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.892000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.334867,0.035000,0.304800> rotate<0,44.997030,0> translate<23.241000,-1.535000,47.371000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.273000,-1.535000,50.038000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.273000,-1.535000,47.879000>}
box{<0,0,-0.304800><2.159000,0.035000,0.304800> rotate<0,-90.000000,0> translate<25.273000,-1.535000,47.879000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.781000,-1.535000,32.639000>}
box{<0,0,-0.304800><4.130918,0.035000,0.304800> rotate<0,44.997030,0> translate<22.860000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.273000,-1.535000,50.038000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.077631,0.035000,0.304800> rotate<0,-44.997030,0> translate<25.273000,-1.535000,50.038000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.273000,-1.535000,47.879000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.162000,-1.535000,46.990000>}
box{<0,0,-0.304800><1.257236,0.035000,0.304800> rotate<0,44.997030,0> translate<25.273000,-1.535000,47.879000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.892000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,45.720000>}
box{<0,0,-0.304800><3.048000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.892000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.035000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.035000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.368000,-1.535000,53.467000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,58.039000>}
box{<0,0,-0.304800><6.465784,0.035000,0.304800> rotate<0,-44.997030,0> translate<23.368000,-1.535000,53.467000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,58.039000>}
box{<0,0,-0.304800><0.381000,0.035000,0.304800> rotate<0,-90.000000,0> translate<27.940000,-1.535000,58.039000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.622000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,63.500000>}
box{<0,0,-0.304800><4.318000,0.035000,0.304800> rotate<0,0.000000,0> translate<23.622000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.860000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,43.180000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<22.860000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.162000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.718000,-1.535000,46.990000>}
box{<0,0,-0.304800><3.556000,0.035000,0.304800> rotate<0,0.000000,0> translate<26.162000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.972000,-1.535000,60.960000>}
box{<0,0,-0.304800><2.032000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,-1.535000,44.069000>}
box{<0,0,-0.304800><1.257236,0.035000,0.304800> rotate<0,-44.997030,0> translate<29.210000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,-1.535000,46.609000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,-1.535000,44.069000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<30.099000,-1.535000,44.069000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.718000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,-1.535000,46.609000>}
box{<0,0,-0.304800><0.538815,0.035000,0.304800> rotate<0,44.997030,0> translate<29.718000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.353000,-1.535000,60.579000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.353000,-1.535000,54.737000>}
box{<0,0,-0.304800><5.842000,0.035000,0.304800> rotate<0,-90.000000,0> translate<30.353000,-1.535000,54.737000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.972000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.353000,-1.535000,60.579000>}
box{<0,0,-0.304800><0.538815,0.035000,0.304800> rotate<0,44.997030,0> translate<29.972000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.353000,-1.535000,54.737000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,54.610000>}
box{<0,0,-0.304800><0.179605,0.035000,0.304800> rotate<0,44.997030,0> translate<30.353000,-1.535000,54.737000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.861000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.921000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.861000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,48.514000>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.861000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.480000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,53.975000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<30.480000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,48.514000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.115000,-1.535000,53.975000>}
box{<0,0,-0.304800><5.461000,0.035000,0.304800> rotate<0,90.000000,0> translate<31.115000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,60.198000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,54.610000>}
box{<0,0,-0.304800><5.588000,0.035000,0.304800> rotate<0,-90.000000,0> translate<33.020000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.274000,-1.535000,54.356000>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,44.997030,0> translate<33.020000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.274000,-1.535000,49.403000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.274000,-1.535000,54.356000>}
box{<0,0,-0.304800><4.953000,0.035000,0.304800> rotate<0,90.000000,0> translate<33.274000,-1.535000,54.356000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,60.198000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.782000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.077631,0.035000,0.304800> rotate<0,-44.997030,0> translate<33.020000,-1.535000,60.198000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.274000,-1.535000,49.403000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.417000,-1.535000,48.260000>}
box{<0,0,-0.304800><1.616446,0.035000,0.304800> rotate<0,44.997030,0> translate<33.274000,-1.535000,49.403000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.687000,-1.535000,46.228000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.687000,-1.535000,43.942000>}
box{<0,0,-0.304800><2.286000,0.035000,0.304800> rotate<0,-90.000000,0> translate<35.687000,-1.535000,43.942000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.718000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.449000,-1.535000,46.990000>}
box{<0,0,-0.304800><6.731000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.718000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.687000,-1.535000,46.228000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.449000,-1.535000,46.990000>}
box{<0,0,-0.304800><1.077631,0.035000,0.304800> rotate<0,-44.997030,0> translate<35.687000,-1.535000,46.228000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.687000,-1.535000,43.942000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,42.799000>}
box{<0,0,-0.304800><1.616446,0.035000,0.304800> rotate<0,44.997030,0> translate<35.687000,-1.535000,43.942000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.780000,-1.535000,40.792000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.059000,-1.535000,40.792000>}
box{<0,0,-0.304800><19.279000,0.035000,0.304800> rotate<0,0.000000,0> translate<17.780000,-1.535000,40.792000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.059000,-1.535000,40.792000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.592000,-1.535000,40.259000>}
box{<0,0,-0.304800><0.753776,0.035000,0.304800> rotate<0,44.997030,0> translate<37.059000,-1.535000,40.792000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.066000,-1.535000,30.607000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.719000,-1.535000,30.607000>}
box{<0,0,-0.304800><17.653000,0.035000,0.304800> rotate<0,0.000000,0> translate<20.066000,-1.535000,30.607000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.417000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,48.260000>}
box{<0,0,-0.304800><3.683000,0.035000,0.304800> rotate<0,0.000000,0> translate<34.417000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.782000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,60.960000>}
box{<0,0,-0.304800><4.318000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.782000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.940000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,63.500000>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.940000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.243000,-1.535000,58.420000>}
box{<0,0,-0.304800><1.143000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.100000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.243000,-1.535000,37.313000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.345000,-1.535000,37.211000>}
box{<0,0,-0.304800><0.144250,0.035000,0.304800> rotate<0,44.997030,0> translate<39.243000,-1.535000,37.313000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.243000,-1.535000,40.157000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.345000,-1.535000,40.157000>}
box{<0,0,-0.304800><0.102000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.243000,-1.535000,40.157000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.345000,-1.535000,40.157000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,40.132000>}
box{<0,0,-0.304800><0.035355,0.035000,0.304800> rotate<0,44.997030,0> translate<39.345000,-1.535000,40.157000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.243000,-1.535000,40.157000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.395000,-1.535000,40.005000>}
box{<0,0,-0.304800><0.214960,0.035000,0.304800> rotate<0,44.997030,0> translate<39.243000,-1.535000,40.157000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.719000,-1.535000,30.607000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.497000,-1.535000,28.829000>}
box{<0,0,-0.304800><2.514472,0.035000,0.304800> rotate<0,44.997030,0> translate<37.719000,-1.535000,30.607000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.592000,-1.535000,40.259000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.497000,-1.535000,40.259000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<37.592000,-1.535000,40.259000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.395000,-1.535000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.751000,-1.535000,40.005000>}
box{<0,0,-0.304800><0.356000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.395000,-1.535000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.497000,-1.535000,40.259000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.751000,-1.535000,40.005000>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,44.997030,0> translate<39.497000,-1.535000,40.259000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.830000,-1.535000,42.799000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.751000,-1.535000,42.799000>}
box{<0,0,-0.304800><2.921000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.830000,-1.535000,42.799000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.878000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.778000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.100000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.449000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.259000,-1.535000,46.990000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.449000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.259000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.386000,-1.535000,47.117000>}
box{<0,0,-0.304800><0.179605,0.035000,0.304800> rotate<0,-44.997030,0> translate<40.259000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.386000,-1.535000,50.292000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.386000,-1.535000,47.117000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,-90.000000,0> translate<40.386000,-1.535000,47.117000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.878000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.386000,-1.535000,50.292000>}
box{<0,0,-0.304800><0.718420,0.035000,0.304800> rotate<0,44.997030,0> translate<39.878000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,43.180000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<38.100000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.751000,-1.535000,42.799000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.894000,-1.535000,41.656000>}
box{<0,0,-0.304800><1.616446,0.035000,0.304800> rotate<0,44.997030,0> translate<39.751000,-1.535000,42.799000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.345000,-1.535000,37.211000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.656000,-1.535000,37.211000>}
box{<0,0,-0.304800><2.311000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.345000,-1.535000,37.211000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.783000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.783000,-1.535000,50.775000>}
box{<0,0,-0.304800><5.105000,0.035000,0.304800> rotate<0,-90.000000,0> translate<41.783000,-1.535000,50.775000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.243000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.783000,-1.535000,55.880000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<39.243000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.656000,-1.535000,37.211000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,36.957000>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,44.997030,0> translate<41.656000,-1.535000,37.211000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,36.957000>}
box{<0,0,-0.304800><1.397000,0.035000,0.304800> rotate<0,90.000000,0> translate<41.910000,-1.535000,36.957000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.640000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,43.180000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.640000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.037000,-1.535000,28.829000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.037000,-1.535000,27.559000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<42.037000,-1.535000,27.559000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,63.500000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.100000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.100000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.434000,-1.535000,45.720000>}
box{<0,0,-0.304800><5.334000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.100000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.894000,-1.535000,41.656000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.069000,-1.535000,41.656000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<40.894000,-1.535000,41.656000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.196000,-1.535000,62.484000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.196000,-1.535000,51.206000>}
box{<0,0,-0.304800><11.278000,0.035000,0.304800> rotate<0,-90.000000,0> translate<44.196000,-1.535000,51.206000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.196000,-1.535000,62.484000>}
box{<0,0,-0.304800><1.436841,0.035000,0.304800> rotate<0,44.997030,0> translate<43.180000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.434000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.323000,-1.535000,46.609000>}
box{<0,0,-0.304800><1.257236,0.035000,0.304800> rotate<0,-44.997030,0> translate<43.434000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.323000,-1.535000,46.609000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.323000,-1.535000,47.981000>}
box{<0,0,-0.304800><1.372000,0.035000,0.304800> rotate<0,90.000000,0> translate<44.323000,-1.535000,47.981000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.037000,-1.535000,27.559000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,25.146000>}
box{<0,0,-0.304800><3.412497,0.035000,0.304800> rotate<0,44.997030,0> translate<42.037000,-1.535000,27.559000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.069000,-1.535000,41.656000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,42.037000>}
box{<0,0,-0.304800><0.538815,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.069000,-1.535000,41.656000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,42.037000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,43.180000>}
box{<0,0,-0.304800><1.143000,0.035000,0.304800> rotate<0,90.000000,0> translate<44.450000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.783000,-1.535000,50.775000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,48.108000>}
box{<0,0,-0.304800><3.771708,0.035000,0.304800> rotate<0,44.997030,0> translate<41.783000,-1.535000,50.775000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.323000,-1.535000,47.981000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,48.108000>}
box{<0,0,-0.304800><0.179605,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.323000,-1.535000,47.981000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.196000,-1.535000,51.206000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,50.952000>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,44.997030,0> translate<44.196000,-1.535000,51.206000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.577000,-1.535000,28.829000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.577000,-1.535000,27.305000>}
box{<0,0,-0.304800><1.524000,0.035000,0.304800> rotate<0,-90.000000,0> translate<44.577000,-1.535000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.577000,-1.535000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.466000,-1.535000,26.416000>}
box{<0,0,-0.304800><1.257236,0.035000,0.304800> rotate<0,44.997030,0> translate<44.577000,-1.535000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.736000,-1.535000,35.560000>}
box{<0,0,-0.304800><2.286000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.450000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.781000,-1.535000,32.639000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.117000,-1.535000,32.639000>}
box{<0,0,-0.304800><21.336000,0.035000,0.304800> rotate<0,0.000000,0> translate<25.781000,-1.535000,32.639000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.117000,-1.535000,28.829000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.117000,-1.535000,32.639000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<47.117000,-1.535000,32.639000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.736000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.657000,-1.535000,32.639000>}
box{<0,0,-0.304800><4.130918,0.035000,0.304800> rotate<0,44.997030,0> translate<46.736000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.657000,-1.535000,28.829000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.657000,-1.535000,32.639000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<49.657000,-1.535000,32.639000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.370000,-1.535000,40.132000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.886000,-1.535000,40.132000>}
box{<0,0,-0.304800><10.516000,0.035000,0.304800> rotate<0,0.000000,0> translate<39.370000,-1.535000,40.132000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.886000,-1.535000,40.132000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.419000,-1.535000,40.665000>}
box{<0,0,-0.304800><0.753776,0.035000,0.304800> rotate<0,-44.997030,0> translate<49.886000,-1.535000,40.132000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.292000,-1.535000,40.792000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.419000,-1.535000,40.665000>}
box{<0,0,-0.304800><0.179605,0.035000,0.304800> rotate<0,44.997030,0> translate<50.292000,-1.535000,40.792000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.419000,-1.535000,37.821000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.521000,-1.535000,37.719000>}
box{<0,0,-0.304800><0.144250,0.035000,0.304800> rotate<0,44.997030,0> translate<50.419000,-1.535000,37.821000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.181000,-1.535000,43.180000>}
box{<0,0,-0.304800><6.731000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.450000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.197000,-1.535000,28.829000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.197000,-1.535000,31.750000>}
box{<0,0,-0.304800><2.921000,0.035000,0.304800> rotate<0,90.000000,0> translate<52.197000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.181000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.451000,-1.535000,41.910000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<51.181000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.521000,-1.535000,37.719000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,37.719000>}
box{<0,0,-0.304800><2.184000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.521000,-1.535000,37.719000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.197000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.959000,-1.535000,32.512000>}
box{<0,0,-0.304800><1.077631,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.197000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,50.952000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.959000,-1.535000,50.952000>}
box{<0,0,-0.304800><8.509000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.450000,-1.535000,50.952000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.959000,-1.535000,50.952000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.086000,-1.535000,51.079000>}
box{<0,0,-0.304800><0.179605,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.959000,-1.535000,50.952000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.086000,-1.535000,61.849000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.086000,-1.535000,51.079000>}
box{<0,0,-0.304800><10.770000,0.035000,0.304800> rotate<0,-90.000000,0> translate<53.086000,-1.535000,51.079000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.705000,-1.535000,37.719000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,37.084000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<52.705000,-1.535000,37.719000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,37.084000>}
box{<0,0,-0.304800><1.524000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,37.084000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.959000,-1.535000,48.108000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,47.727000>}
box{<0,0,-0.304800><0.538815,0.035000,0.304800> rotate<0,44.997030,0> translate<52.959000,-1.535000,48.108000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.340000,-1.535000,47.727000>}
box{<0,0,-0.304800><4.547000,0.035000,0.304800> rotate<0,90.000000,0> translate<53.340000,-1.535000,47.727000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.737000,-1.535000,28.829000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.737000,-1.535000,30.988000>}
box{<0,0,-0.304800><2.159000,0.035000,0.304800> rotate<0,90.000000,0> translate<54.737000,-1.535000,30.988000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.086000,-1.535000,61.849000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.737000,-1.535000,63.500000>}
box{<0,0,-0.304800><2.334867,0.035000,0.304800> rotate<0,-44.997030,0> translate<53.086000,-1.535000,61.849000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.737000,-1.535000,30.988000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.991000,-1.535000,31.242000>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.737000,-1.535000,30.988000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.959000,-1.535000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.372000,-1.535000,32.512000>}
box{<0,0,-0.304800><2.413000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.959000,-1.535000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.959000,-1.535000,48.108000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.499000,-1.535000,50.648000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.959000,-1.535000,48.108000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.499000,-1.535000,48.006000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.499000,-1.535000,50.648000>}
box{<0,0,-0.304800><2.642000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.499000,-1.535000,50.648000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.499000,-1.535000,51.689000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.499000,-1.535000,50.648000>}
box{<0,0,-0.304800><1.041000,0.035000,0.304800> rotate<0,-90.000000,0> translate<55.499000,-1.535000,50.648000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.499000,-1.535000,55.626000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.499000,-1.535000,51.689000>}
box{<0,0,-0.304800><3.937000,0.035000,0.304800> rotate<0,-90.000000,0> translate<55.499000,-1.535000,51.689000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.451000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.626000,-1.535000,41.910000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.451000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.499000,-1.535000,48.006000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.626000,-1.535000,47.879000>}
box{<0,0,-0.304800><0.179605,0.035000,0.304800> rotate<0,44.997030,0> translate<55.499000,-1.535000,48.006000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.626000,-1.535000,47.752000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.626000,-1.535000,47.879000>}
box{<0,0,-0.304800><0.127000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.626000,-1.535000,47.879000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.372000,-1.535000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.753000,-1.535000,32.893000>}
box{<0,0,-0.304800><0.538815,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.372000,-1.535000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.753000,-1.535000,32.893000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.753000,-1.535000,35.433000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.753000,-1.535000,35.433000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.753000,-1.535000,35.433000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,35.560000>}
box{<0,0,-0.304800><0.179605,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.753000,-1.535000,35.433000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.626000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,42.164000>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.626000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,42.164000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,43.180000>}
box{<0,0,-0.304800><1.016000,0.035000,0.304800> rotate<0,90.000000,0> translate<55.880000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.007000,-1.535000,43.053000>}
box{<0,0,-0.304800><0.179605,0.035000,0.304800> rotate<0,44.997030,0> translate<55.880000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.466000,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.134000,-1.535000,26.416000>}
box{<0,0,-0.304800><10.668000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.466000,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.769000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.769000,-1.535000,48.260000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<56.769000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.023000,-1.535000,25.146000>}
box{<0,0,-0.304800><12.573000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.450000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.626000,-1.535000,47.752000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.658000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.873682,0.035000,0.304800> rotate<0,44.997030,0> translate<55.626000,-1.535000,47.752000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.769000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.039000,-1.535000,46.990000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<56.769000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.769000,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.039000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<56.769000,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.134000,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.166000,-1.535000,28.448000>}
box{<0,0,-0.304800><2.873682,0.035000,0.304800> rotate<0,-44.997030,0> translate<56.134000,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.166000,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.166000,-1.535000,29.845000>}
box{<0,0,-0.304800><1.397000,0.035000,0.304800> rotate<0,90.000000,0> translate<58.166000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.499000,-1.535000,55.626000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.293000,-1.535000,58.420000>}
box{<0,0,-0.304800><3.951313,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.499000,-1.535000,55.626000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.658000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.032000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.658000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.039000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.651000,0.035000,0.304800> rotate<0,0.000000,0> translate<58.039000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.293000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,58.420000>}
box{<0,0,-0.304800><1.397000,0.035000,0.304800> rotate<0,0.000000,0> translate<58.293000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.737000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,63.500000>}
box{<0,0,-0.304800><4.953000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.737000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.817000,-1.535000,61.087000>}
box{<0,0,-0.304800><0.179605,0.035000,0.304800> rotate<0,-44.997030,0> translate<59.690000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.023000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.071000,-1.535000,28.194000>}
box{<0,0,-0.304800><4.310523,0.035000,0.304800> rotate<0,-44.997030,0> translate<57.023000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.817000,-1.535000,61.087000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.468000,-1.535000,61.087000>}
box{<0,0,-0.304800><1.651000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.817000,-1.535000,61.087000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.007000,-1.535000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.849000,-1.535000,43.053000>}
box{<0,0,-0.304800><5.842000,0.035000,0.304800> rotate<0,0.000000,0> translate<56.007000,-1.535000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.039000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.849000,-1.535000,46.990000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<58.039000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.357000,-1.535000,48.260000>}
box{<0,0,-0.304800><2.667000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.690000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.849000,-1.535000,43.053000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.611000,-1.535000,43.815000>}
box{<0,0,-0.304800><1.077631,0.035000,0.304800> rotate<0,-44.997030,0> translate<61.849000,-1.535000,43.053000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.611000,-1.535000,46.228000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.611000,-1.535000,43.815000>}
box{<0,0,-0.304800><2.413000,0.035000,0.304800> rotate<0,-90.000000,0> translate<62.611000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.849000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.611000,-1.535000,46.228000>}
box{<0,0,-0.304800><1.077631,0.035000,0.304800> rotate<0,44.997030,0> translate<61.849000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.357000,-1.535000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,49.403000>}
box{<0,0,-0.304800><1.616446,0.035000,0.304800> rotate<0,-44.997030,0> translate<62.357000,-1.535000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,49.403000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,54.610000>}
box{<0,0,-0.304800><5.207000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.468000,-1.535000,61.087000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,59.055000>}
box{<0,0,-0.304800><2.873682,0.035000,0.304800> rotate<0,44.997030,0> translate<61.468000,-1.535000,61.087000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,-1.535000,59.055000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.500000,-1.535000,59.055000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,49.022000>}
box{<0,0,-0.304800><5.588000,0.035000,0.304800> rotate<0,-90.000000,0> translate<66.040000,-1.535000,49.022000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,60.452000>}
box{<0,0,-0.304800><5.842000,0.035000,0.304800> rotate<0,90.000000,0> translate<66.040000,-1.535000,60.452000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,60.452000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.548000,-1.535000,60.960000>}
box{<0,0,-0.304800><0.718420,0.035000,0.304800> rotate<0,-44.997030,0> translate<66.040000,-1.535000,60.452000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,-1.535000,49.022000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.056000,-1.535000,48.006000>}
box{<0,0,-0.304800><1.436841,0.035000,0.304800> rotate<0,44.997030,0> translate<66.040000,-1.535000,49.022000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.945000,-1.535000,46.609000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.945000,-1.535000,44.323000>}
box{<0,0,-0.304800><2.286000,0.035000,0.304800> rotate<0,-90.000000,0> translate<67.945000,-1.535000,44.323000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.849000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.326000,-1.535000,46.990000>}
box{<0,0,-0.304800><6.477000,0.035000,0.304800> rotate<0,0.000000,0> translate<61.849000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.945000,-1.535000,46.609000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.326000,-1.535000,46.990000>}
box{<0,0,-0.304800><0.538815,0.035000,0.304800> rotate<0,-44.997030,0> translate<67.945000,-1.535000,46.609000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.419000,-1.535000,40.665000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.977000,-1.535000,40.665000>}
box{<0,0,-0.304800><19.558000,0.035000,0.304800> rotate<0,0.000000,0> translate<50.419000,-1.535000,40.665000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.945000,-1.535000,44.323000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,41.783000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<67.945000,-1.535000,44.323000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.056000,-1.535000,48.006000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.866000,-1.535000,48.006000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<67.056000,-1.535000,48.006000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.977000,-1.535000,40.665000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,39.522000>}
box{<0,0,-0.304800><1.616446,0.035000,0.304800> rotate<0,44.997030,0> translate<69.977000,-1.535000,40.665000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,43.688000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,45.720000>}
box{<0,0,-0.304800><2.032000,0.035000,0.304800> rotate<0,90.000000,0> translate<71.120000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.866000,-1.535000,48.006000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,48.260000>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.866000,-1.535000,48.006000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.548000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,60.960000>}
box{<0,0,-0.304800><4.572000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.548000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.690000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,63.500000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.690000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,36.678000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.145000,-1.535000,36.703000>}
box{<0,0,-0.304800><0.035355,0.035000,0.304800> rotate<0,-44.997030,0> translate<71.120000,-1.535000,36.678000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,39.522000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.145000,-1.535000,39.497000>}
box{<0,0,-0.304800><0.035355,0.035000,0.304800> rotate<0,44.997030,0> translate<71.120000,-1.535000,39.522000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.374000,-1.535000,45.974000>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,-44.997030,0> translate<71.120000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,43.688000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.628000,-1.535000,43.180000>}
box{<0,0,-0.304800><0.718420,0.035000,0.304800> rotate<0,44.997030,0> translate<71.120000,-1.535000,43.688000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.326000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.644000,-1.535000,46.990000>}
box{<0,0,-0.304800><4.318000,0.035000,0.304800> rotate<0,0.000000,0> translate<68.326000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.374000,-1.535000,45.974000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.898000,-1.535000,45.974000>}
box{<0,0,-0.304800><1.524000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.374000,-1.535000,45.974000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.898000,-1.535000,50.800000>}
box{<0,0,-0.304800><1.778000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.120000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.644000,-1.535000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,48.006000>}
box{<0,0,-0.304800><1.436841,0.035000,0.304800> rotate<0,-44.997030,0> translate<72.644000,-1.535000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,50.038000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,48.006000>}
box{<0,0,-0.304800><2.032000,0.035000,0.304800> rotate<0,-90.000000,0> translate<73.660000,-1.535000,48.006000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.898000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.660000,-1.535000,50.038000>}
box{<0,0,-0.304800><1.077631,0.035000,0.304800> rotate<0,44.997030,0> translate<72.898000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.145000,-1.535000,36.703000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.041000,-1.535000,36.703000>}
box{<0,0,-0.304800><2.896000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.145000,-1.535000,36.703000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.168000,-1.535000,58.420000>}
box{<0,0,-0.304800><3.048000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.120000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.549000,-1.535000,63.500000>}
box{<0,0,-0.304800><3.429000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.120000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.041000,-1.535000,36.703000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,35.814000>}
box{<0,0,-0.304800><1.257236,0.035000,0.304800> rotate<0,44.997030,0> translate<74.041000,-1.535000,36.703000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,35.814000>}
box{<0,0,-0.304800><0.254000,0.035000,0.304800> rotate<0,90.000000,0> translate<74.930000,-1.535000,35.814000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.628000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.930000,-1.535000,43.180000>}
box{<0,0,-0.304800><3.302000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.628000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.898000,-1.535000,45.974000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.032000,-1.535000,48.108000>}
box{<0,0,-0.304800><3.017932,0.035000,0.304800> rotate<0,-44.997030,0> translate<72.898000,-1.535000,45.974000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,57.023000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,48.743000>}
box{<0,0,-0.304800><8.280000,0.035000,0.304800> rotate<0,-90.000000,0> translate<75.565000,-1.535000,48.743000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.168000,-1.535000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,57.023000>}
box{<0,0,-0.304800><1.975656,0.035000,0.304800> rotate<0,44.997030,0> translate<74.168000,-1.535000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.991000,-1.535000,31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.946000,-1.535000,31.242000>}
box{<0,0,-0.304800><20.955000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.991000,-1.535000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,-1.535000,41.783000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.073000,-1.535000,41.783000>}
box{<0,0,-0.304800><5.588000,0.035000,0.304800> rotate<0,0.000000,0> translate<70.485000,-1.535000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.032000,-1.535000,48.108000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,48.108000>}
box{<0,0,-0.304800><1.168000,0.035000,0.304800> rotate<0,0.000000,0> translate<75.032000,-1.535000,48.108000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.565000,-1.535000,48.743000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,48.108000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<75.565000,-1.535000,48.743000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.166000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,29.845000>}
box{<0,0,-0.304800><18.669000,0.035000,0.304800> rotate<0,0.000000,0> translate<58.166000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.343000,-1.535000,60.706000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.343000,-1.535000,51.079000>}
box{<0,0,-0.304800><9.627000,0.035000,0.304800> rotate<0,-90.000000,0> translate<77.343000,-1.535000,51.079000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.549000,-1.535000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.343000,-1.535000,60.706000>}
box{<0,0,-0.304800><3.951313,0.035000,0.304800> rotate<0,44.997030,0> translate<74.549000,-1.535000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.073000,-1.535000,41.783000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,43.180000>}
box{<0,0,-0.304800><1.975656,0.035000,0.304800> rotate<0,-44.997030,0> translate<76.073000,-1.535000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,48.108000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,48.108000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.200000,-1.535000,48.108000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.343000,-1.535000,51.079000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,50.952000>}
box{<0,0,-0.304800><0.179605,0.035000,0.304800> rotate<0,44.997030,0> translate<77.343000,-1.535000,51.079000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.946000,-1.535000,31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.597000,-1.535000,32.893000>}
box{<0,0,-0.304800><2.334867,0.035000,0.304800> rotate<0,-44.997030,0> translate<75.946000,-1.535000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.597000,-1.535000,35.433000>}
box{<0,0,-0.304800><0.179605,0.035000,0.304800> rotate<0,44.997030,0> translate<77.470000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.597000,-1.535000,32.893000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.597000,-1.535000,35.433000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<77.597000,-1.535000,35.433000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.071000,-1.535000,28.194000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.724000,-1.535000,28.194000>}
box{<0,0,-0.304800><17.653000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.071000,-1.535000,28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.835000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.248000,-1.535000,32.258000>}
box{<0,0,-0.304800><3.412497,0.035000,0.304800> rotate<0,-44.997030,0> translate<76.835000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.145000,-1.535000,39.497000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.248000,-1.535000,39.497000>}
box{<0,0,-0.304800><8.103000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.145000,-1.535000,39.497000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.248000,-1.535000,32.258000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.248000,-1.535000,39.497000>}
box{<0,0,-0.304800><7.239000,0.035000,0.304800> rotate<0,90.000000,0> translate<79.248000,-1.535000,39.497000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.470000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,43.180000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<77.470000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.724000,-1.535000,28.194000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,31.115000>}
box{<0,0,-0.304800><4.130918,0.035000,0.304800> rotate<0,-44.997030,0> translate<77.724000,-1.535000,28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.010000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,42.545000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<80.010000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.645000,-1.535000,42.545000>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<80.645000,-1.535000,42.545000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.589000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.843000,-1.535000,68.326000>}
box{<0,0,-0.304800><44.831720,0.035000,0.304800> rotate<0,-89.669463,0> translate<13.589000,-1.535000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.589000,-1.535000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,23.495000>}
box{<0,0,-0.304800><69.215000,0.035000,0.304800> rotate<0,0.000000,0> translate<13.589000,-1.535000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.590581,-1.535000,23.774400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.044422,-1.535000,23.774400>}
box{<0,0,-0.304800><30.453841,0.035000,0.304800> rotate<0,0.000000,0> translate<13.590581,-1.535000,23.774400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.594034,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.200422,-1.535000,24.384000>}
box{<0,0,-0.304800><29.606388,0.035000,0.304800> rotate<0,0.000000,0> translate<13.594034,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.597491,-1.535000,24.993600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.590822,-1.535000,24.993600>}
box{<0,0,-0.304800><28.993331,0.035000,0.304800> rotate<0,0.000000,0> translate<13.597491,-1.535000,24.993600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.600944,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.981222,-1.535000,25.603200>}
box{<0,0,-0.304800><28.380278,0.035000,0.304800> rotate<0,0.000000,0> translate<13.600944,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.604397,-1.535000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.061800,-1.535000,26.212800>}
box{<0,0,-0.304800><25.457403,0.035000,0.304800> rotate<0,0.000000,0> translate<13.604397,-1.535000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.607850,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.083444,-1.535000,26.822400>}
box{<0,0,-0.304800><24.475594,0.035000,0.304800> rotate<0,0.000000,0> translate<13.607850,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.611303,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.725559,-1.535000,27.432000>}
box{<0,0,-0.304800><24.114256,0.035000,0.304800> rotate<0,0.000000,0> translate<13.611303,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.614759,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.617400,-1.535000,28.041600>}
box{<0,0,-0.304800><24.002641,0.035000,0.304800> rotate<0,0.000000,0> translate<13.614759,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.618213,-1.535000,28.651200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.617400,-1.535000,28.651200>}
box{<0,0,-0.304800><23.999188,0.035000,0.304800> rotate<0,0.000000,0> translate<13.618213,-1.535000,28.651200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.621666,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.599100,-1.535000,29.260800>}
box{<0,0,-0.304800><5.977434,0.035000,0.304800> rotate<0,0.000000,0> translate<13.621666,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.625119,-1.535000,29.870400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.791022,-1.535000,29.870400>}
box{<0,0,-0.304800><5.165903,0.035000,0.304800> rotate<0,0.000000,0> translate<13.625119,-1.535000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.628575,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.181422,-1.535000,30.480000>}
box{<0,0,-0.304800><4.552847,0.035000,0.304800> rotate<0,0.000000,0> translate<13.628575,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.632028,-1.535000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.571822,-1.535000,31.089600>}
box{<0,0,-0.304800><3.939794,0.035000,0.304800> rotate<0,0.000000,0> translate<13.632028,-1.535000,31.089600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.635481,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.962222,-1.535000,31.699200>}
box{<0,0,-0.304800><3.326741,0.035000,0.304800> rotate<0,0.000000,0> translate<13.635481,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.638934,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.352622,-1.535000,32.308800>}
box{<0,0,-0.304800><2.713688,0.035000,0.304800> rotate<0,0.000000,0> translate<13.638934,-1.535000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.642387,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.743022,-1.535000,32.918400>}
box{<0,0,-0.304800><2.100634,0.035000,0.304800> rotate<0,0.000000,0> translate<13.642387,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.645844,-1.535000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.133422,-1.535000,33.528000>}
box{<0,0,-0.304800><1.487578,0.035000,0.304800> rotate<0,0.000000,0> translate<13.645844,-1.535000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.649297,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.523822,-1.535000,34.137600>}
box{<0,0,-0.304800><0.874525,0.035000,0.304800> rotate<0,0.000000,0> translate<13.649297,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.652750,-1.535000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.984472,-1.535000,34.747200>}
box{<0,0,-0.304800><0.331722,0.035000,0.304800> rotate<0,0.000000,0> translate<13.652750,-1.535000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.656203,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,35.356800>}
box{<0,0,-0.304800><0.161397,0.035000,0.304800> rotate<0,0.000000,0> translate<13.656203,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.659659,-1.535000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,35.966400>}
box{<0,0,-0.304800><0.157941,0.035000,0.304800> rotate<0,0.000000,0> translate<13.659659,-1.535000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.663113,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,36.576000>}
box{<0,0,-0.304800><0.154488,0.035000,0.304800> rotate<0,0.000000,0> translate<13.663113,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.666566,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,37.185600>}
box{<0,0,-0.304800><0.151034,0.035000,0.304800> rotate<0,0.000000,0> translate<13.666566,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.670019,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,37.795200>}
box{<0,0,-0.304800><0.147581,0.035000,0.304800> rotate<0,0.000000,0> translate<13.670019,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.673472,-1.535000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,38.404800>}
box{<0,0,-0.304800><0.144128,0.035000,0.304800> rotate<0,0.000000,0> translate<13.673472,-1.535000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.676928,-1.535000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,39.014400>}
box{<0,0,-0.304800><0.140672,0.035000,0.304800> rotate<0,0.000000,0> translate<13.676928,-1.535000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.680381,-1.535000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,39.624000>}
box{<0,0,-0.304800><0.137219,0.035000,0.304800> rotate<0,0.000000,0> translate<13.680381,-1.535000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.683834,-1.535000,40.233600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,40.233600>}
box{<0,0,-0.304800><0.133766,0.035000,0.304800> rotate<0,0.000000,0> translate<13.683834,-1.535000,40.233600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.687288,-1.535000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,40.843200>}
box{<0,0,-0.304800><0.130313,0.035000,0.304800> rotate<0,0.000000,0> translate<13.687288,-1.535000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.690744,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,41.452800>}
box{<0,0,-0.304800><0.126856,0.035000,0.304800> rotate<0,0.000000,0> translate<13.690744,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.694197,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,42.062400>}
box{<0,0,-0.304800><0.123403,0.035000,0.304800> rotate<0,0.000000,0> translate<13.694197,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.697650,-1.535000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,42.672000>}
box{<0,0,-0.304800><0.119950,0.035000,0.304800> rotate<0,0.000000,0> translate<13.697650,-1.535000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.701103,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,43.281600>}
box{<0,0,-0.304800><0.116497,0.035000,0.304800> rotate<0,0.000000,0> translate<13.701103,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.704556,-1.535000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,43.891200>}
box{<0,0,-0.304800><0.113044,0.035000,0.304800> rotate<0,0.000000,0> translate<13.704556,-1.535000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.708013,-1.535000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,44.500800>}
box{<0,0,-0.304800><0.109587,0.035000,0.304800> rotate<0,0.000000,0> translate<13.708013,-1.535000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.711466,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,45.110400>}
box{<0,0,-0.304800><0.106134,0.035000,0.304800> rotate<0,0.000000,0> translate<13.711466,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.714919,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,45.720000>}
box{<0,0,-0.304800><0.102681,0.035000,0.304800> rotate<0,0.000000,0> translate<13.714919,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.718372,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,46.329600>}
box{<0,0,-0.304800><0.099228,0.035000,0.304800> rotate<0,0.000000,0> translate<13.718372,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.721828,-1.535000,46.939200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,46.939200>}
box{<0,0,-0.304800><0.095772,0.035000,0.304800> rotate<0,0.000000,0> translate<13.721828,-1.535000,46.939200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.725281,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.879266,-1.535000,47.548800>}
box{<0,0,-0.304800><0.153984,0.035000,0.304800> rotate<0,0.000000,0> translate<13.725281,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.728734,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.269825,-1.535000,48.158400>}
box{<0,0,-0.304800><0.541091,0.035000,0.304800> rotate<0,0.000000,0> translate<13.728734,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.732188,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.879425,-1.535000,48.768000>}
box{<0,0,-0.304800><1.147238,0.035000,0.304800> rotate<0,0.000000,0> translate<13.732188,-1.535000,48.768000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.735641,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.489025,-1.535000,49.377600>}
box{<0,0,-0.304800><1.753384,0.035000,0.304800> rotate<0,0.000000,0> translate<13.735641,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.739097,-1.535000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.098625,-1.535000,49.987200>}
box{<0,0,-0.304800><2.359528,0.035000,0.304800> rotate<0,0.000000,0> translate<13.739097,-1.535000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.742550,-1.535000,50.596800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.708225,-1.535000,50.596800>}
box{<0,0,-0.304800><2.965675,0.035000,0.304800> rotate<0,0.000000,0> translate<13.742550,-1.535000,50.596800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.746003,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.317825,-1.535000,51.206400>}
box{<0,0,-0.304800><3.571822,0.035000,0.304800> rotate<0,0.000000,0> translate<13.746003,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.749456,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.927425,-1.535000,51.816000>}
box{<0,0,-0.304800><4.177969,0.035000,0.304800> rotate<0,0.000000,0> translate<13.749456,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.752913,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.019575,-1.535000,52.425600>}
box{<0,0,-0.304800><5.266662,0.035000,0.304800> rotate<0,0.000000,0> translate<13.752913,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.756366,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,53.035200>}
box{<0,0,-0.304800><5.395234,0.035000,0.304800> rotate<0,0.000000,0> translate<13.756366,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.759819,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,53.644800>}
box{<0,0,-0.304800><5.391781,0.035000,0.304800> rotate<0,0.000000,0> translate<13.759819,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.763272,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,54.254400>}
box{<0,0,-0.304800><5.388328,0.035000,0.304800> rotate<0,0.000000,0> translate<13.763272,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.766725,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,54.864000>}
box{<0,0,-0.304800><5.384875,0.035000,0.304800> rotate<0,0.000000,0> translate<13.766725,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.770181,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,55.473600>}
box{<0,0,-0.304800><5.381419,0.035000,0.304800> rotate<0,0.000000,0> translate<13.770181,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.773634,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,56.083200>}
box{<0,0,-0.304800><5.377966,0.035000,0.304800> rotate<0,0.000000,0> translate<13.773634,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.777088,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,56.692800>}
box{<0,0,-0.304800><5.374513,0.035000,0.304800> rotate<0,0.000000,0> translate<13.777088,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.780541,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,57.302400>}
box{<0,0,-0.304800><5.371059,0.035000,0.304800> rotate<0,0.000000,0> translate<13.780541,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.783997,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,57.912000>}
box{<0,0,-0.304800><5.367603,0.035000,0.304800> rotate<0,0.000000,0> translate<13.783997,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.787450,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,58.521600>}
box{<0,0,-0.304800><5.364150,0.035000,0.304800> rotate<0,0.000000,0> translate<13.787450,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.790903,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,59.131200>}
box{<0,0,-0.304800><5.360697,0.035000,0.304800> rotate<0,0.000000,0> translate<13.790903,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.794356,-1.535000,59.740800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,59.740800>}
box{<0,0,-0.304800><5.357244,0.035000,0.304800> rotate<0,0.000000,0> translate<13.794356,-1.535000,59.740800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.797809,-1.535000,60.350400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,60.350400>}
box{<0,0,-0.304800><5.353791,0.035000,0.304800> rotate<0,0.000000,0> translate<13.797809,-1.535000,60.350400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.801266,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.244828,-1.535000,60.960000>}
box{<0,0,-0.304800><5.443563,0.035000,0.304800> rotate<0,0.000000,0> translate<13.801266,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.804719,-1.535000,61.569600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.680025,-1.535000,61.569600>}
box{<0,0,-0.304800><5.875306,0.035000,0.304800> rotate<0,0.000000,0> translate<13.804719,-1.535000,61.569600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.808172,-1.535000,62.179200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.289625,-1.535000,62.179200>}
box{<0,0,-0.304800><6.481453,0.035000,0.304800> rotate<0,0.000000,0> translate<13.808172,-1.535000,62.179200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.811625,-1.535000,62.788800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.899225,-1.535000,62.788800>}
box{<0,0,-0.304800><7.087600,0.035000,0.304800> rotate<0,0.000000,0> translate<13.811625,-1.535000,62.788800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.815081,-1.535000,63.398400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.508825,-1.535000,63.398400>}
box{<0,0,-0.304800><7.693744,0.035000,0.304800> rotate<0,0.000000,0> translate<13.815081,-1.535000,63.398400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,35.150066>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.034147,-1.535000,34.627275>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,67.495554,0> translate<13.817600,-1.535000,35.150066> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,47.399931>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,35.150066>}
box{<0,0,-0.304800><12.249866,0.035000,0.304800> rotate<0,-90.000000,0> translate<13.817600,-1.535000,35.150066> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.817600,-1.535000,47.399931>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.034147,-1.535000,47.922722>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-67.495554,0> translate<13.817600,-1.535000,47.399931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.818534,-1.535000,64.008000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.118425,-1.535000,64.008000>}
box{<0,0,-0.304800><8.299891,0.035000,0.304800> rotate<0,0.000000,0> translate<13.818534,-1.535000,64.008000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.821988,-1.535000,64.617600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.728025,-1.535000,64.617600>}
box{<0,0,-0.304800><8.906038,0.035000,0.304800> rotate<0,0.000000,0> translate<13.821988,-1.535000,64.617600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.825441,-1.535000,65.227200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.436206,-1.535000,65.227200>}
box{<0,0,-0.304800><12.610766,0.035000,0.304800> rotate<0,0.000000,0> translate<13.825441,-1.535000,65.227200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.828897,-1.535000,65.836800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,65.836800>}
box{<0,0,-0.304800><68.975103,0.035000,0.304800> rotate<0,0.000000,0> translate<13.828897,-1.535000,65.836800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.832350,-1.535000,66.446400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,66.446400>}
box{<0,0,-0.304800><68.971650,0.035000,0.304800> rotate<0,0.000000,0> translate<13.832350,-1.535000,66.446400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.835803,-1.535000,67.056000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,67.056000>}
box{<0,0,-0.304800><68.968197,0.035000,0.304800> rotate<0,0.000000,0> translate<13.835803,-1.535000,67.056000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.839256,-1.535000,67.665600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,67.665600>}
box{<0,0,-0.304800><68.964744,0.035000,0.304800> rotate<0,0.000000,0> translate<13.839256,-1.535000,67.665600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.842709,-1.535000,68.275200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.635200,-1.535000,68.275200>}
box{<0,0,-0.304800><13.792491,0.035000,0.304800> rotate<0,0.000000,0> translate<13.842709,-1.535000,68.275200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.843000,-1.535000,68.326000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,68.072000>}
box{<0,0,-0.304800><68.961468,0.035000,0.304800> rotate<0,0.211019,0> translate<13.843000,-1.535000,68.326000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.034147,-1.535000,34.627275>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.434275,-1.535000,34.227147>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,44.997030,0> translate<14.034147,-1.535000,34.627275> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.034147,-1.535000,47.922722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.990275,-1.535000,51.878850>}
box{<0,0,-0.304800><5.594810,0.035000,0.304800> rotate<0,-44.997030,0> translate<14.034147,-1.535000,47.922722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.434275,-1.535000,34.227147>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.260275,-1.535000,29.401147>}
box{<0,0,-0.304800><6.824995,0.035000,0.304800> rotate<0,44.997030,0> translate<14.434275,-1.535000,34.227147> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,36.022175>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,36.030400>}
box{<0,0,-0.304800><0.008225,0.035000,0.304800> rotate<0,90.000000,0> translate<16.662397,-1.535000,36.030400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,36.022175>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,34.142569>}
box{<0,0,-0.304800><2.658162,0.035000,0.304800> rotate<0,44.997078,0> translate<16.662397,-1.535000,36.022175> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,36.030400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.590356,-1.535000,36.030400>}
box{<0,0,-0.304800><1.927959,0.035000,0.304800> rotate<0,0.000000,0> translate<16.662397,-1.535000,36.030400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,42.709597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,46.527822>}
box{<0,0,-0.304800><3.818225,0.035000,0.304800> rotate<0,90.000000,0> translate<16.662397,-1.535000,46.527822> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,42.709597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.590356,-1.535000,42.709597>}
box{<0,0,-0.304800><1.927959,0.035000,0.304800> rotate<0,0.000000,0> translate<16.662397,-1.535000,42.709597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,43.281600>}
box{<0,0,-0.304800><1.879603,0.035000,0.304800> rotate<0,0.000000,0> translate<16.662397,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,43.891200>}
box{<0,0,-0.304800><1.879603,0.035000,0.304800> rotate<0,0.000000,0> translate<16.662397,-1.535000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,44.500800>}
box{<0,0,-0.304800><1.879603,0.035000,0.304800> rotate<0,0.000000,0> translate<16.662397,-1.535000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.648013,-1.535000,45.110400>}
box{<0,0,-0.304800><1.985616,0.035000,0.304800> rotate<0,0.000000,0> translate<16.662397,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.897600,-1.535000,45.720000>}
box{<0,0,-0.304800><2.235203,0.035000,0.304800> rotate<0,0.000000,0> translate<16.662397,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.816372,-1.535000,46.329600>}
box{<0,0,-0.304800><2.153975,0.035000,0.304800> rotate<0,0.000000,0> translate<16.662397,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.662397,-1.535000,46.527822>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.554900,-1.535000,48.420328>}
box{<0,0,-0.304800><2.676406,0.035000,0.304800> rotate<0,-44.997077,0> translate<16.662397,-1.535000,46.527822> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<16.718172,-1.535000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.563847,-1.535000,35.966400>}
box{<0,0,-0.304800><1.845675,0.035000,0.304800> rotate<0,0.000000,0> translate<16.718172,-1.535000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.073772,-1.535000,46.939200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.554900,-1.535000,46.939200>}
box{<0,0,-0.304800><1.481128,0.035000,0.304800> rotate<0,0.000000,0> translate<17.073772,-1.535000,46.939200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.327772,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,35.356800>}
box{<0,0,-0.304800><1.214228,0.035000,0.304800> rotate<0,0.000000,0> translate<17.327772,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.683372,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.554900,-1.535000,47.548800>}
box{<0,0,-0.304800><0.871528,0.035000,0.304800> rotate<0,0.000000,0> translate<17.683372,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.937372,-1.535000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,34.747200>}
box{<0,0,-0.304800><0.604628,0.035000,0.304800> rotate<0,0.000000,0> translate<17.937372,-1.535000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<17.990275,-1.535000,51.878850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.513066,-1.535000,52.095397>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-22.498506,0> translate<17.990275,-1.535000,51.878850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.292972,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.554900,-1.535000,48.158400>}
box{<0,0,-0.304800><0.261928,0.035000,0.304800> rotate<0,0.000000,0> translate<18.292972,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.513066,-1.535000,52.095397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.710269,-1.535000,52.095397>}
box{<0,0,-0.304800><0.197203,0.035000,0.304800> rotate<0,0.000000,0> translate<18.513066,-1.535000,52.095397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,35.913666>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,34.142569>}
box{<0,0,-0.304800><1.771097,0.035000,0.304800> rotate<0,-90.000000,0> translate<18.542000,-1.535000,34.142569> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,35.913666>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.590356,-1.535000,36.030400>}
box{<0,0,-0.304800><0.126354,0.035000,0.304800> rotate<0,-67.494168,0> translate<18.542000,-1.535000,35.913666> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,42.826331>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.590356,-1.535000,42.709597>}
box{<0,0,-0.304800><0.126354,0.035000,0.304800> rotate<0,67.494168,0> translate<18.542000,-1.535000,42.826331> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,44.854466>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,42.826331>}
box{<0,0,-0.304800><2.028134,0.035000,0.304800> rotate<0,-90.000000,0> translate<18.542000,-1.535000,42.826331> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.542000,-1.535000,44.854466>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.812684,-1.535000,45.507953>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,-67.495471,0> translate<18.542000,-1.535000,44.854466> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.554900,-1.535000,46.831694>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.725044,-1.535000,46.420928>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,67.495658,0> translate<18.554900,-1.535000,46.831694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.554900,-1.535000,48.420328>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.554900,-1.535000,46.831694>}
box{<0,0,-0.304800><1.588634,0.035000,0.304800> rotate<0,-90.000000,0> translate<18.554900,-1.535000,46.831694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.710269,-1.535000,52.095397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.725044,-1.535000,52.131069>}
box{<0,0,-0.304800><0.038611,0.035000,0.304800> rotate<0,-67.496607,0> translate<18.710269,-1.535000,52.095397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.725044,-1.535000,46.420928>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.897600,-1.535000,46.248372>}
box{<0,0,-0.304800><0.244031,0.035000,0.304800> rotate<0,44.997030,0> translate<18.725044,-1.535000,46.420928> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.725044,-1.535000,52.131069>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.039428,-1.535000,52.445453>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,-44.997030,0> translate<18.725044,-1.535000,52.131069> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.812684,-1.535000,45.507953>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.897600,-1.535000,45.592866>}
box{<0,0,-0.304800><0.120087,0.035000,0.304800> rotate<0,-44.995976,0> translate<18.812684,-1.535000,45.507953> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.897600,-1.535000,46.248372>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.897600,-1.535000,45.592866>}
box{<0,0,-0.304800><0.655506,0.035000,0.304800> rotate<0,-90.000000,0> translate<18.897600,-1.535000,45.592866> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.039428,-1.535000,52.445453>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,52.491916>}
box{<0,0,-0.304800><0.121414,0.035000,0.304800> rotate<0,-22.498248,0> translate<19.039428,-1.535000,52.445453> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,60.734931>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,52.491916>}
box{<0,0,-0.304800><8.243016,0.035000,0.304800> rotate<0,-90.000000,0> translate<19.151600,-1.535000,52.491916> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.151600,-1.535000,60.734931>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.368147,-1.535000,61.257722>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-67.495554,0> translate<19.151600,-1.535000,60.734931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.260275,-1.535000,29.401147>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.783066,-1.535000,29.184600>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<19.260275,-1.535000,29.401147> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.368147,-1.535000,61.257722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.768275,-1.535000,61.657850>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,-44.997030,0> translate<19.368147,-1.535000,61.257722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.633703,-1.535000,39.369600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.675622,-1.535000,39.268397>}
box{<0,0,-0.304800><0.109541,0.035000,0.304800> rotate<0,67.496008,0> translate<19.633703,-1.535000,39.369600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.633703,-1.535000,39.369600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.469822,-1.535000,39.369600>}
box{<0,0,-0.304800><16.836119,0.035000,0.304800> rotate<0,0.000000,0> translate<19.633703,-1.535000,39.369600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.675622,-1.535000,39.268397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.967931,-1.535000,39.268397>}
box{<0,0,-0.304800><0.292309,0.035000,0.304800> rotate<0,0.000000,0> translate<19.675622,-1.535000,39.268397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.768275,-1.535000,61.657850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.816275,-1.535000,64.705850>}
box{<0,0,-0.304800><4.310523,0.035000,0.304800> rotate<0,-44.997030,0> translate<19.768275,-1.535000,61.657850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.783066,-1.535000,29.184600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.129822,-1.535000,29.184600>}
box{<0,0,-0.304800><17.346756,0.035000,0.304800> rotate<0,0.000000,0> translate<19.783066,-1.535000,29.184600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<19.967931,-1.535000,39.268397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.490722,-1.535000,39.051850>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<19.967931,-1.535000,39.268397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.223369,-1.535000,32.461200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.655175,-1.535000,32.029397>}
box{<0,0,-0.304800><0.610664,0.035000,0.304800> rotate<0,44.996823,0> translate<20.223369,-1.535000,32.461200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.223369,-1.535000,32.461200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.673666,-1.535000,32.461200>}
box{<0,0,-0.304800><0.450297,0.035000,0.304800> rotate<0,0.000000,0> translate<20.223369,-1.535000,32.461200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.375772,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.099625,-1.535000,32.308800>}
box{<0,0,-0.304800><3.723853,0.035000,0.304800> rotate<0,0.000000,0> translate<20.375772,-1.535000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.490722,-1.535000,39.051850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.525850,-1.535000,38.016722>}
box{<0,0,-0.304800><1.463892,0.035000,0.304800> rotate<0,44.997030,0> translate<20.490722,-1.535000,39.051850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.528172,-1.535000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.879816,-1.535000,39.014400>}
box{<0,0,-0.304800><16.351644,0.035000,0.304800> rotate<0,0.000000,0> translate<20.528172,-1.535000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.655175,-1.535000,32.029397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.379028,-1.535000,32.029397>}
box{<0,0,-0.304800><3.723853,0.035000,0.304800> rotate<0,0.000000,0> translate<20.655175,-1.535000,32.029397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<20.673666,-1.535000,32.461200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.327153,-1.535000,32.731884>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,-22.498589,0> translate<20.673666,-1.535000,32.461200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.137772,-1.535000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.252688,-1.535000,38.404800>}
box{<0,0,-0.304800><16.114916,0.035000,0.304800> rotate<0,0.000000,0> translate<21.137772,-1.535000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.327153,-1.535000,32.731884>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.589997,-1.535000,32.994731>}
box{<0,0,-0.304800><0.371719,0.035000,0.304800> rotate<0,-44.997371,0> translate<21.327153,-1.535000,32.731884> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.513666,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.666328,-1.535000,32.918400>}
box{<0,0,-0.304800><0.152662,0.035000,0.304800> rotate<0,0.000000,0> translate<21.513666,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.525850,-1.535000,38.016722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.742397,-1.535000,37.493931>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,67.495554,0> translate<21.525850,-1.535000,38.016722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.589997,-1.535000,32.994731>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.852844,-1.535000,32.731884>}
box{<0,0,-0.304800><0.371722,0.035000,0.304800> rotate<0,44.997030,0> translate<21.589997,-1.535000,32.994731> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.617609,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.223900,-1.535000,37.795200>}
box{<0,0,-0.304800><15.606291,0.035000,0.304800> rotate<0,0.000000,0> translate<21.617609,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.742397,-1.535000,36.956862>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.742397,-1.535000,37.493931>}
box{<0,0,-0.304800><0.537069,0.035000,0.304800> rotate<0,90.000000,0> translate<21.742397,-1.535000,37.493931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.742397,-1.535000,36.956862>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.852844,-1.535000,37.067312>}
box{<0,0,-0.304800><0.156198,0.035000,0.304800> rotate<0,-44.997841,0> translate<21.742397,-1.535000,36.956862> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.742397,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.138416,-1.535000,37.185600>}
box{<0,0,-0.304800><0.396019,0.035000,0.304800> rotate<0,0.000000,0> translate<21.742397,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.742397,-1.535000,45.897663>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.742397,-1.535000,45.954872>}
box{<0,0,-0.304800><0.057209,0.035000,0.304800> rotate<0,90.000000,0> translate<21.742397,-1.535000,45.954872> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.742397,-1.535000,45.897663>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.840059,-1.535000,45.995325>}
box{<0,0,-0.304800><0.138116,0.035000,0.304800> rotate<0,-44.997030,0> translate<21.742397,-1.535000,45.897663> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.742397,-1.535000,45.954872>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.840059,-1.535000,45.995325>}
box{<0,0,-0.304800><0.105709,0.035000,0.304800> rotate<0,-22.498512,0> translate<21.742397,-1.535000,45.954872> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.852844,-1.535000,32.731884>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.506331,-1.535000,32.461200>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,22.498589,0> translate<21.852844,-1.535000,32.731884> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.852844,-1.535000,37.067312>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.506331,-1.535000,37.337997>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,-22.498589,0> translate<21.852844,-1.535000,37.067312> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,53.872563>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,59.862822>}
box{<0,0,-0.304800><5.990259,0.035000,0.304800> rotate<0,90.000000,0> translate<21.996397,-1.535000,59.862822> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,53.872563>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.162147,-1.535000,54.272722>}
box{<0,0,-0.304800><0.433129,0.035000,0.304800> rotate<0,-67.495721,0> translate<21.996397,-1.535000,53.872563> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.154559,-1.535000,54.254400>}
box{<0,0,-0.304800><0.158162,0.035000,0.304800> rotate<0,0.000000,0> translate<21.996397,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.753428,-1.535000,54.864000>}
box{<0,0,-0.304800><0.757031,0.035000,0.304800> rotate<0,0.000000,0> translate<21.996397,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.363028,-1.535000,55.473600>}
box{<0,0,-0.304800><1.366631,0.035000,0.304800> rotate<0,0.000000,0> translate<21.996397,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.972628,-1.535000,56.083200>}
box{<0,0,-0.304800><1.976231,0.035000,0.304800> rotate<0,0.000000,0> translate<21.996397,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.582228,-1.535000,56.692800>}
box{<0,0,-0.304800><2.585831,0.035000,0.304800> rotate<0,0.000000,0> translate<21.996397,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.191828,-1.535000,57.302400>}
box{<0,0,-0.304800><3.195431,0.035000,0.304800> rotate<0,0.000000,0> translate<21.996397,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.353953,-1.535000,57.912000>}
box{<0,0,-0.304800><3.357556,0.035000,0.304800> rotate<0,0.000000,0> translate<21.996397,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.298400,-1.535000,58.521600>}
box{<0,0,-0.304800><3.302003,0.035000,0.304800> rotate<0,0.000000,0> translate<21.996397,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.438128,-1.535000,59.131200>}
box{<0,0,-0.304800><3.441731,0.035000,0.304800> rotate<0,0.000000,0> translate<21.996397,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,59.740800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.739044,-1.535000,59.740800>}
box{<0,0,-0.304800><3.742647,0.035000,0.304800> rotate<0,0.000000,0> translate<21.996397,-1.535000,59.740800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<21.996397,-1.535000,59.862822>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.211175,-1.535000,62.077600>}
box{<0,0,-0.304800><3.132169,0.035000,0.304800> rotate<0,-44.997030,0> translate<21.996397,-1.535000,59.862822> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.121356,-1.535000,46.119334>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.301222,-1.535000,46.299200>}
box{<0,0,-0.304800><0.254368,0.035000,0.304800> rotate<0,-44.997030,0> translate<22.121356,-1.535000,46.119334> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.121356,-1.535000,46.119334>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.375725,-1.535000,46.224697>}
box{<0,0,-0.304800><0.275327,0.035000,0.304800> rotate<0,-22.498422,0> translate<22.121356,-1.535000,46.119334> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.162147,-1.535000,54.272722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.562275,-1.535000,54.672850>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,-44.997030,0> translate<22.162147,-1.535000,54.272722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.301222,-1.535000,46.299200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.375725,-1.535000,46.224697>}
box{<0,0,-0.304800><0.105363,0.035000,0.304800> rotate<0,44.997030,0> translate<22.301222,-1.535000,46.299200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.483975,-1.535000,60.350400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.396038,-1.535000,60.350400>}
box{<0,0,-0.304800><2.912063,0.035000,0.304800> rotate<0,0.000000,0> translate<22.483975,-1.535000,60.350400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.506331,-1.535000,32.461200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.213666,-1.535000,32.461200>}
box{<0,0,-0.304800><0.707334,0.035000,0.304800> rotate<0,0.000000,0> translate<22.506331,-1.535000,32.461200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.506331,-1.535000,37.337997>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.213666,-1.535000,37.337997>}
box{<0,0,-0.304800><0.707334,0.035000,0.304800> rotate<0,0.000000,0> translate<22.506331,-1.535000,37.337997> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.562275,-1.535000,54.672850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.485019,-1.535000,57.595591>}
box{<0,0,-0.304800><4.133382,0.035000,0.304800> rotate<0,-44.997000,0> translate<22.562275,-1.535000,54.672850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.816275,-1.535000,64.705850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.339066,-1.535000,64.922397>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-22.498506,0> translate<22.816275,-1.535000,64.705850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.093575,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.298400,-1.535000,60.960000>}
box{<0,0,-0.304800><2.204825,0.035000,0.304800> rotate<0,0.000000,0> translate<23.093575,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.213666,-1.535000,32.461200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.732369,-1.535000,32.676056>}
box{<0,0,-0.304800><0.561441,0.035000,0.304800> rotate<0,-22.498740,0> translate<23.213666,-1.535000,32.461200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.213666,-1.535000,37.337997>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.867153,-1.535000,37.067312>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,22.498589,0> translate<23.213666,-1.535000,37.337997> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.339066,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.942247,-1.535000,64.922397>}
box{<0,0,-0.304800><2.603181,0.035000,0.304800> rotate<0,0.000000,0> translate<23.339066,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.581584,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.223900,-1.535000,37.185600>}
box{<0,0,-0.304800><13.642316,0.035000,0.304800> rotate<0,0.000000,0> translate<23.581584,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.703175,-1.535000,61.569600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.396044,-1.535000,61.569600>}
box{<0,0,-0.304800><1.692869,0.035000,0.304800> rotate<0,0.000000,0> translate<23.703175,-1.535000,61.569600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.732369,-1.535000,32.676056>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.379028,-1.535000,32.029397>}
box{<0,0,-0.304800><0.914514,0.035000,0.304800> rotate<0,44.997030,0> translate<23.732369,-1.535000,32.676056> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<23.867153,-1.535000,37.067312>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.367313,-1.535000,36.567153>}
box{<0,0,-0.304800><0.707332,0.035000,0.304800> rotate<0,44.997030,0> translate<23.867153,-1.535000,37.067312> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.211175,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.637450,-1.535000,62.077600>}
box{<0,0,-0.304800><1.426275,0.035000,0.304800> rotate<0,0.000000,0> translate<24.211175,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.358466,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.223900,-1.535000,36.576000>}
box{<0,0,-0.304800><12.865434,0.035000,0.304800> rotate<0,0.000000,0> translate<24.358466,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.367313,-1.535000,36.567153>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.637997,-1.535000,35.913666>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,67.495471,0> translate<24.367313,-1.535000,36.567153> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.616156,-1.535000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.358225,-1.535000,35.966400>}
box{<0,0,-0.304800><12.742069,0.035000,0.304800> rotate<0,0.000000,0> translate<24.616156,-1.535000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.637997,-1.535000,35.793575>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.637997,-1.535000,35.913666>}
box{<0,0,-0.304800><0.120091,0.035000,0.304800> rotate<0,90.000000,0> translate<24.637997,-1.535000,35.913666> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.637997,-1.535000,35.793575>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.370175,-1.535000,34.061397>}
box{<0,0,-0.304800><2.449670,0.035000,0.304800> rotate<0,44.997030,0> translate<24.637997,-1.535000,35.793575> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.790397,-1.535000,51.566969>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.790397,-1.535000,52.877822>}
box{<0,0,-0.304800><1.310853,0.035000,0.304800> rotate<0,90.000000,0> translate<24.790397,-1.535000,52.877822> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.790397,-1.535000,51.566969>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.229275,-1.535000,52.005850>}
box{<0,0,-0.304800><0.620670,0.035000,0.304800> rotate<0,-44.997234,0> translate<24.790397,-1.535000,51.566969> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.790397,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.039428,-1.535000,51.816000>}
box{<0,0,-0.304800><0.249031,0.035000,0.304800> rotate<0,0.000000,0> translate<24.790397,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.790397,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.190925,-1.535000,52.425600>}
box{<0,0,-0.304800><1.400528,0.035000,0.304800> rotate<0,0.000000,0> translate<24.790397,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.790397,-1.535000,52.877822>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.452975,-1.535000,56.540400>}
box{<0,0,-0.304800><5.179668,0.035000,0.304800> rotate<0,-44.997030,0> translate<24.790397,-1.535000,52.877822> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.947775,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.782206,-1.535000,53.035200>}
box{<0,0,-0.304800><3.834431,0.035000,0.304800> rotate<0,0.000000,0> translate<24.947775,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.074772,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.132000,-1.535000,35.356800>}
box{<0,0,-0.304800><15.057228,0.035000,0.304800> rotate<0,0.000000,0> translate<25.074772,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.229275,-1.535000,52.005850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.752066,-1.535000,52.222397>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-22.498506,0> translate<25.229275,-1.535000,52.005850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.298400,-1.535000,58.046122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.485019,-1.535000,57.595591>}
box{<0,0,-0.304800><0.487653,0.035000,0.304800> rotate<0,67.495263,0> translate<25.298400,-1.535000,58.046122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.298400,-1.535000,58.793875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.298400,-1.535000,58.046122>}
box{<0,0,-0.304800><0.747753,0.035000,0.304800> rotate<0,-90.000000,0> translate<25.298400,-1.535000,58.046122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.298400,-1.535000,58.793875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.584553,-1.535000,59.484706>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<25.298400,-1.535000,58.793875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.298400,-1.535000,60.586122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.584553,-1.535000,59.895291>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<25.298400,-1.535000,60.586122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.298400,-1.535000,61.333875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.298400,-1.535000,60.586122>}
box{<0,0,-0.304800><0.747753,0.035000,0.304800> rotate<0,-90.000000,0> translate<25.298400,-1.535000,60.586122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.298400,-1.535000,61.333875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.584553,-1.535000,62.024706>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<25.298400,-1.535000,61.333875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.557375,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.600400,-1.535000,53.644800>}
box{<0,0,-0.304800><3.043025,0.035000,0.304800> rotate<0,0.000000,0> translate<25.557375,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.584553,-1.535000,59.484706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.789847,-1.535000,59.689997>}
box{<0,0,-0.304800><0.290327,0.035000,0.304800> rotate<0,-44.996594,0> translate<25.584553,-1.535000,59.484706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.584553,-1.535000,59.895291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.789847,-1.535000,59.689997>}
box{<0,0,-0.304800><0.290329,0.035000,0.304800> rotate<0,44.997030,0> translate<25.584553,-1.535000,59.895291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.584553,-1.535000,62.024706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.637450,-1.535000,62.077600>}
box{<0,0,-0.304800><0.074805,0.035000,0.304800> rotate<0,-44.995338,0> translate<25.584553,-1.535000,62.024706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.684372,-1.535000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.132000,-1.535000,34.747200>}
box{<0,0,-0.304800><14.447628,0.035000,0.304800> rotate<0,0.000000,0> translate<25.684372,-1.535000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.752066,-1.535000,52.222397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.942244,-1.535000,52.222397>}
box{<0,0,-0.304800><0.190178,0.035000,0.304800> rotate<0,0.000000,0> translate<25.752066,-1.535000,52.222397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.942244,-1.535000,52.222397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.113291,-1.535000,52.393444>}
box{<0,0,-0.304800><0.241897,0.035000,0.304800> rotate<0,-44.997030,0> translate<25.942244,-1.535000,52.222397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.942247,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.113291,-1.535000,65.093444>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,-44.997554,0> translate<25.942247,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.113291,-1.535000,52.393444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.804122,-1.535000,52.679597>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-22.498618,0> translate<26.113291,-1.535000,52.393444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.113291,-1.535000,65.093444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.804122,-1.535000,65.379597>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-22.498618,0> translate<26.113291,-1.535000,65.093444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.166975,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.600400,-1.535000,54.254400>}
box{<0,0,-0.304800><2.433425,0.035000,0.304800> rotate<0,0.000000,0> translate<26.166975,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.293972,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.132000,-1.535000,34.137600>}
box{<0,0,-0.304800><13.838028,0.035000,0.304800> rotate<0,0.000000,0> translate<26.293972,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.370175,-1.535000,34.061397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.132000,-1.535000,34.061397>}
box{<0,0,-0.304800><13.761825,0.035000,0.304800> rotate<0,0.000000,0> translate<26.370175,-1.535000,34.061397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.776575,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.600400,-1.535000,54.864000>}
box{<0,0,-0.304800><1.823825,0.035000,0.304800> rotate<0,0.000000,0> translate<26.776575,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.804122,-1.535000,52.679597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.990250,-1.535000,52.679597>}
box{<0,0,-0.304800><2.186128,0.035000,0.304800> rotate<0,0.000000,0> translate<26.804122,-1.535000,52.679597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<26.804122,-1.535000,65.379597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.075875,-1.535000,65.379597>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,0.000000,0> translate<26.804122,-1.535000,65.379597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.386175,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.600400,-1.535000,55.473600>}
box{<0,0,-0.304800><1.214225,0.035000,0.304800> rotate<0,0.000000,0> translate<27.386175,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.995775,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.740128,-1.535000,56.083200>}
box{<0,0,-0.304800><0.744353,0.035000,0.304800> rotate<0,0.000000,0> translate<27.995775,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.452975,-1.535000,56.540400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.930600,-1.535000,56.540400>}
box{<0,0,-0.304800><0.477625,0.035000,0.304800> rotate<0,0.000000,0> translate<28.452975,-1.535000,56.540400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.600400,-1.535000,53.474122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.886553,-1.535000,52.783291>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<28.600400,-1.535000,53.474122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.600400,-1.535000,55.745875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.600400,-1.535000,53.474122>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,-90.000000,0> translate<28.600400,-1.535000,53.474122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.600400,-1.535000,55.745875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.886553,-1.535000,56.436706>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<28.600400,-1.535000,55.745875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.886553,-1.535000,52.783291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.990250,-1.535000,52.679597>}
box{<0,0,-0.304800><0.146647,0.035000,0.304800> rotate<0,44.996167,0> translate<28.886553,-1.535000,52.783291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.886553,-1.535000,56.436706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.930600,-1.535000,56.480753>}
box{<0,0,-0.304800><0.062292,0.035000,0.304800> rotate<0,-44.997030,0> translate<28.886553,-1.535000,56.436706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.930600,-1.535000,56.540400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.930600,-1.535000,56.480753>}
box{<0,0,-0.304800><0.059647,0.035000,0.304800> rotate<0,-90.000000,0> translate<28.930600,-1.535000,56.480753> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.075875,-1.535000,65.379597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.766706,-1.535000,65.093444>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,22.498618,0> translate<29.075875,-1.535000,65.379597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.443794,-1.535000,65.227200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.596206,-1.535000,65.227200>}
box{<0,0,-0.304800><7.152413,0.035000,0.304800> rotate<0,0.000000,0> translate<29.443794,-1.535000,65.227200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.766706,-1.535000,65.093444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.937750,-1.535000,64.922397>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,44.997554,0> translate<29.766706,-1.535000,65.093444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.937750,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.102247,-1.535000,64.922397>}
box{<0,0,-0.304800><6.164497,0.035000,0.304800> rotate<0,0.000000,0> translate<29.937750,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.255969,-1.535000,42.214397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.415850,-1.535000,42.374275>}
box{<0,0,-0.304800><0.226104,0.035000,0.304800> rotate<0,-44.996470,0> translate<30.255969,-1.535000,42.214397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.255969,-1.535000,42.214397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.403028,-1.535000,42.214397>}
box{<0,0,-0.304800><5.147059,0.035000,0.304800> rotate<0,0.000000,0> translate<30.255969,-1.535000,42.214397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.415850,-1.535000,42.374275>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.304850,-1.535000,43.263275>}
box{<0,0,-0.304800><1.257236,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.415850,-1.535000,42.374275> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.713575,-1.535000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.945422,-1.535000,42.672000>}
box{<0,0,-0.304800><4.231847,0.035000,0.304800> rotate<0,0.000000,0> translate<30.713575,-1.535000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.865969,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.158722,-1.535000,61.784850>}
box{<0,0,-0.304800><0.414013,0.035000,0.304800> rotate<0,44.996724,0> translate<30.865969,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.865969,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.888028,-1.535000,62.077600>}
box{<0,0,-0.304800><2.022059,0.035000,0.304800> rotate<0,0.000000,0> translate<30.865969,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.158722,-1.535000,61.784850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.558850,-1.535000,61.384722>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,44.997030,0> translate<31.158722,-1.535000,61.784850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.304850,-1.535000,43.263275>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.521397,-1.535000,43.786066>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-67.495554,0> translate<31.304850,-1.535000,43.263275> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.312438,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.420950,-1.535000,43.281600>}
box{<0,0,-0.304800><3.108513,0.035000,0.304800> rotate<0,0.000000,0> translate<31.312438,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.373972,-1.535000,61.569600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.380028,-1.535000,61.569600>}
box{<0,0,-0.304800><1.006056,0.035000,0.304800> rotate<0,0.000000,0> translate<31.373972,-1.535000,61.569600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.521397,-1.535000,43.786066>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.521397,-1.535000,45.567600>}
box{<0,0,-0.304800><1.781534,0.035000,0.304800> rotate<0,90.000000,0> translate<31.521397,-1.535000,45.567600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.521397,-1.535000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.264600,-1.535000,43.891200>}
box{<0,0,-0.304800><2.743203,0.035000,0.304800> rotate<0,0.000000,0> translate<31.521397,-1.535000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.521397,-1.535000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.264600,-1.535000,44.500800>}
box{<0,0,-0.304800><2.743203,0.035000,0.304800> rotate<0,0.000000,0> translate<31.521397,-1.535000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.521397,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.264600,-1.535000,45.110400>}
box{<0,0,-0.304800><2.743203,0.035000,0.304800> rotate<0,0.000000,0> translate<31.521397,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.521397,-1.535000,45.567600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.264600,-1.535000,45.567600>}
box{<0,0,-0.304800><2.743203,0.035000,0.304800> rotate<0,0.000000,0> translate<31.521397,-1.535000,45.567600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.558850,-1.535000,61.384722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.765406,-1.535000,60.886047>}
box{<0,0,-0.304800><0.539761,0.035000,0.304800> rotate<0,67.495712,0> translate<31.558850,-1.535000,61.384722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.734775,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.796038,-1.535000,60.960000>}
box{<0,0,-0.304800><0.061262,0.035000,0.304800> rotate<0,0.000000,0> translate<31.734775,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.765406,-1.535000,60.886047>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.814147,-1.535000,61.003722>}
box{<0,0,-0.304800><0.127370,0.035000,0.304800> rotate<0,-67.496358,0> translate<31.765406,-1.535000,60.886047> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.814147,-1.535000,61.003722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.214275,-1.535000,61.403850>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,-44.997030,0> translate<31.814147,-1.535000,61.003722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.214275,-1.535000,61.403850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.888028,-1.535000,62.077600>}
box{<0,0,-0.304800><0.952829,0.035000,0.304800> rotate<0,-44.996897,0> translate<32.214275,-1.535000,61.403850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.264600,-1.535000,43.659066>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.481147,-1.535000,43.136275>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,67.495554,0> translate<34.264600,-1.535000,43.659066> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.264600,-1.535000,45.567600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.264600,-1.535000,43.659066>}
box{<0,0,-0.304800><1.908534,0.035000,0.304800> rotate<0,-90.000000,0> translate<34.264600,-1.535000,43.659066> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.442397,-1.535000,56.607753>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.442397,-1.535000,59.537600>}
box{<0,0,-0.304800><2.929847,0.035000,0.304800> rotate<0,90.000000,0> translate<34.442397,-1.535000,59.537600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.442397,-1.535000,56.607753>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.613444,-1.535000,56.436706>}
box{<0,0,-0.304800><0.241897,0.035000,0.304800> rotate<0,44.997030,0> translate<34.442397,-1.535000,56.607753> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.442397,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.596197,-1.535000,56.692800>}
box{<0,0,-0.304800><2.153800,0.035000,0.304800> rotate<0,0.000000,0> translate<34.442397,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.442397,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.797444,-1.535000,57.302400>}
box{<0,0,-0.304800><1.355047,0.035000,0.304800> rotate<0,0.000000,0> translate<34.442397,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.442397,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.513953,-1.535000,57.912000>}
box{<0,0,-0.304800><1.071556,0.035000,0.304800> rotate<0,0.000000,0> translate<34.442397,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.442397,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.458400,-1.535000,58.521600>}
box{<0,0,-0.304800><1.016003,0.035000,0.304800> rotate<0,0.000000,0> translate<34.442397,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.442397,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.598128,-1.535000,59.131200>}
box{<0,0,-0.304800><1.155731,0.035000,0.304800> rotate<0,0.000000,0> translate<34.442397,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.442397,-1.535000,59.537600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.797450,-1.535000,59.537600>}
box{<0,0,-0.304800><1.355053,0.035000,0.304800> rotate<0,0.000000,0> translate<34.442397,-1.535000,59.537600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.481147,-1.535000,43.136275>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.403028,-1.535000,42.214397>}
box{<0,0,-0.304800><1.303735,0.035000,0.304800> rotate<0,44.996933,0> translate<34.481147,-1.535000,43.136275> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.613444,-1.535000,56.436706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.899597,-1.535000,55.745875>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<34.613444,-1.535000,56.436706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.696397,-1.535000,49.992175>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.696397,-1.535000,52.983556>}
box{<0,0,-0.304800><2.991381,0.035000,0.304800> rotate<0,90.000000,0> translate<34.696397,-1.535000,52.983556> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.696397,-1.535000,49.992175>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.006175,-1.535000,49.682397>}
box{<0,0,-0.304800><0.438092,0.035000,0.304800> rotate<0,44.997030,0> translate<34.696397,-1.535000,49.992175> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.696397,-1.535000,50.596800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.458400,-1.535000,50.596800>}
box{<0,0,-0.304800><0.762003,0.035000,0.304800> rotate<0,0.000000,0> translate<34.696397,-1.535000,50.596800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.696397,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.471875,-1.535000,51.206400>}
box{<0,0,-0.304800><0.775478,0.035000,0.304800> rotate<0,0.000000,0> translate<34.696397,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.696397,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.724381,-1.535000,51.816000>}
box{<0,0,-0.304800><1.027984,0.035000,0.304800> rotate<0,0.000000,0> translate<34.696397,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.696397,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.350925,-1.535000,52.425600>}
box{<0,0,-0.304800><1.654528,0.035000,0.304800> rotate<0,0.000000,0> translate<34.696397,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.696397,-1.535000,52.983556>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.899597,-1.535000,53.474122>}
box{<0,0,-0.304800><0.530985,0.035000,0.304800> rotate<0,-67.495439,0> translate<34.696397,-1.535000,52.983556> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.701372,-1.535000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.640206,-1.535000,49.987200>}
box{<0,0,-0.304800><0.938834,0.035000,0.304800> rotate<0,0.000000,0> translate<34.701372,-1.535000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.717788,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.360600,-1.535000,53.035200>}
box{<0,0,-0.304800><5.642813,0.035000,0.304800> rotate<0,0.000000,0> translate<34.717788,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.759872,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.568222,-1.535000,56.083200>}
box{<0,0,-0.304800><4.808350,0.035000,0.304800> rotate<0,0.000000,0> translate<34.759872,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.899597,-1.535000,53.474122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.899597,-1.535000,55.745875>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,90.000000,0> translate<34.899597,-1.535000,55.745875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.899597,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.360600,-1.535000,53.644800>}
box{<0,0,-0.304800><5.461003,0.035000,0.304800> rotate<0,0.000000,0> translate<34.899597,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.899597,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.360600,-1.535000,54.254400>}
box{<0,0,-0.304800><5.461003,0.035000,0.304800> rotate<0,0.000000,0> translate<34.899597,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.899597,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.360600,-1.535000,54.864000>}
box{<0,0,-0.304800><5.461003,0.035000,0.304800> rotate<0,0.000000,0> translate<34.899597,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<34.899597,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.177822,-1.535000,55.473600>}
box{<0,0,-0.304800><5.278225,0.035000,0.304800> rotate<0,0.000000,0> translate<34.899597,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.006175,-1.535000,49.682397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.797450,-1.535000,49.682397>}
box{<0,0,-0.304800><0.791275,0.035000,0.304800> rotate<0,0.000000,0> translate<35.006175,-1.535000,49.682397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.458400,-1.535000,50.426122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.744553,-1.535000,49.735291>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<35.458400,-1.535000,50.426122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.458400,-1.535000,51.173875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.458400,-1.535000,50.426122>}
box{<0,0,-0.304800><0.747753,0.035000,0.304800> rotate<0,-90.000000,0> translate<35.458400,-1.535000,50.426122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.458400,-1.535000,51.173875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.744553,-1.535000,51.864706>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<35.458400,-1.535000,51.173875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.458400,-1.535000,58.046122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.744553,-1.535000,57.355291>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<35.458400,-1.535000,58.046122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.458400,-1.535000,58.793875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.458400,-1.535000,58.046122>}
box{<0,0,-0.304800><0.747753,0.035000,0.304800> rotate<0,-90.000000,0> translate<35.458400,-1.535000,58.046122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.458400,-1.535000,58.793875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.744553,-1.535000,59.484706>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<35.458400,-1.535000,58.793875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.744553,-1.535000,49.735291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.797450,-1.535000,49.682397>}
box{<0,0,-0.304800><0.074805,0.035000,0.304800> rotate<0,44.995338,0> translate<35.744553,-1.535000,49.735291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.744553,-1.535000,51.864706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.273291,-1.535000,52.393444>}
box{<0,0,-0.304800><0.747748,0.035000,0.304800> rotate<0,-44.997030,0> translate<35.744553,-1.535000,51.864706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.744553,-1.535000,57.355291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.273291,-1.535000,56.826553>}
box{<0,0,-0.304800><0.747748,0.035000,0.304800> rotate<0,44.997030,0> translate<35.744553,-1.535000,57.355291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.744553,-1.535000,59.484706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.797450,-1.535000,59.537600>}
box{<0,0,-0.304800><0.074805,0.035000,0.304800> rotate<0,-44.995338,0> translate<35.744553,-1.535000,59.484706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.102247,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.273291,-1.535000,65.093444>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,-44.997554,0> translate<36.102247,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.273291,-1.535000,52.393444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.964122,-1.535000,52.679597>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-22.498618,0> translate<36.273291,-1.535000,52.393444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.273291,-1.535000,56.826553>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.964122,-1.535000,56.540400>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,22.498618,0> translate<36.273291,-1.535000,56.826553> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.273291,-1.535000,65.093444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.964122,-1.535000,65.379597>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-22.498618,0> translate<36.273291,-1.535000,65.093444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.469822,-1.535000,39.369600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.786275,-1.535000,39.053147>}
box{<0,0,-0.304800><0.447532,0.035000,0.304800> rotate<0,44.997030,0> translate<36.469822,-1.535000,39.369600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.786275,-1.535000,39.053147>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.309066,-1.535000,38.836600>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<36.786275,-1.535000,39.053147> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.964122,-1.535000,52.679597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.235875,-1.535000,52.679597>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,0.000000,0> translate<36.964122,-1.535000,52.679597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.964122,-1.535000,56.540400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.111022,-1.535000,56.540400>}
box{<0,0,-0.304800><2.146900,0.035000,0.304800> rotate<0,0.000000,0> translate<36.964122,-1.535000,56.540400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.964122,-1.535000,65.379597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.235875,-1.535000,65.379597>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,0.000000,0> translate<36.964122,-1.535000,65.379597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.129822,-1.535000,29.184600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.617400,-1.535000,28.697022>}
box{<0,0,-0.304800><0.689540,0.035000,0.304800> rotate<0,44.997030,0> translate<37.129822,-1.535000,29.184600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.223900,-1.535000,36.290694>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.394044,-1.535000,35.879928>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,67.495658,0> translate<37.223900,-1.535000,36.290694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.223900,-1.535000,38.335303>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.223900,-1.535000,36.290694>}
box{<0,0,-0.304800><2.044609,0.035000,0.304800> rotate<0,-90.000000,0> translate<37.223900,-1.535000,36.290694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.223900,-1.535000,38.335303>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.389459,-1.535000,38.735000>}
box{<0,0,-0.304800><0.432629,0.035000,0.304800> rotate<0,-67.495605,0> translate<37.223900,-1.535000,38.335303> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.309066,-1.535000,38.836600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.347375,-1.535000,38.836600>}
box{<0,0,-0.304800><0.038309,0.035000,0.304800> rotate<0,0.000000,0> translate<37.309066,-1.535000,38.836600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.347375,-1.535000,38.836600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.389459,-1.535000,38.735000>}
box{<0,0,-0.304800><0.109971,0.035000,0.304800> rotate<0,67.495412,0> translate<37.347375,-1.535000,38.836600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.394044,-1.535000,35.879928>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.708428,-1.535000,35.565544>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,44.997030,0> translate<37.394044,-1.535000,35.879928> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.617400,-1.535000,27.693122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.903553,-1.535000,27.002291>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<37.617400,-1.535000,27.693122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.617400,-1.535000,28.697022>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.617400,-1.535000,27.693122>}
box{<0,0,-0.304800><1.003900,0.035000,0.304800> rotate<0,-90.000000,0> translate<37.617400,-1.535000,27.693122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.708428,-1.535000,35.565544>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.119194,-1.535000,35.395400>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,22.498403,0> translate<37.708428,-1.535000,35.565544> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.903553,-1.535000,27.002291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.432291,-1.535000,26.473553>}
box{<0,0,-0.304800><0.747748,0.035000,0.304800> rotate<0,44.997030,0> translate<37.903553,-1.535000,27.002291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.119194,-1.535000,35.395400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.132000,-1.535000,35.395400>}
box{<0,0,-0.304800><2.012806,0.035000,0.304800> rotate<0,0.000000,0> translate<38.119194,-1.535000,35.395400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.432291,-1.535000,26.473553>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.123122,-1.535000,26.187400>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,22.498618,0> translate<38.432291,-1.535000,26.473553> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.111022,-1.535000,56.540400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.360600,-1.535000,55.290822>}
box{<0,0,-0.304800><1.767170,0.035000,0.304800> rotate<0,44.997030,0> translate<39.111022,-1.535000,56.540400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.123122,-1.535000,26.187400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.870875,-1.535000,26.187400>}
box{<0,0,-0.304800><0.747753,0.035000,0.304800> rotate<0,0.000000,0> translate<39.123122,-1.535000,26.187400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.235875,-1.535000,52.679597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.926706,-1.535000,52.393444>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,22.498618,0> translate<39.235875,-1.535000,52.679597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.235875,-1.535000,65.379597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.926706,-1.535000,65.093444>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,22.498618,0> translate<39.235875,-1.535000,65.379597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.603794,-1.535000,65.227200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.186206,-1.535000,65.227200>}
box{<0,0,-0.304800><18.582413,0.035000,0.304800> rotate<0,0.000000,0> translate<39.603794,-1.535000,65.227200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.849075,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.360600,-1.535000,52.425600>}
box{<0,0,-0.304800><0.511525,0.035000,0.304800> rotate<0,0.000000,0> translate<39.849075,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.870875,-1.535000,26.187400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.561706,-1.535000,26.473553>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-22.498618,0> translate<39.870875,-1.535000,26.187400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.926706,-1.535000,52.393444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.097750,-1.535000,52.222397>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,44.997554,0> translate<39.926706,-1.535000,52.393444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.926706,-1.535000,65.093444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.097750,-1.535000,64.922397>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,44.997554,0> translate<39.926706,-1.535000,65.093444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<39.932194,-1.535000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.371622,-1.535000,26.212800>}
box{<0,0,-0.304800><1.439428,0.035000,0.304800> rotate<0,0.000000,0> translate<39.932194,-1.535000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.097750,-1.535000,52.222397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.160931,-1.535000,52.222397>}
box{<0,0,-0.304800><0.063181,0.035000,0.304800> rotate<0,0.000000,0> translate<40.097750,-1.535000,52.222397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.097750,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.462931,-1.535000,64.922397>}
box{<0,0,-0.304800><3.365181,0.035000,0.304800> rotate<0,0.000000,0> translate<40.097750,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.132000,-1.535000,35.395400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.132000,-1.535000,34.061397>}
box{<0,0,-0.304800><1.334003,0.035000,0.304800> rotate<0,-90.000000,0> translate<40.132000,-1.535000,34.061397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.160931,-1.535000,52.222397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.360600,-1.535000,52.139691>}
box{<0,0,-0.304800><0.216120,0.035000,0.304800> rotate<0,22.498698,0> translate<40.160931,-1.535000,52.222397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.250150,-1.535000,59.689997>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.455444,-1.535000,59.484706>}
box{<0,0,-0.304800><0.290327,0.035000,0.304800> rotate<0,44.996594,0> translate<40.250150,-1.535000,59.689997> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.250150,-1.535000,59.689997>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.455444,-1.535000,59.895291>}
box{<0,0,-0.304800><0.290329,0.035000,0.304800> rotate<0,-44.997030,0> translate<40.250150,-1.535000,59.689997> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.300953,-1.535000,59.740800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,59.740800>}
box{<0,0,-0.304800><2.472647,0.035000,0.304800> rotate<0,0.000000,0> translate<40.300953,-1.535000,59.740800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.360600,-1.535000,55.290822>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.360600,-1.535000,52.139691>}
box{<0,0,-0.304800><3.151131,0.035000,0.304800> rotate<0,-90.000000,0> translate<40.360600,-1.535000,52.139691> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.402547,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.455444,-1.535000,62.024706>}
box{<0,0,-0.304800><0.074805,0.035000,0.304800> rotate<0,44.995338,0> translate<40.402547,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.402547,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.590822,-1.535000,62.077600>}
box{<0,0,-0.304800><2.188275,0.035000,0.304800> rotate<0,0.000000,0> translate<40.402547,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.455444,-1.535000,59.484706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.643238,-1.535000,59.031331>}
box{<0,0,-0.304800><0.490729,0.035000,0.304800> rotate<0,67.495580,0> translate<40.455444,-1.535000,59.484706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.455444,-1.535000,59.895291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.741597,-1.535000,60.586122>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<40.455444,-1.535000,59.895291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.455444,-1.535000,62.024706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.741597,-1.535000,61.333875>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<40.455444,-1.535000,62.024706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.484072,-1.535000,31.216600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.561706,-1.535000,31.184444>}
box{<0,0,-0.304800><0.084030,0.035000,0.304800> rotate<0,22.497910,0> translate<40.484072,-1.535000,31.216600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.484072,-1.535000,31.216600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.049925,-1.535000,31.216600>}
box{<0,0,-0.304800><0.565853,0.035000,0.304800> rotate<0,0.000000,0> translate<40.484072,-1.535000,31.216600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.561706,-1.535000,26.473553>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.767000,-1.535000,26.678847>}
box{<0,0,-0.304800><0.290329,0.035000,0.304800> rotate<0,-44.997030,0> translate<40.561706,-1.535000,26.473553> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.561706,-1.535000,31.184444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.767000,-1.535000,30.979150>}
box{<0,0,-0.304800><0.290329,0.035000,0.304800> rotate<0,44.997030,0> translate<40.561706,-1.535000,31.184444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.601872,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,59.131200>}
box{<0,0,-0.304800><2.171728,0.035000,0.304800> rotate<0,0.000000,0> translate<40.601872,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.643238,-1.535000,59.031331>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.588722,-1.535000,57.085850>}
box{<0,0,-0.304800><2.751328,0.035000,0.304800> rotate<0,44.996984,0> translate<40.643238,-1.535000,59.031331> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.643956,-1.535000,60.350400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,60.350400>}
box{<0,0,-0.304800><2.129644,0.035000,0.304800> rotate<0,0.000000,0> translate<40.643956,-1.535000,60.350400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.643956,-1.535000,61.569600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,61.569600>}
box{<0,0,-0.304800><2.129644,0.035000,0.304800> rotate<0,0.000000,0> translate<40.643956,-1.535000,61.569600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.656550,-1.535000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.877450,-1.535000,31.089600>}
box{<0,0,-0.304800><0.220900,0.035000,0.304800> rotate<0,0.000000,0> translate<40.656550,-1.535000,31.089600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.741597,-1.535000,60.586122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.741597,-1.535000,61.333875>}
box{<0,0,-0.304800><0.747753,0.035000,0.304800> rotate<0,90.000000,0> translate<40.741597,-1.535000,61.333875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.741597,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,60.960000>}
box{<0,0,-0.304800><2.032003,0.035000,0.304800> rotate<0,0.000000,0> translate<40.741597,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.767000,-1.535000,26.678847>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.972291,-1.535000,26.473553>}
box{<0,0,-0.304800><0.290327,0.035000,0.304800> rotate<0,44.997466,0> translate<40.767000,-1.535000,26.678847> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.767000,-1.535000,30.979150>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.972291,-1.535000,31.184444>}
box{<0,0,-0.304800><0.290327,0.035000,0.304800> rotate<0,-44.997466,0> translate<40.767000,-1.535000,30.979150> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.972291,-1.535000,26.473553>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.208863,-1.535000,26.375563>}
box{<0,0,-0.304800><0.256063,0.035000,0.304800> rotate<0,22.498380,0> translate<40.972291,-1.535000,26.473553> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<40.972291,-1.535000,31.184444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.049925,-1.535000,31.216600>}
box{<0,0,-0.304800><0.084030,0.035000,0.304800> rotate<0,-22.497910,0> translate<40.972291,-1.535000,31.184444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.107056,-1.535000,38.709600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.138622,-1.535000,38.633397>}
box{<0,0,-0.304800><0.082482,0.035000,0.304800> rotate<0,67.494739,0> translate<41.107056,-1.535000,38.709600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.107056,-1.535000,38.709600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.399900,-1.535000,38.709600>}
box{<0,0,-0.304800><7.292844,0.035000,0.304800> rotate<0,0.000000,0> translate<41.107056,-1.535000,38.709600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.138622,-1.535000,38.633397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.938931,-1.535000,38.633397>}
box{<0,0,-0.304800><0.800309,0.035000,0.304800> rotate<0,0.000000,0> translate<41.138622,-1.535000,38.633397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.152972,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,58.521600>}
box{<0,0,-0.304800><1.620628,0.035000,0.304800> rotate<0,0.000000,0> translate<41.152972,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.208863,-1.535000,26.375563>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.244147,-1.535000,24.340275>}
box{<0,0,-0.304800><2.878329,0.035000,0.304800> rotate<0,44.997074,0> translate<41.208863,-1.535000,26.375563> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.762572,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,57.912000>}
box{<0,0,-0.304800><1.011028,0.035000,0.304800> rotate<0,0.000000,0> translate<41.762572,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.808397,-1.535000,47.142397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.808397,-1.535000,47.399931>}
box{<0,0,-0.304800><0.257534,0.035000,0.304800> rotate<0,90.000000,0> translate<41.808397,-1.535000,47.399931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.808397,-1.535000,47.142397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.430900,-1.535000,47.142397>}
box{<0,0,-0.304800><0.622503,0.035000,0.304800> rotate<0,0.000000,0> translate<41.808397,-1.535000,47.142397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.808397,-1.535000,47.399931>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.808397,-1.535000,48.738028>}
box{<0,0,-0.304800><1.338097,0.035000,0.304800> rotate<0,90.000000,0> translate<41.808397,-1.535000,48.738028> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.808397,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.430900,-1.535000,47.548800>}
box{<0,0,-0.304800><0.622503,0.035000,0.304800> rotate<0,0.000000,0> translate<41.808397,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.808397,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.388025,-1.535000,48.158400>}
box{<0,0,-0.304800><0.579628,0.035000,0.304800> rotate<0,0.000000,0> translate<41.808397,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.808397,-1.535000,48.738028>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.430900,-1.535000,48.115525>}
box{<0,0,-0.304800><0.880352,0.035000,0.304800> rotate<0,44.997030,0> translate<41.808397,-1.535000,48.738028> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.938931,-1.535000,38.633397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.461722,-1.535000,38.416850>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<41.938931,-1.535000,38.633397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.372172,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,57.302400>}
box{<0,0,-0.304800><0.401428,0.035000,0.304800> rotate<0,0.000000,0> translate<42.372172,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.430900,-1.535000,48.115525>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.430900,-1.535000,47.142397>}
box{<0,0,-0.304800><0.973128,0.035000,0.304800> rotate<0,-90.000000,0> translate<42.430900,-1.535000,47.142397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.461722,-1.535000,38.416850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.861850,-1.535000,38.016722>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,44.997030,0> translate<42.461722,-1.535000,38.416850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.473772,-1.535000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.399900,-1.535000,38.404800>}
box{<0,0,-0.304800><5.926128,0.035000,0.304800> rotate<0,0.000000,0> translate<42.473772,-1.535000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.588722,-1.535000,57.085850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,56.900969>}
box{<0,0,-0.304800><0.261459,0.035000,0.304800> rotate<0,44.997514,0> translate<42.588722,-1.535000,57.085850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.590822,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,61.894822>}
box{<0,0,-0.304800><0.258487,0.035000,0.304800> rotate<0,44.997030,0> translate<42.590822,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,61.894822>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.773600,-1.535000,56.900969>}
box{<0,0,-0.304800><4.993853,0.035000,0.304800> rotate<0,-90.000000,0> translate<42.773600,-1.535000,56.900969> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.861850,-1.535000,38.016722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.115850,-1.535000,37.762722>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,44.997030,0> translate<42.861850,-1.535000,38.016722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.024072,-1.535000,31.216600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.101706,-1.535000,31.184444>}
box{<0,0,-0.304800><0.084030,0.035000,0.304800> rotate<0,22.497910,0> translate<43.024072,-1.535000,31.216600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.024072,-1.535000,31.216600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.589925,-1.535000,31.216600>}
box{<0,0,-0.304800><0.565853,0.035000,0.304800> rotate<0,0.000000,0> translate<43.024072,-1.535000,31.216600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.083372,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.399900,-1.535000,37.795200>}
box{<0,0,-0.304800><5.316528,0.035000,0.304800> rotate<0,0.000000,0> translate<43.083372,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.101706,-1.535000,31.184444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.307000,-1.535000,30.979150>}
box{<0,0,-0.304800><0.290329,0.035000,0.304800> rotate<0,44.997030,0> translate<43.101706,-1.535000,31.184444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.115850,-1.535000,37.762722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.332397,-1.535000,37.239931>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,67.495554,0> translate<43.115850,-1.535000,37.762722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.196550,-1.535000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.417450,-1.535000,31.089600>}
box{<0,0,-0.304800><0.220900,0.035000,0.304800> rotate<0,0.000000,0> translate<43.196550,-1.535000,31.089600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.244147,-1.535000,24.340275>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.644275,-1.535000,23.940147>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,44.997030,0> translate<43.244147,-1.535000,24.340275> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.307000,-1.535000,30.979150>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.512291,-1.535000,31.184444>}
box{<0,0,-0.304800><0.290327,0.035000,0.304800> rotate<0,-44.997466,0> translate<43.307000,-1.535000,30.979150> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.332397,-1.535000,36.956862>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.332397,-1.535000,37.239931>}
box{<0,0,-0.304800><0.283069,0.035000,0.304800> rotate<0,90.000000,0> translate<43.332397,-1.535000,37.239931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.332397,-1.535000,36.956862>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.442844,-1.535000,37.067312>}
box{<0,0,-0.304800><0.156198,0.035000,0.304800> rotate<0,-44.997841,0> translate<43.332397,-1.535000,36.956862> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.332397,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.728416,-1.535000,37.185600>}
box{<0,0,-0.304800><0.396019,0.035000,0.304800> rotate<0,0.000000,0> translate<43.332397,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.442844,-1.535000,37.067312>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.096331,-1.535000,37.337997>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,-22.498589,0> translate<43.442844,-1.535000,37.067312> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.462931,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.985722,-1.535000,64.705850>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<43.462931,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.512291,-1.535000,31.184444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.589925,-1.535000,31.216600>}
box{<0,0,-0.304800><0.084030,0.035000,0.304800> rotate<0,-22.497910,0> translate<43.512291,-1.535000,31.184444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.644275,-1.535000,23.940147>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.167066,-1.535000,23.723600>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<43.644275,-1.535000,23.940147> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.985722,-1.535000,64.705850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.001722,-1.535000,63.689850>}
box{<0,0,-0.304800><1.436841,0.035000,0.304800> rotate<0,44.997030,0> translate<43.985722,-1.535000,64.705850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.073972,-1.535000,64.617600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.843025,-1.535000,64.617600>}
box{<0,0,-0.304800><9.769053,0.035000,0.304800> rotate<0,0.000000,0> translate<44.073972,-1.535000,64.617600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.096331,-1.535000,37.337997>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.803666,-1.535000,37.337997>}
box{<0,0,-0.304800><0.707334,0.035000,0.304800> rotate<0,0.000000,0> translate<44.096331,-1.535000,37.337997> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.167066,-1.535000,23.723600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.305931,-1.535000,23.723600>}
box{<0,0,-0.304800><13.138866,0.035000,0.304800> rotate<0,0.000000,0> translate<44.167066,-1.535000,23.723600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.683572,-1.535000,64.008000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.233425,-1.535000,64.008000>}
box{<0,0,-0.304800><8.549853,0.035000,0.304800> rotate<0,0.000000,0> translate<44.683572,-1.535000,64.008000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.803666,-1.535000,37.337997>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.457153,-1.535000,37.067312>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,22.498589,0> translate<44.803666,-1.535000,37.337997> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.001722,-1.535000,63.689850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.401850,-1.535000,63.289722>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,44.997030,0> translate<45.001722,-1.535000,63.689850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.171584,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.399900,-1.535000,37.185600>}
box{<0,0,-0.304800><3.228316,0.035000,0.304800> rotate<0,0.000000,0> translate<45.171584,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.293172,-1.535000,63.398400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.623825,-1.535000,63.398400>}
box{<0,0,-0.304800><7.330653,0.035000,0.304800> rotate<0,0.000000,0> translate<45.293172,-1.535000,63.398400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.401850,-1.535000,63.289722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,62.766931>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,67.495554,0> translate<45.401850,-1.535000,63.289722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.457153,-1.535000,37.067312>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.542066,-1.535000,36.982397>}
box{<0,0,-0.304800><0.120087,0.035000,0.304800> rotate<0,44.998084,0> translate<45.457153,-1.535000,37.067312> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.542066,-1.535000,36.982397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.018931,-1.535000,36.982397>}
box{<0,0,-0.304800><1.476866,0.035000,0.304800> rotate<0,0.000000,0> translate<45.542066,-1.535000,36.982397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.564072,-1.535000,31.216600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.641706,-1.535000,31.184444>}
box{<0,0,-0.304800><0.084030,0.035000,0.304800> rotate<0,22.497910,0> translate<45.564072,-1.535000,31.216600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.564072,-1.535000,31.216600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.694600,-1.535000,31.216600>}
box{<0,0,-0.304800><0.130528,0.035000,0.304800> rotate<0,0.000000,0> translate<45.564072,-1.535000,31.216600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.567844,-1.535000,45.897419>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.713100,-1.535000,46.248100>}
box{<0,0,-0.304800><0.379574,0.035000,0.304800> rotate<0,-67.495640,0> translate<45.567844,-1.535000,45.897419> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.567844,-1.535000,45.897419>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.957313,-1.535000,45.507953>}
box{<0,0,-0.304800><0.550790,0.035000,0.304800> rotate<0,44.996800,0> translate<45.567844,-1.535000,45.897419> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.609341,-1.535000,62.788800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.014225,-1.535000,62.788800>}
box{<0,0,-0.304800><6.404884,0.035000,0.304800> rotate<0,0.000000,0> translate<45.609341,-1.535000,62.788800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,52.851125>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,62.766931>}
box{<0,0,-0.304800><9.915806,0.035000,0.304800> rotate<0,90.000000,0> translate<45.618397,-1.535000,62.766931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,52.851125>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.984569,-1.535000,52.699453>}
box{<0,0,-0.304800><0.396341,0.035000,0.304800> rotate<0,22.498317,0> translate<45.618397,-1.535000,52.851125> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,53.035200>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,53.644800>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,54.254400>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,54.864000>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,55.473600>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,56.083200>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,56.692800>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,57.302400>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,57.912000>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,58.521600>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,59.131200>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,59.740800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,59.740800>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,59.740800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,60.350400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,60.350400>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,60.350400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,60.960000>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,61.569600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,61.569600>}
box{<0,0,-0.304800><6.045203,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,61.569600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.618397,-1.535000,62.179200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.683181,-1.535000,62.179200>}
box{<0,0,-0.304800><6.064784,0.035000,0.304800> rotate<0,0.000000,0> translate<45.618397,-1.535000,62.179200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.641706,-1.535000,31.184444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.694600,-1.535000,31.131547>}
box{<0,0,-0.304800><0.074805,0.035000,0.304800> rotate<0,44.998723,0> translate<45.641706,-1.535000,31.184444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.694600,-1.535000,31.216600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.694600,-1.535000,31.131547>}
box{<0,0,-0.304800><0.085053,0.035000,0.304800> rotate<0,-90.000000,0> translate<45.694600,-1.535000,31.131547> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.713100,-1.535000,46.248100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.984569,-1.535000,46.360544>}
box{<0,0,-0.304800><0.293835,0.035000,0.304800> rotate<0,-22.498103,0> translate<45.713100,-1.535000,46.248100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.745266,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.917600,-1.535000,45.720000>}
box{<0,0,-0.304800><6.172334,0.035000,0.304800> rotate<0,0.000000,0> translate<45.745266,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.789691,-1.535000,41.554397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.872397,-1.535000,41.754066>}
box{<0,0,-0.304800><0.216120,0.035000,0.304800> rotate<0,-67.495363,0> translate<45.789691,-1.535000,41.554397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.789691,-1.535000,41.554397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.399900,-1.535000,41.554397>}
box{<0,0,-0.304800><2.610209,0.035000,0.304800> rotate<0,0.000000,0> translate<45.789691,-1.535000,41.554397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.872397,-1.535000,41.754066>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.872397,-1.535000,41.757600>}
box{<0,0,-0.304800><0.003534,0.035000,0.304800> rotate<0,90.000000,0> translate<45.872397,-1.535000,41.757600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.872397,-1.535000,41.757600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.429019,-1.535000,41.757600>}
box{<0,0,-0.304800><2.556622,0.035000,0.304800> rotate<0,0.000000,0> translate<45.872397,-1.535000,41.757600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.909859,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.499131,-1.535000,46.329600>}
box{<0,0,-0.304800><5.589272,0.035000,0.304800> rotate<0,0.000000,0> translate<45.909859,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.957313,-1.535000,45.507953>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.227997,-1.535000,44.854466>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,67.495471,0> translate<45.957313,-1.535000,45.507953> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.984569,-1.535000,46.360544>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.298953,-1.535000,46.674928>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,-44.997030,0> translate<45.984569,-1.535000,46.360544> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.984569,-1.535000,52.699453>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.298953,-1.535000,52.385069>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,44.997030,0> translate<45.984569,-1.535000,52.699453> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.121988,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.668013,-1.535000,45.110400>}
box{<0,0,-0.304800><5.546025,0.035000,0.304800> rotate<0,0.000000,0> translate<46.121988,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.227997,-1.535000,44.602397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.227997,-1.535000,44.854466>}
box{<0,0,-0.304800><0.252069,0.035000,0.304800> rotate<0,90.000000,0> translate<46.227997,-1.535000,44.854466> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.227997,-1.535000,44.602397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.463931,-1.535000,44.602397>}
box{<0,0,-0.304800><5.235934,0.035000,0.304800> rotate<0,0.000000,0> translate<46.227997,-1.535000,44.602397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.258422,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.150575,-1.535000,52.425600>}
box{<0,0,-0.304800><4.892153,0.035000,0.304800> rotate<0,0.000000,0> translate<46.258422,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.298953,-1.535000,46.674928>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.469097,-1.535000,47.085694>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,-67.495658,0> translate<46.298953,-1.535000,46.674928> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.298953,-1.535000,52.385069>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.303372,-1.535000,52.374397>}
box{<0,0,-0.304800><0.011551,0.035000,0.304800> rotate<0,67.503269,0> translate<46.298953,-1.535000,52.385069> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.303372,-1.535000,52.374397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.105625,-1.535000,52.374397>}
box{<0,0,-0.304800><4.802253,0.035000,0.304800> rotate<0,0.000000,0> translate<46.303372,-1.535000,52.374397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.303703,-1.535000,49.529600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.469097,-1.535000,49.130303>}
box{<0,0,-0.304800><0.432196,0.035000,0.304800> rotate<0,67.495598,0> translate<46.303703,-1.535000,49.529600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.303703,-1.535000,49.529600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.105294,-1.535000,49.529600>}
box{<0,0,-0.304800><4.801591,0.035000,0.304800> rotate<0,0.000000,0> translate<46.303703,-1.535000,49.529600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.366666,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.042334,-1.535000,49.377600>}
box{<0,0,-0.304800><4.675669,0.035000,0.304800> rotate<0,0.000000,0> translate<46.366666,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.408416,-1.535000,46.939200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.000578,-1.535000,46.939200>}
box{<0,0,-0.304800><4.592163,0.035000,0.304800> rotate<0,0.000000,0> translate<46.408416,-1.535000,46.939200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.469097,-1.535000,47.085694>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.469097,-1.535000,49.130303>}
box{<0,0,-0.304800><2.044609,0.035000,0.304800> rotate<0,90.000000,0> translate<46.469097,-1.535000,49.130303> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.469097,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.939900,-1.535000,47.548800>}
box{<0,0,-0.304800><4.470803,0.035000,0.304800> rotate<0,0.000000,0> translate<46.469097,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.469097,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.939900,-1.535000,48.158400>}
box{<0,0,-0.304800><4.470803,0.035000,0.304800> rotate<0,0.000000,0> translate<46.469097,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.469097,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.939900,-1.535000,48.768000>}
box{<0,0,-0.304800><4.470803,0.035000,0.304800> rotate<0,0.000000,0> translate<46.469097,-1.535000,48.768000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.018931,-1.535000,36.982397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.541722,-1.535000,36.765850>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<47.018931,-1.535000,36.982397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.541722,-1.535000,36.765850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.941850,-1.535000,36.365722>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,44.997030,0> translate<47.541722,-1.535000,36.765850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.731572,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.492141,-1.535000,36.576000>}
box{<0,0,-0.304800><0.760569,0.035000,0.304800> rotate<0,0.000000,0> translate<47.731572,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.941850,-1.535000,36.365722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.862850,-1.535000,33.444722>}
box{<0,0,-0.304800><4.130918,0.035000,0.304800> rotate<0,44.997030,0> translate<47.941850,-1.535000,36.365722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.341172,-1.535000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.143097,-1.535000,35.966400>}
box{<0,0,-0.304800><0.801925,0.035000,0.304800> rotate<0,0.000000,0> translate<48.341172,-1.535000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.399900,-1.535000,36.798694>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.570044,-1.535000,36.387928>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,67.495658,0> translate<48.399900,-1.535000,36.798694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.399900,-1.535000,38.709600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.399900,-1.535000,36.798694>}
box{<0,0,-0.304800><1.910906,0.035000,0.304800> rotate<0,-90.000000,0> translate<48.399900,-1.535000,36.798694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.399900,-1.535000,41.687303>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.399900,-1.535000,41.554397>}
box{<0,0,-0.304800><0.132906,0.035000,0.304800> rotate<0,-90.000000,0> translate<48.399900,-1.535000,41.554397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.399900,-1.535000,41.687303>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.429019,-1.535000,41.757600>}
box{<0,0,-0.304800><0.076089,0.035000,0.304800> rotate<0,-67.494967,0> translate<48.399900,-1.535000,41.687303> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.570044,-1.535000,36.387928>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.884428,-1.535000,36.073544>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,44.997030,0> translate<48.570044,-1.535000,36.387928> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.884428,-1.535000,36.073544>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.295194,-1.535000,35.903400>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,22.498403,0> translate<48.884428,-1.535000,36.073544> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.950772,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.562000,-1.535000,35.356800>}
box{<0,0,-0.304800><2.611228,0.035000,0.304800> rotate<0,0.000000,0> translate<48.950772,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.295194,-1.535000,35.903400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.542803,-1.535000,35.903400>}
box{<0,0,-0.304800><2.247609,0.035000,0.304800> rotate<0,0.000000,0> translate<49.295194,-1.535000,35.903400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.560372,-1.535000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.562000,-1.535000,34.747200>}
box{<0,0,-0.304800><2.001628,0.035000,0.304800> rotate<0,0.000000,0> translate<49.560372,-1.535000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.169972,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.562000,-1.535000,34.137600>}
box{<0,0,-0.304800><1.392028,0.035000,0.304800> rotate<0,0.000000,0> translate<50.169972,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.779572,-1.535000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.710097,-1.535000,33.528000>}
box{<0,0,-0.304800><0.930525,0.035000,0.304800> rotate<0,0.000000,0> translate<50.779572,-1.535000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.862850,-1.535000,33.444722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.079397,-1.535000,32.921931>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,67.495554,0> translate<50.862850,-1.535000,33.444722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.939900,-1.535000,47.085694>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.110044,-1.535000,46.674928>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,67.495658,0> translate<50.939900,-1.535000,47.085694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.939900,-1.535000,49.130303>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.939900,-1.535000,47.085694>}
box{<0,0,-0.304800><2.044609,0.035000,0.304800> rotate<0,-90.000000,0> translate<50.939900,-1.535000,47.085694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.939900,-1.535000,49.130303>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.105294,-1.535000,49.529600>}
box{<0,0,-0.304800><0.432196,0.035000,0.304800> rotate<0,-67.495598,0> translate<50.939900,-1.535000,49.130303> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.079397,-1.535000,32.643969>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.079397,-1.535000,32.921931>}
box{<0,0,-0.304800><0.277963,0.035000,0.304800> rotate<0,90.000000,0> translate<51.079397,-1.535000,32.921931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.079397,-1.535000,32.643969>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.753147,-1.535000,33.317722>}
box{<0,0,-0.304800><0.952829,0.035000,0.304800> rotate<0,-44.997163,0> translate<51.079397,-1.535000,32.643969> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.079397,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.353828,-1.535000,32.918400>}
box{<0,0,-0.304800><0.274431,0.035000,0.304800> rotate<0,0.000000,0> translate<51.079397,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.105625,-1.535000,52.374397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.110044,-1.535000,52.385069>}
box{<0,0,-0.304800><0.011551,0.035000,0.304800> rotate<0,-67.503269,0> translate<51.105625,-1.535000,52.374397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.110044,-1.535000,46.674928>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.424428,-1.535000,46.360544>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,44.997030,0> translate<51.110044,-1.535000,46.674928> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.110044,-1.535000,52.385069>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.424428,-1.535000,52.699453>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,-44.997030,0> translate<51.110044,-1.535000,52.385069> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.424428,-1.535000,46.360544>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.835194,-1.535000,46.190400>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,22.498403,0> translate<51.424428,-1.535000,46.360544> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.424428,-1.535000,52.699453>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,52.798519>}
box{<0,0,-0.304800><0.258877,0.035000,0.304800> rotate<0,-22.497982,0> translate<51.424428,-1.535000,52.699453> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.463931,-1.535000,44.602397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.562000,-1.535000,44.561772>}
box{<0,0,-0.304800><0.106150,0.035000,0.304800> rotate<0,22.500307,0> translate<51.463931,-1.535000,44.602397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.542803,-1.535000,35.903400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.562000,-1.535000,35.911353>}
box{<0,0,-0.304800><0.020779,0.035000,0.304800> rotate<0,-22.502385,0> translate<51.542803,-1.535000,35.903400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.562000,-1.535000,33.885531>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.784297,-1.535000,33.348869>}
box{<0,0,-0.304800><0.580881,0.035000,0.304800> rotate<0,67.495182,0> translate<51.562000,-1.535000,33.885531> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.562000,-1.535000,35.911353>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.562000,-1.535000,33.885531>}
box{<0,0,-0.304800><2.025822,0.035000,0.304800> rotate<0,-90.000000,0> translate<51.562000,-1.535000,33.885531> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.562000,-1.535000,44.854466>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.562000,-1.535000,44.561772>}
box{<0,0,-0.304800><0.292694,0.035000,0.304800> rotate<0,-90.000000,0> translate<51.562000,-1.535000,44.561772> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.562000,-1.535000,44.854466>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.832684,-1.535000,45.507953>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,-67.495471,0> translate<51.562000,-1.535000,44.854466> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,62.131931>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,52.798519>}
box{<0,0,-0.304800><9.333413,0.035000,0.304800> rotate<0,-90.000000,0> translate<51.663600,-1.535000,52.798519> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.663600,-1.535000,62.131931>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.880147,-1.535000,62.654722>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-67.495554,0> translate<51.663600,-1.535000,62.131931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.753147,-1.535000,33.317722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.784297,-1.535000,33.348869>}
box{<0,0,-0.304800><0.044051,0.035000,0.304800> rotate<0,-44.994156,0> translate<51.753147,-1.535000,33.317722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.832684,-1.535000,45.507953>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.917600,-1.535000,45.592866>}
box{<0,0,-0.304800><0.120087,0.035000,0.304800> rotate<0,-44.995976,0> translate<51.832684,-1.535000,45.507953> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.835194,-1.535000,46.190400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.917600,-1.535000,46.190400>}
box{<0,0,-0.304800><0.082406,0.035000,0.304800> rotate<0,0.000000,0> translate<51.835194,-1.535000,46.190400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.880147,-1.535000,62.654722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.280275,-1.535000,63.054850>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,-44.997030,0> translate<51.880147,-1.535000,62.654722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.917600,-1.535000,46.190400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.917600,-1.535000,45.592866>}
box{<0,0,-0.304800><0.597534,0.035000,0.304800> rotate<0,-90.000000,0> translate<51.917600,-1.535000,45.592866> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.272703,-1.535000,39.242600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.314622,-1.535000,39.141397>}
box{<0,0,-0.304800><0.109541,0.035000,0.304800> rotate<0,67.496008,0> translate<52.272703,-1.535000,39.242600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.272703,-1.535000,39.242600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,39.242600>}
box{<0,0,-0.304800><16.828197,0.035000,0.304800> rotate<0,0.000000,0> translate<52.272703,-1.535000,39.242600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.280275,-1.535000,63.054850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.931275,-1.535000,64.705850>}
box{<0,0,-0.304800><2.334867,0.035000,0.304800> rotate<0,-44.997030,0> translate<52.280275,-1.535000,63.054850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.314622,-1.535000,39.141397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.987931,-1.535000,39.141397>}
box{<0,0,-0.304800><0.673309,0.035000,0.304800> rotate<0,0.000000,0> translate<52.314622,-1.535000,39.141397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.987931,-1.535000,39.141397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.510722,-1.535000,38.924850>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<52.987931,-1.535000,39.141397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.294531,-1.535000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,39.014400>}
box{<0,0,-0.304800><15.806369,0.035000,0.304800> rotate<0,0.000000,0> translate<53.294531,-1.535000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.510722,-1.535000,38.924850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.910850,-1.535000,38.524722>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,44.997030,0> translate<53.510722,-1.535000,38.924850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.910850,-1.535000,38.524722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.545850,-1.535000,37.889722>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<53.910850,-1.535000,38.524722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.931275,-1.535000,64.705850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.454066,-1.535000,64.922397>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-22.498506,0> translate<53.931275,-1.535000,64.705850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.030772,-1.535000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.140206,-1.535000,38.404800>}
box{<0,0,-0.304800><15.109434,0.035000,0.304800> rotate<0,0.000000,0> translate<54.030772,-1.535000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.454066,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.692244,-1.535000,64.922397>}
box{<0,0,-0.304800><3.238178,0.035000,0.304800> rotate<0,0.000000,0> translate<54.454066,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,56.646969>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,61.259822>}
box{<0,0,-0.304800><4.612853,0.035000,0.304800> rotate<0,90.000000,0> translate<54.508397,-1.535000,61.259822> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,56.646969>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.326366,-1.535000,59.464941>}
box{<0,0,-0.304800><3.985212,0.035000,0.304800> rotate<0,-44.997062,0> translate<54.508397,-1.535000,56.646969> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.554228,-1.535000,56.692800>}
box{<0,0,-0.304800><0.045831,0.035000,0.304800> rotate<0,0.000000,0> translate<54.508397,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.163828,-1.535000,57.302400>}
box{<0,0,-0.304800><0.655431,0.035000,0.304800> rotate<0,0.000000,0> translate<54.508397,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.773428,-1.535000,57.912000>}
box{<0,0,-0.304800><1.265031,0.035000,0.304800> rotate<0,0.000000,0> translate<54.508397,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.383028,-1.535000,58.521600>}
box{<0,0,-0.304800><1.874631,0.035000,0.304800> rotate<0,0.000000,0> translate<54.508397,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.992628,-1.535000,59.131200>}
box{<0,0,-0.304800><2.484231,0.035000,0.304800> rotate<0,0.000000,0> translate<54.508397,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,59.740800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.489044,-1.535000,59.740800>}
box{<0,0,-0.304800><2.980647,0.035000,0.304800> rotate<0,0.000000,0> translate<54.508397,-1.535000,59.740800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,60.350400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.146038,-1.535000,60.350400>}
box{<0,0,-0.304800><2.637641,0.035000,0.304800> rotate<0,0.000000,0> translate<54.508397,-1.535000,60.350400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.048400,-1.535000,60.960000>}
box{<0,0,-0.304800><2.540003,0.035000,0.304800> rotate<0,0.000000,0> translate<54.508397,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.508397,-1.535000,61.259822>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.326175,-1.535000,62.077600>}
box{<0,0,-0.304800><1.156513,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.508397,-1.535000,61.259822> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.545850,-1.535000,37.889722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.762397,-1.535000,37.366931>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,67.495554,0> translate<54.545850,-1.535000,37.889722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.585003,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.140209,-1.535000,37.795200>}
box{<0,0,-0.304800><14.555206,0.035000,0.304800> rotate<0,0.000000,0> translate<54.585003,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.762397,-1.535000,36.956862>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.762397,-1.535000,37.366931>}
box{<0,0,-0.304800><0.410069,0.035000,0.304800> rotate<0,90.000000,0> translate<54.762397,-1.535000,37.366931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.762397,-1.535000,36.956862>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.872844,-1.535000,37.067312>}
box{<0,0,-0.304800><0.156198,0.035000,0.304800> rotate<0,-44.997841,0> translate<54.762397,-1.535000,36.956862> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.762397,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.158416,-1.535000,37.185600>}
box{<0,0,-0.304800><0.396019,0.035000,0.304800> rotate<0,0.000000,0> translate<54.762397,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.762397,-1.535000,45.897663>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.762397,-1.535000,46.604028>}
box{<0,0,-0.304800><0.706366,0.035000,0.304800> rotate<0,90.000000,0> translate<54.762397,-1.535000,46.604028> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.762397,-1.535000,45.897663>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.872844,-1.535000,46.008113>}
box{<0,0,-0.304800><0.156198,0.035000,0.304800> rotate<0,-44.997841,0> translate<54.762397,-1.535000,45.897663> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.762397,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.036822,-1.535000,46.329600>}
box{<0,0,-0.304800><0.274425,0.035000,0.304800> rotate<0,0.000000,0> translate<54.762397,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.762397,-1.535000,46.604028>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.820275,-1.535000,46.546147>}
box{<0,0,-0.304800><0.081854,0.035000,0.304800> rotate<0,44.998577,0> translate<54.762397,-1.535000,46.604028> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.818175,-1.535000,61.569600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.146044,-1.535000,61.569600>}
box{<0,0,-0.304800><2.327869,0.035000,0.304800> rotate<0,0.000000,0> translate<54.818175,-1.535000,61.569600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.820275,-1.535000,46.546147>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.216122,-1.535000,46.150303>}
box{<0,0,-0.304800><0.559810,0.035000,0.304800> rotate<0,44.996804,0> translate<54.820275,-1.535000,46.546147> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.872844,-1.535000,37.067312>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.526331,-1.535000,37.337997>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,-22.498589,0> translate<54.872844,-1.535000,37.067312> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.872844,-1.535000,46.008113>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.216122,-1.535000,46.150303>}
box{<0,0,-0.304800><0.371562,0.035000,0.304800> rotate<0,-22.498539,0> translate<54.872844,-1.535000,46.008113> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.326175,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.387450,-1.535000,62.077600>}
box{<0,0,-0.304800><2.061275,0.035000,0.304800> rotate<0,0.000000,0> translate<55.326175,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.526331,-1.535000,37.337997>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.233666,-1.535000,37.337997>}
box{<0,0,-0.304800><0.707334,0.035000,0.304800> rotate<0,0.000000,0> translate<55.526331,-1.535000,37.337997> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.233666,-1.535000,37.337997>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.887153,-1.535000,37.067312>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,22.498589,0> translate<56.233666,-1.535000,37.337997> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.601584,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,37.185600>}
box{<0,0,-0.304800><12.499316,0.035000,0.304800> rotate<0,0.000000,0> translate<56.601584,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.616597,-1.535000,28.910169>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.616597,-1.535000,29.819600>}
box{<0,0,-0.304800><0.909431,0.035000,0.304800> rotate<0,90.000000,0> translate<56.616597,-1.535000,29.819600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.616597,-1.535000,28.910169>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.743600,-1.535000,29.037175>}
box{<0,0,-0.304800><0.179612,0.035000,0.304800> rotate<0,-44.997735,0> translate<56.616597,-1.535000,28.910169> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.616597,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.743600,-1.535000,29.260800>}
box{<0,0,-0.304800><0.127003,0.035000,0.304800> rotate<0,0.000000,0> translate<56.616597,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.616597,-1.535000,29.819600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.743600,-1.535000,29.819600>}
box{<0,0,-0.304800><0.127003,0.035000,0.304800> rotate<0,0.000000,0> translate<56.616597,-1.535000,29.819600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.743600,-1.535000,29.562066>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.743600,-1.535000,29.037175>}
box{<0,0,-0.304800><0.524891,0.035000,0.304800> rotate<0,-90.000000,0> translate<56.743600,-1.535000,29.037175> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.743600,-1.535000,29.819600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.743600,-1.535000,29.562066>}
box{<0,0,-0.304800><0.257534,0.035000,0.304800> rotate<0,-90.000000,0> translate<56.743600,-1.535000,29.562066> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.887153,-1.535000,37.067312>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.387313,-1.535000,36.567153>}
box{<0,0,-0.304800><0.707332,0.035000,0.304800> rotate<0,44.997030,0> translate<56.887153,-1.535000,37.067312> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.921397,-1.535000,51.693969>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.921397,-1.535000,55.036822>}
box{<0,0,-0.304800><3.342853,0.035000,0.304800> rotate<0,90.000000,0> translate<56.921397,-1.535000,55.036822> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.921397,-1.535000,51.693969>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.233275,-1.535000,52.005850>}
box{<0,0,-0.304800><0.441064,0.035000,0.304800> rotate<0,-44.997317,0> translate<56.921397,-1.535000,51.693969> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.921397,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.043428,-1.535000,51.816000>}
box{<0,0,-0.304800><0.122031,0.035000,0.304800> rotate<0,0.000000,0> translate<56.921397,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.921397,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.940925,-1.535000,52.425600>}
box{<0,0,-0.304800><1.019528,0.035000,0.304800> rotate<0,0.000000,0> translate<56.921397,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.921397,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.802206,-1.535000,53.035200>}
box{<0,0,-0.304800><4.880809,0.035000,0.304800> rotate<0,0.000000,0> translate<56.921397,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.921397,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.620400,-1.535000,53.644800>}
box{<0,0,-0.304800><4.699003,0.035000,0.304800> rotate<0,0.000000,0> translate<56.921397,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.921397,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.620400,-1.535000,54.254400>}
box{<0,0,-0.304800><4.699003,0.035000,0.304800> rotate<0,0.000000,0> translate<56.921397,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.921397,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.620400,-1.535000,54.864000>}
box{<0,0,-0.304800><4.699003,0.035000,0.304800> rotate<0,0.000000,0> translate<56.921397,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.921397,-1.535000,55.036822>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.462800,-1.535000,56.578228>}
box{<0,0,-0.304800><2.179875,0.035000,0.304800> rotate<0,-44.997088,0> translate<56.921397,-1.535000,55.036822> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.048400,-1.535000,60.586122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.334553,-1.535000,59.895291>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<57.048400,-1.535000,60.586122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.048400,-1.535000,61.333875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.048400,-1.535000,60.586122>}
box{<0,0,-0.304800><0.747753,0.035000,0.304800> rotate<0,-90.000000,0> translate<57.048400,-1.535000,60.586122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.048400,-1.535000,61.333875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.334553,-1.535000,62.024706>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<57.048400,-1.535000,61.333875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.175397,-1.535000,32.664397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.175397,-1.535000,33.020128>}
box{<0,0,-0.304800><0.355731,0.035000,0.304800> rotate<0,90.000000,0> translate<57.175397,-1.535000,33.020128> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.175397,-1.535000,32.664397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.085778,-1.535000,32.664397>}
box{<0,0,-0.304800><16.910381,0.035000,0.304800> rotate<0,0.000000,0> translate<57.175397,-1.535000,32.664397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.175397,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.736328,-1.535000,32.918400>}
box{<0,0,-0.304800><16.560931,0.035000,0.304800> rotate<0,0.000000,0> translate<57.175397,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.175397,-1.535000,33.020128>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.387313,-1.535000,33.232044>}
box{<0,0,-0.304800><0.299694,0.035000,0.304800> rotate<0,-44.997030,0> translate<57.175397,-1.535000,33.020128> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.233275,-1.535000,52.005850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.647119,-1.535000,52.177269>}
box{<0,0,-0.304800><0.447941,0.035000,0.304800> rotate<0,-22.498404,0> translate<57.233275,-1.535000,52.005850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.305931,-1.535000,23.723600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.828722,-1.535000,23.940147>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-22.498506,0> translate<57.305931,-1.535000,23.723600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.326366,-1.535000,59.464941>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.334553,-1.535000,59.484706>}
box{<0,0,-0.304800><0.021394,0.035000,0.304800> rotate<0,-67.494778,0> translate<57.326366,-1.535000,59.464941> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.334553,-1.535000,59.484706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.539847,-1.535000,59.689997>}
box{<0,0,-0.304800><0.290327,0.035000,0.304800> rotate<0,-44.996594,0> translate<57.334553,-1.535000,59.484706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.334553,-1.535000,59.895291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.539847,-1.535000,59.689997>}
box{<0,0,-0.304800><0.290329,0.035000,0.304800> rotate<0,44.997030,0> translate<57.334553,-1.535000,59.895291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.334553,-1.535000,62.024706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.387450,-1.535000,62.077600>}
box{<0,0,-0.304800><0.074805,0.035000,0.304800> rotate<0,-44.995338,0> translate<57.334553,-1.535000,62.024706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.358172,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.620400,-1.535000,55.473600>}
box{<0,0,-0.304800><4.262228,0.035000,0.304800> rotate<0,0.000000,0> translate<57.358172,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.378466,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,36.576000>}
box{<0,0,-0.304800><11.722434,0.035000,0.304800> rotate<0,0.000000,0> translate<57.378466,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.387313,-1.535000,33.232044>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.657997,-1.535000,33.885531>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,-67.495471,0> translate<57.387313,-1.535000,33.232044> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.387313,-1.535000,36.567153>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.657997,-1.535000,35.913666>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,67.495471,0> translate<57.387313,-1.535000,36.567153> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.428572,-1.535000,23.774400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,23.774400>}
box{<0,0,-0.304800><25.375428,0.035000,0.304800> rotate<0,0.000000,0> translate<57.428572,-1.535000,23.774400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.509900,-1.535000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.300094,-1.535000,33.528000>}
box{<0,0,-0.304800><15.790194,0.035000,0.304800> rotate<0,0.000000,0> translate<57.509900,-1.535000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.636156,-1.535000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,35.966400>}
box{<0,0,-0.304800><11.464744,0.035000,0.304800> rotate<0,0.000000,0> translate<57.636156,-1.535000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.647119,-1.535000,52.177269>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.863291,-1.535000,52.393444>}
box{<0,0,-0.304800><0.305715,0.035000,0.304800> rotate<0,-44.997444,0> translate<57.647119,-1.535000,52.177269> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.657997,-1.535000,33.885531>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.657997,-1.535000,35.913666>}
box{<0,0,-0.304800><2.028134,0.035000,0.304800> rotate<0,90.000000,0> translate<57.657997,-1.535000,35.913666> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.657997,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.152000,-1.535000,34.137600>}
box{<0,0,-0.304800><15.494003,0.035000,0.304800> rotate<0,0.000000,0> translate<57.657997,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.657997,-1.535000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.152000,-1.535000,34.747200>}
box{<0,0,-0.304800><15.494003,0.035000,0.304800> rotate<0,0.000000,0> translate<57.657997,-1.535000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.657997,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.224703,-1.535000,35.356800>}
box{<0,0,-0.304800><11.566706,0.035000,0.304800> rotate<0,0.000000,0> translate<57.657997,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.692244,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.863291,-1.535000,65.093444>}
box{<0,0,-0.304800><0.241897,0.035000,0.304800> rotate<0,-44.997030,0> translate<57.692244,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.828722,-1.535000,23.940147>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.660175,-1.535000,26.771600>}
box{<0,0,-0.304800><4.004279,0.035000,0.304800> rotate<0,-44.997030,0> translate<57.828722,-1.535000,23.940147> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.863291,-1.535000,52.393444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.554122,-1.535000,52.679597>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-22.498618,0> translate<57.863291,-1.535000,52.393444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.863291,-1.535000,65.093444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.554122,-1.535000,65.379597>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-22.498618,0> translate<57.863291,-1.535000,65.093444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.967772,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.760128,-1.535000,56.083200>}
box{<0,0,-0.304800><3.792356,0.035000,0.304800> rotate<0,0.000000,0> translate<57.967772,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.272575,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,24.384000>}
box{<0,0,-0.304800><24.531425,0.035000,0.304800> rotate<0,0.000000,0> translate<58.272575,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.462800,-1.535000,56.578228>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.554122,-1.535000,56.540400>}
box{<0,0,-0.304800><0.098847,0.035000,0.304800> rotate<0,22.499246,0> translate<58.462800,-1.535000,56.578228> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.554122,-1.535000,52.679597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.825875,-1.535000,52.679597>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,0.000000,0> translate<58.554122,-1.535000,52.679597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.554122,-1.535000,56.540400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.825875,-1.535000,56.540400>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,0.000000,0> translate<58.554122,-1.535000,56.540400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.554122,-1.535000,65.379597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.825875,-1.535000,65.379597>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,0.000000,0> translate<58.554122,-1.535000,65.379597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.882175,-1.535000,24.993600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,24.993600>}
box{<0,0,-0.304800><23.921825,0.035000,0.304800> rotate<0,0.000000,0> translate<58.882175,-1.535000,24.993600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.491775,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,25.603200>}
box{<0,0,-0.304800><23.312225,0.035000,0.304800> rotate<0,0.000000,0> translate<59.491775,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.101375,-1.535000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,26.212800>}
box{<0,0,-0.304800><22.702625,0.035000,0.304800> rotate<0,0.000000,0> translate<60.101375,-1.535000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.660175,-1.535000,26.771600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.006931,-1.535000,26.771600>}
box{<0,0,-0.304800><17.346756,0.035000,0.304800> rotate<0,0.000000,0> translate<60.660175,-1.535000,26.771600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.825875,-1.535000,52.679597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.516706,-1.535000,52.393444>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,22.498618,0> translate<60.825875,-1.535000,52.679597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.825875,-1.535000,56.540400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.516706,-1.535000,56.826553>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-22.498618,0> translate<60.825875,-1.535000,56.540400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.825875,-1.535000,65.379597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.516706,-1.535000,65.093444>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,22.498618,0> translate<60.825875,-1.535000,65.379597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.193794,-1.535000,65.227200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.616206,-1.535000,65.227200>}
box{<0,0,-0.304800><8.422413,0.035000,0.304800> rotate<0,0.000000,0> translate<61.193794,-1.535000,65.227200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.193797,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,56.692800>}
box{<0,0,-0.304800><0.883803,0.035000,0.304800> rotate<0,0.000000,0> translate<61.193797,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.439075,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,52.425600>}
box{<0,0,-0.304800><0.638525,0.035000,0.304800> rotate<0,0.000000,0> translate<61.439075,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.516706,-1.535000,52.393444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.045444,-1.535000,51.864706>}
box{<0,0,-0.304800><0.747748,0.035000,0.304800> rotate<0,44.997030,0> translate<61.516706,-1.535000,52.393444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.516706,-1.535000,56.826553>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.045444,-1.535000,57.355291>}
box{<0,0,-0.304800><0.747748,0.035000,0.304800> rotate<0,-44.997030,0> translate<61.516706,-1.535000,56.826553> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.516706,-1.535000,65.093444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.687753,-1.535000,64.922397>}
box{<0,0,-0.304800><0.241897,0.035000,0.304800> rotate<0,44.997030,0> translate<61.516706,-1.535000,65.093444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.620400,-1.535000,53.474122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.906553,-1.535000,52.783291>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<61.620400,-1.535000,53.474122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.620400,-1.535000,55.745875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.620400,-1.535000,53.474122>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,-90.000000,0> translate<61.620400,-1.535000,53.474122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.620400,-1.535000,55.745875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.906553,-1.535000,56.436706>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<61.620400,-1.535000,55.745875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.687753,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.122247,-1.535000,64.922397>}
box{<0,0,-0.304800><7.434494,0.035000,0.304800> rotate<0,0.000000,0> translate<61.687753,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.906553,-1.535000,52.783291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,52.612247>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,44.996507,0> translate<61.906553,-1.535000,52.783291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.906553,-1.535000,56.436706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,56.607750>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,-44.996507,0> translate<61.906553,-1.535000,56.436706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.992553,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,57.302400>}
box{<0,0,-0.304800><0.085047,0.035000,0.304800> rotate<0,0.000000,0> translate<61.992553,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.045444,-1.535000,51.864706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,51.787069>}
box{<0,0,-0.304800><0.084033,0.035000,0.304800> rotate<0,67.496966,0> translate<62.045444,-1.535000,51.864706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.045444,-1.535000,57.355291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,57.432925>}
box{<0,0,-0.304800><0.084030,0.035000,0.304800> rotate<0,-67.496151,0> translate<62.045444,-1.535000,57.355291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.065619,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,51.816000>}
box{<0,0,-0.304800><0.011981,0.035000,0.304800> rotate<0,0.000000,0> translate<62.065619,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,52.612247>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,51.787069>}
box{<0,0,-0.304800><0.825178,0.035000,0.304800> rotate<0,-90.000000,0> translate<62.077600,-1.535000,51.787069> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,57.432925>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.077600,-1.535000,56.607750>}
box{<0,0,-0.304800><0.825175,0.035000,0.304800> rotate<0,-90.000000,0> translate<62.077600,-1.535000,56.607750> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.488969,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.673850,-1.535000,61.892722>}
box{<0,0,-0.304800><0.261459,0.035000,0.304800> rotate<0,44.996546,0> translate<62.488969,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.488969,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.654028,-1.535000,62.077600>}
box{<0,0,-0.304800><3.165059,0.035000,0.304800> rotate<0,0.000000,0> translate<62.488969,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.673850,-1.535000,61.892722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.617600,-1.535000,59.948969>}
box{<0,0,-0.304800><2.748880,0.035000,0.304800> rotate<0,44.997076,0> translate<62.673850,-1.535000,61.892722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.894969,-1.535000,42.087397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.054850,-1.535000,42.247275>}
box{<0,0,-0.304800><0.226104,0.035000,0.304800> rotate<0,-44.996470,0> translate<62.894969,-1.535000,42.087397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.894969,-1.535000,42.087397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.169028,-1.535000,42.087397>}
box{<0,0,-0.304800><5.274059,0.035000,0.304800> rotate<0,0.000000,0> translate<62.894969,-1.535000,42.087397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.996972,-1.535000,61.569600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.146025,-1.535000,61.569600>}
box{<0,0,-0.304800><2.149053,0.035000,0.304800> rotate<0,0.000000,0> translate<62.996972,-1.535000,61.569600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.054850,-1.535000,42.247275>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.816850,-1.535000,43.009275>}
box{<0,0,-0.304800><1.077631,0.035000,0.304800> rotate<0,-44.997030,0> translate<63.054850,-1.535000,42.247275> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.479575,-1.535000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.584422,-1.535000,42.672000>}
box{<0,0,-0.304800><4.104847,0.035000,0.304800> rotate<0,0.000000,0> translate<63.479575,-1.535000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.606572,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.710828,-1.535000,60.960000>}
box{<0,0,-0.304800><1.104256,0.035000,0.304800> rotate<0,0.000000,0> translate<63.606572,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.816850,-1.535000,43.009275>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.033397,-1.535000,43.532066>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-67.495554,0> translate<63.816850,-1.535000,43.009275> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.929650,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.974822,-1.535000,43.281600>}
box{<0,0,-0.304800><3.045172,0.035000,0.304800> rotate<0,0.000000,0> translate<63.929650,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.033397,-1.535000,43.532066>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.033397,-1.535000,45.567600>}
box{<0,0,-0.304800><2.035534,0.035000,0.304800> rotate<0,90.000000,0> translate<64.033397,-1.535000,45.567600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.033397,-1.535000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.584259,-1.535000,43.891200>}
box{<0,0,-0.304800><2.550862,0.035000,0.304800> rotate<0,0.000000,0> translate<64.033397,-1.535000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.033397,-1.535000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.522600,-1.535000,44.500800>}
box{<0,0,-0.304800><2.489203,0.035000,0.304800> rotate<0,0.000000,0> translate<64.033397,-1.535000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.033397,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.522600,-1.535000,45.110400>}
box{<0,0,-0.304800><2.489203,0.035000,0.304800> rotate<0,0.000000,0> translate<64.033397,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.033397,-1.535000,45.567600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.522600,-1.535000,45.567600>}
box{<0,0,-0.304800><2.489203,0.035000,0.304800> rotate<0,0.000000,0> translate<64.033397,-1.535000,45.567600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.216172,-1.535000,60.350400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.617600,-1.535000,60.350400>}
box{<0,0,-0.304800><0.401428,0.035000,0.304800> rotate<0,0.000000,0> translate<64.216172,-1.535000,60.350400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.520969,-1.535000,48.412397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.684978,-1.535000,48.576403>}
box{<0,0,-0.304800><0.231942,0.035000,0.304800> rotate<0,-44.996484,0> translate<64.520969,-1.535000,48.412397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.520969,-1.535000,48.412397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.752913,-1.535000,48.412397>}
box{<0,0,-0.304800><0.231944,0.035000,0.304800> rotate<0,0.000000,0> translate<64.520969,-1.535000,48.412397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.617600,-1.535000,60.169066>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.617600,-1.535000,59.948969>}
box{<0,0,-0.304800><0.220097,0.035000,0.304800> rotate<0,-90.000000,0> translate<64.617600,-1.535000,59.948969> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.617600,-1.535000,60.734931>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.617600,-1.535000,60.169066>}
box{<0,0,-0.304800><0.565866,0.035000,0.304800> rotate<0,-90.000000,0> translate<64.617600,-1.535000,60.169066> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.617600,-1.535000,60.734931>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.834147,-1.535000,61.257722>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-67.495554,0> translate<64.617600,-1.535000,60.734931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.684978,-1.535000,48.576403>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.752913,-1.535000,48.412397>}
box{<0,0,-0.304800><0.177519,0.035000,0.304800> rotate<0,67.495318,0> translate<64.684978,-1.535000,48.576403> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.834147,-1.535000,61.257722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.342147,-1.535000,61.765722>}
box{<0,0,-0.304800><0.718420,0.035000,0.304800> rotate<0,-44.997030,0> translate<64.834147,-1.535000,61.257722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.342147,-1.535000,61.765722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.654028,-1.535000,62.077600>}
box{<0,0,-0.304800><0.441064,0.035000,0.304800> rotate<0,-44.996743,0> translate<65.342147,-1.535000,61.765722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.522600,-1.535000,44.040066>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.739147,-1.535000,43.517275>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,67.495554,0> translate<66.522600,-1.535000,44.040066> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.522600,-1.535000,45.567600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.522600,-1.535000,44.040066>}
box{<0,0,-0.304800><1.527534,0.035000,0.304800> rotate<0,-90.000000,0> translate<66.522600,-1.535000,44.040066> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.739147,-1.535000,43.517275>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.169028,-1.535000,42.087397>}
box{<0,0,-0.304800><2.022155,0.035000,0.304800> rotate<0,44.996968,0> translate<66.739147,-1.535000,43.517275> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,49.611175>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,52.612247>}
box{<0,0,-0.304800><3.001072,0.035000,0.304800> rotate<0,90.000000,0> translate<67.462397,-1.535000,52.612247> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,49.611175>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.645175,-1.535000,49.428397>}
box{<0,0,-0.304800><0.258487,0.035000,0.304800> rotate<0,44.997030,0> translate<67.462397,-1.535000,49.611175> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.660206,-1.535000,49.987200>}
box{<0,0,-0.304800><1.197809,0.035000,0.304800> rotate<0,0.000000,0> translate<67.462397,-1.535000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,50.596800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.478400,-1.535000,50.596800>}
box{<0,0,-0.304800><1.016003,0.035000,0.304800> rotate<0,0.000000,0> translate<67.462397,-1.535000,50.596800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.491875,-1.535000,51.206400>}
box{<0,0,-0.304800><1.029478,0.035000,0.304800> rotate<0,0.000000,0> translate<67.462397,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.744381,-1.535000,51.816000>}
box{<0,0,-0.304800><1.281984,0.035000,0.304800> rotate<0,0.000000,0> translate<67.462397,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.370925,-1.535000,52.425600>}
box{<0,0,-0.304800><1.908528,0.035000,0.304800> rotate<0,0.000000,0> translate<67.462397,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,52.612247>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.633444,-1.535000,52.783291>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,-44.996507,0> translate<67.462397,-1.535000,52.612247> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,56.607750>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,59.537600>}
box{<0,0,-0.304800><2.929850,0.035000,0.304800> rotate<0,90.000000,0> translate<67.462397,-1.535000,59.537600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,56.607750>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.633444,-1.535000,56.436706>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,44.996507,0> translate<67.462397,-1.535000,56.607750> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.616197,-1.535000,56.692800>}
box{<0,0,-0.304800><2.153800,0.035000,0.304800> rotate<0,0.000000,0> translate<67.462397,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.817444,-1.535000,57.302400>}
box{<0,0,-0.304800><1.355047,0.035000,0.304800> rotate<0,0.000000,0> translate<67.462397,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.533953,-1.535000,57.912000>}
box{<0,0,-0.304800><1.071556,0.035000,0.304800> rotate<0,0.000000,0> translate<67.462397,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.478400,-1.535000,58.521600>}
box{<0,0,-0.304800><1.016003,0.035000,0.304800> rotate<0,0.000000,0> translate<67.462397,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.618128,-1.535000,59.131200>}
box{<0,0,-0.304800><1.155731,0.035000,0.304800> rotate<0,0.000000,0> translate<67.462397,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.462397,-1.535000,59.537600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.817450,-1.535000,59.537600>}
box{<0,0,-0.304800><1.355053,0.035000,0.304800> rotate<0,0.000000,0> translate<67.462397,-1.535000,59.537600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.633444,-1.535000,52.783291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.919597,-1.535000,53.474122>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<67.633444,-1.535000,52.783291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.633444,-1.535000,56.436706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.919597,-1.535000,55.745875>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<67.633444,-1.535000,56.436706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.645175,-1.535000,49.428397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.868247,-1.535000,49.428397>}
box{<0,0,-0.304800><1.223072,0.035000,0.304800> rotate<0,0.000000,0> translate<67.645175,-1.535000,49.428397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.737788,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,53.035200>}
box{<0,0,-0.304800><6.404812,0.035000,0.304800> rotate<0,0.000000,0> translate<67.737788,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.779872,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,56.083200>}
box{<0,0,-0.304800><6.362728,0.035000,0.304800> rotate<0,0.000000,0> translate<67.779872,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.919597,-1.535000,53.474122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.919597,-1.535000,55.745875>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,90.000000,0> translate<67.919597,-1.535000,55.745875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.919597,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,53.644800>}
box{<0,0,-0.304800><6.223003,0.035000,0.304800> rotate<0,0.000000,0> translate<67.919597,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.919597,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,54.254400>}
box{<0,0,-0.304800><6.223003,0.035000,0.304800> rotate<0,0.000000,0> translate<67.919597,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.919597,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,54.864000>}
box{<0,0,-0.304800><6.223003,0.035000,0.304800> rotate<0,0.000000,0> translate<67.919597,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.919597,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,55.473600>}
box{<0,0,-0.304800><6.223003,0.035000,0.304800> rotate<0,0.000000,0> translate<67.919597,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.478400,-1.535000,50.426122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.764553,-1.535000,49.735291>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<68.478400,-1.535000,50.426122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.478400,-1.535000,51.173875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.478400,-1.535000,50.426122>}
box{<0,0,-0.304800><0.747753,0.035000,0.304800> rotate<0,-90.000000,0> translate<68.478400,-1.535000,50.426122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.478400,-1.535000,51.173875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.764553,-1.535000,51.864706>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<68.478400,-1.535000,51.173875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.478400,-1.535000,58.046122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.764553,-1.535000,57.355291>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<68.478400,-1.535000,58.046122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.478400,-1.535000,58.793875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.478400,-1.535000,58.046122>}
box{<0,0,-0.304800><0.747753,0.035000,0.304800> rotate<0,-90.000000,0> translate<68.478400,-1.535000,58.046122> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.478400,-1.535000,58.793875>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.764553,-1.535000,59.484706>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<68.478400,-1.535000,58.793875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.764553,-1.535000,49.735291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.969847,-1.535000,49.529997>}
box{<0,0,-0.304800><0.290329,0.035000,0.304800> rotate<0,44.997030,0> translate<68.764553,-1.535000,49.735291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.764553,-1.535000,51.864706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.293291,-1.535000,52.393444>}
box{<0,0,-0.304800><0.747748,0.035000,0.304800> rotate<0,-44.997030,0> translate<68.764553,-1.535000,51.864706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.764553,-1.535000,57.355291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.293291,-1.535000,56.826553>}
box{<0,0,-0.304800><0.747748,0.035000,0.304800> rotate<0,44.997030,0> translate<68.764553,-1.535000,57.355291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.764553,-1.535000,59.484706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.817450,-1.535000,59.537600>}
box{<0,0,-0.304800><0.074805,0.035000,0.304800> rotate<0,-44.995338,0> translate<68.764553,-1.535000,59.484706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.868247,-1.535000,49.428397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.969847,-1.535000,49.529997>}
box{<0,0,-0.304800><0.143684,0.035000,0.304800> rotate<0,-44.997030,0> translate<68.868247,-1.535000,49.428397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,35.655694>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.271044,-1.535000,35.244928>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,67.495658,0> translate<69.100900,-1.535000,35.655694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,37.700303>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,35.655694>}
box{<0,0,-0.304800><2.044609,0.035000,0.304800> rotate<0,-90.000000,0> translate<69.100900,-1.535000,35.655694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,37.700303>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.266459,-1.535000,38.100000>}
box{<0,0,-0.304800><0.432629,0.035000,0.304800> rotate<0,-67.495605,0> translate<69.100900,-1.535000,37.700303> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,38.499694>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.266459,-1.535000,38.100000>}
box{<0,0,-0.304800><0.432626,0.035000,0.304800> rotate<0,67.495447,0> translate<69.100900,-1.535000,38.499694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,39.242600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.100900,-1.535000,38.499694>}
box{<0,0,-0.304800><0.742906,0.035000,0.304800> rotate<0,-90.000000,0> translate<69.100900,-1.535000,38.499694> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.122247,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.293291,-1.535000,65.093444>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,-44.997554,0> translate<69.122247,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.271044,-1.535000,35.244928>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.585428,-1.535000,34.930544>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,44.997030,0> translate<69.271044,-1.535000,35.244928> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.293291,-1.535000,52.393444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.984122,-1.535000,52.679597>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-22.498618,0> translate<69.293291,-1.535000,52.393444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.293291,-1.535000,56.826553>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.984122,-1.535000,56.540400>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,22.498618,0> translate<69.293291,-1.535000,56.826553> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.293291,-1.535000,65.093444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.984122,-1.535000,65.379597>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-22.498618,0> translate<69.293291,-1.535000,65.093444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.585428,-1.535000,34.930544>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.996194,-1.535000,34.760400>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,22.498403,0> translate<69.585428,-1.535000,34.930544> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.984122,-1.535000,52.679597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.255875,-1.535000,52.679597>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,0.000000,0> translate<69.984122,-1.535000,52.679597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.984122,-1.535000,56.540400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.255875,-1.535000,56.540400>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,0.000000,0> translate<69.984122,-1.535000,56.540400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.984122,-1.535000,65.379597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.255875,-1.535000,65.379597>}
box{<0,0,-0.304800><2.271753,0.035000,0.304800> rotate<0,0.000000,0> translate<69.984122,-1.535000,65.379597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.996194,-1.535000,34.760400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.243803,-1.535000,34.760400>}
box{<0,0,-0.304800><2.247609,0.035000,0.304800> rotate<0,0.000000,0> translate<69.996194,-1.535000,34.760400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.243803,-1.535000,34.760400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.654569,-1.535000,34.930544>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,-22.498403,0> translate<72.243803,-1.535000,34.760400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.255875,-1.535000,52.679597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.946706,-1.535000,52.393444>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,22.498618,0> translate<72.255875,-1.535000,52.679597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.255875,-1.535000,56.540400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.946706,-1.535000,56.826553>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-22.498618,0> translate<72.255875,-1.535000,56.540400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.255875,-1.535000,65.379597>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.946706,-1.535000,65.093444>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,22.498618,0> translate<72.255875,-1.535000,65.379597> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.623794,-1.535000,65.227200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,65.227200>}
box{<0,0,-0.304800><10.180206,0.035000,0.304800> rotate<0,0.000000,0> translate<72.623794,-1.535000,65.227200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.623797,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.883622,-1.535000,56.692800>}
box{<0,0,-0.304800><1.259825,0.035000,0.304800> rotate<0,0.000000,0> translate<72.623797,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.654569,-1.535000,34.930544>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.968953,-1.535000,35.244928>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,-44.997030,0> translate<72.654569,-1.535000,34.930544> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.869075,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,52.425600>}
box{<0,0,-0.304800><1.273525,0.035000,0.304800> rotate<0,0.000000,0> translate<72.869075,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.946706,-1.535000,52.393444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.117750,-1.535000,52.222397>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,44.997554,0> translate<72.946706,-1.535000,52.393444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.946706,-1.535000,56.826553>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.117750,-1.535000,56.997600>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,-44.997554,0> translate<72.946706,-1.535000,56.826553> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.946706,-1.535000,65.093444>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.117750,-1.535000,64.922397>}
box{<0,0,-0.304800><0.241895,0.035000,0.304800> rotate<0,44.997554,0> translate<72.946706,-1.535000,65.093444> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.968953,-1.535000,35.244928>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.983728,-1.535000,35.280600>}
box{<0,0,-0.304800><0.038611,0.035000,0.304800> rotate<0,-67.496607,0> translate<72.968953,-1.535000,35.244928> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.983728,-1.535000,35.280600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.152000,-1.535000,35.280600>}
box{<0,0,-0.304800><0.168272,0.035000,0.304800> rotate<0,0.000000,0> translate<72.983728,-1.535000,35.280600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.117750,-1.535000,52.222397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.180931,-1.535000,52.222397>}
box{<0,0,-0.304800><0.063181,0.035000,0.304800> rotate<0,0.000000,0> translate<73.117750,-1.535000,52.222397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.117750,-1.535000,56.997600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.578822,-1.535000,56.997600>}
box{<0,0,-0.304800><0.461072,0.035000,0.304800> rotate<0,0.000000,0> translate<73.117750,-1.535000,56.997600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.117750,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.831931,-1.535000,64.922397>}
box{<0,0,-0.304800><1.714181,0.035000,0.304800> rotate<0,0.000000,0> translate<73.117750,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.152000,-1.535000,33.885531>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.422684,-1.535000,33.232044>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,67.495471,0> translate<73.152000,-1.535000,33.885531> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.152000,-1.535000,35.280600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.152000,-1.535000,33.885531>}
box{<0,0,-0.304800><1.395069,0.035000,0.304800> rotate<0,-90.000000,0> translate<73.152000,-1.535000,33.885531> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.180931,-1.535000,52.222397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.703722,-1.535000,52.005850>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<73.180931,-1.535000,52.222397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.422547,-1.535000,59.842397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.475444,-1.535000,59.895291>}
box{<0,0,-0.304800><0.074805,0.035000,0.304800> rotate<0,-44.995338,0> translate<73.422547,-1.535000,59.842397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.422547,-1.535000,59.842397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.885066,-1.535000,59.842397>}
box{<0,0,-0.304800><0.462519,0.035000,0.304800> rotate<0,0.000000,0> translate<73.422547,-1.535000,59.842397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.422547,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.475444,-1.535000,62.024706>}
box{<0,0,-0.304800><0.074805,0.035000,0.304800> rotate<0,44.995338,0> translate<73.422547,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.422547,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.959822,-1.535000,62.077600>}
box{<0,0,-0.304800><0.537275,0.035000,0.304800> rotate<0,0.000000,0> translate<73.422547,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.422684,-1.535000,33.232044>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.922844,-1.535000,32.731884>}
box{<0,0,-0.304800><0.707332,0.035000,0.304800> rotate<0,44.997030,0> translate<73.422684,-1.535000,33.232044> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.475444,-1.535000,59.895291>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.761597,-1.535000,60.586122>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,-67.495442,0> translate<73.475444,-1.535000,59.895291> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.475444,-1.535000,62.024706>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.761597,-1.535000,61.333875>}
box{<0,0,-0.304800><0.747751,0.035000,0.304800> rotate<0,67.495442,0> translate<73.475444,-1.535000,62.024706> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.578822,-1.535000,56.997600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,56.433822>}
box{<0,0,-0.304800><0.797303,0.035000,0.304800> rotate<0,44.997030,0> translate<73.578822,-1.535000,56.997600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.663956,-1.535000,60.350400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.687022,-1.535000,60.350400>}
box{<0,0,-0.304800><2.023066,0.035000,0.304800> rotate<0,0.000000,0> translate<73.663956,-1.535000,60.350400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.663956,-1.535000,61.569600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.467822,-1.535000,61.569600>}
box{<0,0,-0.304800><0.803866,0.035000,0.304800> rotate<0,0.000000,0> translate<73.663956,-1.535000,61.569600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.703722,-1.535000,52.005850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.103850,-1.535000,51.605722>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,44.997030,0> translate<73.703722,-1.535000,52.005850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.761597,-1.535000,60.586122>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.761597,-1.535000,61.333875>}
box{<0,0,-0.304800><0.747753,0.035000,0.304800> rotate<0,90.000000,0> translate<73.761597,-1.535000,61.333875> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.761597,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.077422,-1.535000,60.960000>}
box{<0,0,-0.304800><1.315825,0.035000,0.304800> rotate<0,0.000000,0> translate<73.761597,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.885066,-1.535000,59.842397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.450931,-1.535000,59.842397>}
box{<0,0,-0.304800><0.565866,0.035000,0.304800> rotate<0,0.000000,0> translate<73.885066,-1.535000,59.842397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.893572,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,51.816000>}
box{<0,0,-0.304800><0.249028,0.035000,0.304800> rotate<0,0.000000,0> translate<73.893572,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.922844,-1.535000,32.731884>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.085778,-1.535000,32.664397>}
box{<0,0,-0.304800><0.176358,0.035000,0.304800> rotate<0,22.497876,0> translate<73.922844,-1.535000,32.731884> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.959822,-1.535000,62.077600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.920600,-1.535000,60.116822>}
box{<0,0,-0.304800><2.772959,0.035000,0.304800> rotate<0,44.997030,0> translate<73.959822,-1.535000,62.077600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.103850,-1.535000,51.605719>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.103850,-1.535000,51.605722>}
box{<0,0,-0.304800><0.000003,0.035000,0.304800> rotate<0,90.000000,0> translate<74.103850,-1.535000,51.605722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.103850,-1.535000,51.605719>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,51.566969>}
box{<0,0,-0.304800><0.054801,0.035000,0.304800> rotate<0,44.997030,0> translate<74.103850,-1.535000,51.605719> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,56.433822>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.142600,-1.535000,51.566969>}
box{<0,0,-0.304800><4.866853,0.035000,0.304800> rotate<0,-90.000000,0> translate<74.142600,-1.535000,51.566969> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.446562,-1.535000,38.074600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.846722,-1.535000,37.908850>}
box{<0,0,-0.304800><0.433129,0.035000,0.304800> rotate<0,22.498339,0> translate<74.446562,-1.535000,38.074600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.446562,-1.535000,38.074600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.825600,-1.535000,38.074600>}
box{<0,0,-0.304800><3.379038,0.035000,0.304800> rotate<0,0.000000,0> translate<74.446562,-1.535000,38.074600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.450931,-1.535000,59.842397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.973722,-1.535000,59.625850>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<74.450931,-1.535000,59.842397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.696209,-1.535000,59.740800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.920600,-1.535000,59.740800>}
box{<0,0,-0.304800><1.224391,0.035000,0.304800> rotate<0,0.000000,0> translate<74.696209,-1.535000,59.740800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.831931,-1.535000,64.922397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.354722,-1.535000,64.705850>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<74.831931,-1.535000,64.922397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.846722,-1.535000,37.908850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.246850,-1.535000,37.508722>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,44.997030,0> translate<74.846722,-1.535000,37.908850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.960372,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.825600,-1.535000,37.795200>}
box{<0,0,-0.304800><2.865228,0.035000,0.304800> rotate<0,0.000000,0> translate<74.960372,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.973722,-1.535000,59.625850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.920600,-1.535000,58.678969>}
box{<0,0,-0.304800><1.339090,0.035000,0.304800> rotate<0,44.997125,0> translate<74.973722,-1.535000,59.625850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.214369,-1.535000,46.278797>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.283666,-1.535000,46.278797>}
box{<0,0,-0.304800><0.069297,0.035000,0.304800> rotate<0,0.000000,0> translate<75.214369,-1.535000,46.278797> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.214369,-1.535000,46.278797>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.617956,-1.535000,46.682384>}
box{<0,0,-0.304800><0.570759,0.035000,0.304800> rotate<0,-44.997030,0> translate<75.214369,-1.535000,46.278797> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.246850,-1.535000,37.508722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.512263,-1.535000,37.243306>}
box{<0,0,-0.304800><0.375352,0.035000,0.304800> rotate<0,44.997367,0> translate<75.246850,-1.535000,37.508722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.265172,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.010131,-1.535000,46.329600>}
box{<0,0,-0.304800><0.744959,0.035000,0.304800> rotate<0,0.000000,0> translate<75.265172,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.283666,-1.535000,46.278797>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.937153,-1.535000,46.008113>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,22.498589,0> translate<75.283666,-1.535000,46.278797> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.354722,-1.535000,64.705850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.148722,-1.535000,61.911850>}
box{<0,0,-0.304800><3.951313,0.035000,0.304800> rotate<0,44.997030,0> translate<75.354722,-1.535000,64.705850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.442972,-1.535000,64.617600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,64.617600>}
box{<0,0,-0.304800><7.361028,0.035000,0.304800> rotate<0,0.000000,0> translate<75.442972,-1.535000,64.617600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.468372,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.920600,-1.535000,59.131200>}
box{<0,0,-0.304800><0.452228,0.035000,0.304800> rotate<0,0.000000,0> translate<75.468372,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.512263,-1.535000,37.243306>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.937153,-1.535000,37.067312>}
box{<0,0,-0.304800><0.459898,0.035000,0.304800> rotate<0,22.498318,0> translate<75.512263,-1.535000,37.243306> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.617956,-1.535000,46.682384>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.621044,-1.535000,46.674928>}
box{<0,0,-0.304800><0.008070,0.035000,0.304800> rotate<0,67.501972,0> translate<75.617956,-1.535000,46.682384> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.621044,-1.535000,46.674928>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.935428,-1.535000,46.360544>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,44.997030,0> translate<75.621044,-1.535000,46.674928> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.651581,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.748416,-1.535000,37.185600>}
box{<0,0,-0.304800><1.096834,0.035000,0.304800> rotate<0,0.000000,0> translate<75.651581,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.920600,-1.535000,60.116822>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.920600,-1.535000,58.678969>}
box{<0,0,-0.304800><1.437853,0.035000,0.304800> rotate<0,-90.000000,0> translate<75.920600,-1.535000,58.678969> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.935428,-1.535000,46.360544>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.346194,-1.535000,46.190400>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,22.498403,0> translate<75.935428,-1.535000,46.360544> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.937153,-1.535000,37.067312>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.199997,-1.535000,36.804466>}
box{<0,0,-0.304800><0.371719,0.035000,0.304800> rotate<0,44.997371,0> translate<75.937153,-1.535000,37.067312> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.937153,-1.535000,46.008113>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,45.745266>}
box{<0,0,-0.304800><0.371722,0.035000,0.304800> rotate<0,44.997030,0> translate<75.937153,-1.535000,46.008113> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.052572,-1.535000,64.008000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,64.008000>}
box{<0,0,-0.304800><6.751428,0.035000,0.304800> rotate<0,0.000000,0> translate<76.052572,-1.535000,64.008000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.199997,-1.535000,36.804466>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.462844,-1.535000,37.067312>}
box{<0,0,-0.304800><0.371722,0.035000,0.304800> rotate<0,-44.997030,0> translate<76.199997,-1.535000,36.804466> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.200000,-1.535000,45.745266>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.462844,-1.535000,46.008113>}
box{<0,0,-0.304800><0.371719,0.035000,0.304800> rotate<0,-44.997371,0> translate<76.200000,-1.535000,45.745266> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.346194,-1.535000,46.190400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.902928,-1.535000,46.190400>}
box{<0,0,-0.304800><0.556734,0.035000,0.304800> rotate<0,0.000000,0> translate<76.346194,-1.535000,46.190400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.462844,-1.535000,37.067312>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.116331,-1.535000,37.337997>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,-22.498589,0> translate<76.462844,-1.535000,37.067312> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.462844,-1.535000,46.008113>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.902928,-1.535000,46.190400>}
box{<0,0,-0.304800><0.476343,0.035000,0.304800> rotate<0,-22.498358,0> translate<76.462844,-1.535000,46.008113> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.662172,-1.535000,63.398400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,63.398400>}
box{<0,0,-0.304800><6.141828,0.035000,0.304800> rotate<0,0.000000,0> translate<76.662172,-1.535000,63.398400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.116331,-1.535000,37.337997>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.823666,-1.535000,37.337997>}
box{<0,0,-0.304800><0.707334,0.035000,0.304800> rotate<0,0.000000,0> translate<77.116331,-1.535000,37.337997> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.220969,-1.535000,40.919397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.703575,-1.535000,41.402000>}
box{<0,0,-0.304800><0.682506,0.035000,0.304800> rotate<0,-44.996845,0> translate<77.220969,-1.535000,40.919397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.220969,-1.535000,40.919397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.222600,-1.535000,40.919397>}
box{<0,0,-0.304800><2.001631,0.035000,0.304800> rotate<0,0.000000,0> translate<77.220969,-1.535000,40.919397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.271772,-1.535000,62.788800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,62.788800>}
box{<0,0,-0.304800><5.532228,0.035000,0.304800> rotate<0,0.000000,0> translate<77.271772,-1.535000,62.788800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.703575,-1.535000,41.402000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.823666,-1.535000,41.402000>}
box{<0,0,-0.304800><0.120091,0.035000,0.304800> rotate<0,0.000000,0> translate<77.703575,-1.535000,41.402000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.823666,-1.535000,37.337997>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.825600,-1.535000,37.337194>}
box{<0,0,-0.304800><0.002094,0.035000,0.304800> rotate<0,22.546042,0> translate<77.823666,-1.535000,37.337997> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.823666,-1.535000,41.402000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.477153,-1.535000,41.672684>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,-22.498589,0> translate<77.823666,-1.535000,41.402000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.825600,-1.535000,38.074600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.825600,-1.535000,37.337194>}
box{<0,0,-0.304800><0.737406,0.035000,0.304800> rotate<0,-90.000000,0> translate<77.825600,-1.535000,37.337194> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.881372,-1.535000,62.179200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,62.179200>}
box{<0,0,-0.304800><4.922628,0.035000,0.304800> rotate<0,0.000000,0> translate<77.881372,-1.535000,62.179200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.946306,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.222600,-1.535000,41.452800>}
box{<0,0,-0.304800><1.276294,0.035000,0.304800> rotate<0,0.000000,0> translate<77.946306,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.006931,-1.535000,26.771600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.529722,-1.535000,26.988147>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-22.498506,0> translate<78.006931,-1.535000,26.771600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.037069,-1.535000,46.190400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.477153,-1.535000,46.008113>}
box{<0,0,-0.304800><0.476343,0.035000,0.304800> rotate<0,22.498358,0> translate<78.037069,-1.535000,46.190400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.037069,-1.535000,46.190400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.593803,-1.535000,46.190400>}
box{<0,0,-0.304800><0.556734,0.035000,0.304800> rotate<0,0.000000,0> translate<78.037069,-1.535000,46.190400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.129572,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,26.822400>}
box{<0,0,-0.304800><4.674428,0.035000,0.304800> rotate<0,0.000000,0> translate<78.129572,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.148722,-1.535000,61.911850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.548850,-1.535000,61.511722>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,44.997030,0> translate<78.148722,-1.535000,61.911850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.477153,-1.535000,41.672684>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.562069,-1.535000,41.757600>}
box{<0,0,-0.304800><0.120089,0.035000,0.304800> rotate<0,-44.997030,0> translate<78.477153,-1.535000,41.672684> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.477153,-1.535000,46.008113>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.977313,-1.535000,45.507953>}
box{<0,0,-0.304800><0.707332,0.035000,0.304800> rotate<0,44.997030,0> translate<78.477153,-1.535000,46.008113> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.490972,-1.535000,61.569600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,61.569600>}
box{<0,0,-0.304800><4.313028,0.035000,0.304800> rotate<0,0.000000,0> translate<78.490972,-1.535000,61.569600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.529722,-1.535000,26.988147>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.450722,-1.535000,29.909147>}
box{<0,0,-0.304800><4.130918,0.035000,0.304800> rotate<0,-44.997030,0> translate<78.529722,-1.535000,26.988147> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.548850,-1.535000,61.511722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,60.988931>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,67.495554,0> translate<78.548850,-1.535000,61.511722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.562069,-1.535000,41.757600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.222600,-1.535000,41.757600>}
box{<0,0,-0.304800><0.660531,0.035000,0.304800> rotate<0,0.000000,0> translate<78.562069,-1.535000,41.757600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.593803,-1.535000,46.190400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.004569,-1.535000,46.360544>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,-22.498403,0> translate<78.593803,-1.535000,46.190400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765266,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,45.720000>}
box{<0,0,-0.304800><4.038734,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765266,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,52.798519>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,60.988931>}
box{<0,0,-0.304800><8.190413,0.035000,0.304800> rotate<0,90.000000,0> translate<78.765397,-1.535000,60.988931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,52.798519>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.004569,-1.535000,52.699453>}
box{<0,0,-0.304800><0.258877,0.035000,0.304800> rotate<0,22.497982,0> translate<78.765397,-1.535000,52.798519> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,53.035200>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,53.644800>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,54.254400>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,54.864000>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,55.473600>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,56.083200>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,56.692800>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,57.302400>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,57.912000>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,58.521600>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,59.131200>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,59.740800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,59.740800>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,59.740800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,60.350400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,60.350400>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,60.350400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.765397,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,60.960000>}
box{<0,0,-0.304800><4.038603,0.035000,0.304800> rotate<0,0.000000,0> translate<78.765397,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.929862,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,46.329600>}
box{<0,0,-0.304800><3.874138,0.035000,0.304800> rotate<0,0.000000,0> translate<78.929862,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.973575,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,27.432000>}
box{<0,0,-0.304800><3.830425,0.035000,0.304800> rotate<0,0.000000,0> translate<78.973575,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.977313,-1.535000,45.507953>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.247997,-1.535000,44.854466>}
box{<0,0,-0.304800><0.707330,0.035000,0.304800> rotate<0,67.495471,0> translate<78.977313,-1.535000,45.507953> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.004569,-1.535000,46.360544>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.318953,-1.535000,46.674928>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,-44.997030,0> translate<79.004569,-1.535000,46.360544> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.004569,-1.535000,52.699453>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.318953,-1.535000,52.385069>}
box{<0,0,-0.304800><0.444607,0.035000,0.304800> rotate<0,44.997030,0> translate<79.004569,-1.535000,52.699453> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.141987,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,45.110400>}
box{<0,0,-0.304800><3.662013,0.035000,0.304800> rotate<0,0.000000,0> translate<79.141987,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.222600,-1.535000,41.757600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.222600,-1.535000,40.919397>}
box{<0,0,-0.304800><0.838203,0.035000,0.304800> rotate<0,-90.000000,0> translate<79.222600,-1.535000,40.919397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.247997,-1.535000,44.602397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.247997,-1.535000,44.854466>}
box{<0,0,-0.304800><0.252069,0.035000,0.304800> rotate<0,90.000000,0> translate<79.247997,-1.535000,44.854466> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.247997,-1.535000,44.602397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.292931,-1.535000,44.602397>}
box{<0,0,-0.304800><1.044934,0.035000,0.304800> rotate<0,0.000000,0> translate<79.247997,-1.535000,44.602397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.278422,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,52.425600>}
box{<0,0,-0.304800><3.525578,0.035000,0.304800> rotate<0,0.000000,0> translate<79.278422,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.318953,-1.535000,46.674928>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,47.085694>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,-67.495658,0> translate<79.318953,-1.535000,46.674928> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.318953,-1.535000,52.385069>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,51.974303>}
box{<0,0,-0.304800><0.444609,0.035000,0.304800> rotate<0,67.495658,0> translate<79.318953,-1.535000,52.385069> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.323538,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,49.130303>}
box{<0,0,-0.304800><0.432629,0.035000,0.304800> rotate<0,67.495605,0> translate<79.323538,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.323538,-1.535000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,49.929694>}
box{<0,0,-0.304800><0.432626,0.035000,0.304800> rotate<0,-67.495447,0> translate<79.323538,-1.535000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.386666,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,49.377600>}
box{<0,0,-0.304800><3.417334,0.035000,0.304800> rotate<0,0.000000,0> translate<79.386666,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.428416,-1.535000,46.939200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,46.939200>}
box{<0,0,-0.304800><3.375584,0.035000,0.304800> rotate<0,0.000000,0> translate<79.428416,-1.535000,46.939200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,47.085694>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,49.130303>}
box{<0,0,-0.304800><2.044609,0.035000,0.304800> rotate<0,90.000000,0> translate<79.489097,-1.535000,49.130303> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,47.548800>}
box{<0,0,-0.304800><3.314903,0.035000,0.304800> rotate<0,0.000000,0> translate<79.489097,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,48.158400>}
box{<0,0,-0.304800><3.314903,0.035000,0.304800> rotate<0,0.000000,0> translate<79.489097,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,48.768000>}
box{<0,0,-0.304800><3.314903,0.035000,0.304800> rotate<0,0.000000,0> translate<79.489097,-1.535000,48.768000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,49.929694>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,51.974303>}
box{<0,0,-0.304800><2.044609,0.035000,0.304800> rotate<0,90.000000,0> translate<79.489097,-1.535000,51.974303> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,49.987200>}
box{<0,0,-0.304800><3.314903,0.035000,0.304800> rotate<0,0.000000,0> translate<79.489097,-1.535000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,50.596800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,50.596800>}
box{<0,0,-0.304800><3.314903,0.035000,0.304800> rotate<0,0.000000,0> translate<79.489097,-1.535000,50.596800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,51.206400>}
box{<0,0,-0.304800><3.314903,0.035000,0.304800> rotate<0,0.000000,0> translate<79.489097,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.489097,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,51.816000>}
box{<0,0,-0.304800><3.314903,0.035000,0.304800> rotate<0,0.000000,0> translate<79.489097,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<79.583175,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,28.041600>}
box{<0,0,-0.304800><3.220825,0.035000,0.304800> rotate<0,0.000000,0> translate<79.583175,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.192775,-1.535000,28.651200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,28.651200>}
box{<0,0,-0.304800><2.611225,0.035000,0.304800> rotate<0,0.000000,0> translate<80.192775,-1.535000,28.651200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.292931,-1.535000,44.602397>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.815722,-1.535000,44.385850>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,22.498506,0> translate<80.292931,-1.535000,44.602397> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.538209,-1.535000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,44.500800>}
box{<0,0,-0.304800><2.265791,0.035000,0.304800> rotate<0,0.000000,0> translate<80.538209,-1.535000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.802375,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,29.260800>}
box{<0,0,-0.304800><2.001625,0.035000,0.304800> rotate<0,0.000000,0> translate<80.802375,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.815722,-1.535000,44.385850>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.215850,-1.535000,43.985722>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,44.997030,0> translate<80.815722,-1.535000,44.385850> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.215850,-1.535000,43.985722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.850850,-1.535000,43.350722>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<81.215850,-1.535000,43.985722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.310372,-1.535000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,43.891200>}
box{<0,0,-0.304800><1.493628,0.035000,0.304800> rotate<0,0.000000,0> translate<81.310372,-1.535000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.411975,-1.535000,29.870400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,29.870400>}
box{<0,0,-0.304800><1.392025,0.035000,0.304800> rotate<0,0.000000,0> translate<81.411975,-1.535000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.450722,-1.535000,29.909147>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.850850,-1.535000,30.309275>}
box{<0,0,-0.304800><0.565867,0.035000,0.304800> rotate<0,-44.997030,0> translate<81.450722,-1.535000,29.909147> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.850850,-1.535000,30.309275>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,30.832066>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,-67.495554,0> translate<81.850850,-1.535000,30.309275> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.850850,-1.535000,43.350722>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,42.827931>}
box{<0,0,-0.304800><0.565864,0.035000,0.304800> rotate<0,67.495554,0> translate<81.850850,-1.535000,43.350722> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.879481,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,43.281600>}
box{<0,0,-0.304800><0.924519,0.035000,0.304800> rotate<0,0.000000,0> translate<81.879481,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<81.921566,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,30.480000>}
box{<0,0,-0.304800><0.882434,0.035000,0.304800> rotate<0,0.000000,0> translate<81.921566,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,30.832066>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,42.827931>}
box{<0,0,-0.304800><11.995866,0.035000,0.304800> rotate<0,90.000000,0> translate<82.067397,-1.535000,42.827931> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,31.089600>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,31.089600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,31.699200>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,32.308800>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,32.918400>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,33.528000>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,34.137600>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,34.747200>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,35.356800>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,35.966400>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,36.576000>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,37.185600>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,37.795200>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,38.404800>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,39.014400>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,39.624000>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,40.233600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,40.233600>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,40.233600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,40.843200>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,41.452800>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,42.062400>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.067397,-1.535000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,42.672000>}
box{<0,0,-0.304800><0.736603,0.035000,0.304800> rotate<0,0.000000,0> translate<82.067397,-1.535000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,68.072000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.804000,-1.535000,23.495000>}
box{<0,0,-0.304800><44.577000,0.035000,0.304800> rotate<0,-90.000000,0> translate<82.804000,-1.535000,23.495000> }
texture{col_pol}
}
#end
union{
cylinder{<54.737000,0.038000,28.829000><54.737000,-1.538000,28.829000>0.508000}
cylinder{<52.197000,0.038000,28.829000><52.197000,-1.538000,28.829000>0.508000}
cylinder{<49.657000,0.038000,28.829000><49.657000,-1.538000,28.829000>0.508000}
cylinder{<47.117000,0.038000,28.829000><47.117000,-1.538000,28.829000>0.508000}
cylinder{<44.577000,0.038000,28.829000><44.577000,-1.538000,28.829000>0.508000}
cylinder{<42.037000,0.038000,28.829000><42.037000,-1.538000,28.829000>0.508000}
cylinder{<39.497000,0.038000,28.829000><39.497000,-1.538000,28.829000>0.508000}
cylinder{<30.480000,0.038000,54.610000><30.480000,-1.538000,54.610000>0.508000}
cylinder{<33.020000,0.038000,54.610000><33.020000,-1.538000,54.610000>0.508000}
cylinder{<63.500000,0.038000,54.610000><63.500000,-1.538000,54.610000>0.508000}
cylinder{<66.040000,0.038000,54.610000><66.040000,-1.538000,54.610000>0.508000}
cylinder{<20.320000,0.038000,35.560000><20.320000,-1.538000,35.560000>0.406400}
cylinder{<22.860000,0.038000,35.560000><22.860000,-1.538000,35.560000>0.406400}
cylinder{<22.860000,0.038000,43.180000><22.860000,-1.538000,43.180000>0.406400}
cylinder{<20.320000,0.038000,43.180000><20.320000,-1.538000,43.180000>0.406400}
cylinder{<53.340000,0.038000,35.560000><53.340000,-1.538000,35.560000>0.406400}
cylinder{<55.880000,0.038000,35.560000><55.880000,-1.538000,35.560000>0.406400}
cylinder{<55.880000,0.038000,43.180000><55.880000,-1.538000,43.180000>0.406400}
cylinder{<53.340000,0.038000,43.180000><53.340000,-1.538000,43.180000>0.406400}
cylinder{<41.910000,0.038000,35.560000><41.910000,-1.538000,35.560000>0.406400}
cylinder{<44.450000,0.038000,35.560000><44.450000,-1.538000,35.560000>0.406400}
cylinder{<44.450000,0.038000,43.180000><44.450000,-1.538000,43.180000>0.406400}
cylinder{<41.910000,0.038000,43.180000><41.910000,-1.538000,43.180000>0.406400}
cylinder{<74.930000,0.038000,35.560000><74.930000,-1.538000,35.560000>0.406400}
cylinder{<77.470000,0.038000,35.560000><77.470000,-1.538000,35.560000>0.406400}
cylinder{<77.470000,0.038000,43.180000><77.470000,-1.538000,43.180000>0.406400}
cylinder{<74.930000,0.038000,43.180000><74.930000,-1.538000,43.180000>0.406400}
cylinder{<27.940000,0.038000,60.960000><27.940000,-1.538000,60.960000>0.508000}
cylinder{<27.940000,0.038000,58.420000><27.940000,-1.538000,58.420000>0.508000}
cylinder{<27.940000,0.038000,63.500000><27.940000,-1.538000,63.500000>0.508000}
cylinder{<59.690000,0.038000,60.960000><59.690000,-1.538000,60.960000>0.508000}
cylinder{<59.690000,0.038000,58.420000><59.690000,-1.538000,58.420000>0.508000}
cylinder{<59.690000,0.038000,63.500000><59.690000,-1.538000,63.500000>0.508000}
cylinder{<38.100000,0.038000,60.960000><38.100000,-1.538000,60.960000>0.508000}
cylinder{<38.100000,0.038000,58.420000><38.100000,-1.538000,58.420000>0.508000}
cylinder{<38.100000,0.038000,63.500000><38.100000,-1.538000,63.500000>0.508000}
cylinder{<71.120000,0.038000,60.960000><71.120000,-1.538000,60.960000>0.508000}
cylinder{<71.120000,0.038000,58.420000><71.120000,-1.538000,58.420000>0.508000}
cylinder{<71.120000,0.038000,63.500000><71.120000,-1.538000,63.500000>0.508000}
cylinder{<27.940000,0.038000,48.260000><27.940000,-1.538000,48.260000>0.508000}
cylinder{<27.940000,0.038000,45.720000><27.940000,-1.538000,45.720000>0.508000}
cylinder{<27.940000,0.038000,50.800000><27.940000,-1.538000,50.800000>0.508000}
cylinder{<59.690000,0.038000,48.260000><59.690000,-1.538000,48.260000>0.508000}
cylinder{<59.690000,0.038000,45.720000><59.690000,-1.538000,45.720000>0.508000}
cylinder{<59.690000,0.038000,50.800000><59.690000,-1.538000,50.800000>0.508000}
cylinder{<38.100000,0.038000,48.260000><38.100000,-1.538000,48.260000>0.508000}
cylinder{<38.100000,0.038000,45.720000><38.100000,-1.538000,45.720000>0.508000}
cylinder{<38.100000,0.038000,50.800000><38.100000,-1.538000,50.800000>0.508000}
cylinder{<71.120000,0.038000,48.260000><71.120000,-1.538000,48.260000>0.508000}
cylinder{<71.120000,0.038000,45.720000><71.120000,-1.538000,45.720000>0.508000}
cylinder{<71.120000,0.038000,50.800000><71.120000,-1.538000,50.800000>0.508000}
//Holes(fast)/Vias
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
//JP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,27.559000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<42.672000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,27.559000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.402000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,28.194000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<40.767000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,29.464000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.767000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,30.099000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.767000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.402000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,30.099000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.402000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,29.464000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<42.672000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,27.559000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.482000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,28.194000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<45.847000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,29.464000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.847000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,30.099000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<45.847000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.212000,0.000000,27.559000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<45.212000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.212000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,27.559000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,28.194000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.307000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,29.464000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.307000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,30.099000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.307000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.212000,0.000000,30.099000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.212000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,29.464000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<45.212000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.927000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,27.559000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<50.292000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,27.559000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.022000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,28.194000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<48.387000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,29.464000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.387000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,30.099000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<48.387000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,30.099000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.022000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.927000,0.000000,29.464000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<50.292000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,28.194000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<47.752000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.387000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,30.099000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<47.752000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.482000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,30.099000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.482000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.372000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.102000,0.000000,27.559000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.102000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.102000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,28.194000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<53.467000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,29.464000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.467000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.102000,0.000000,30.099000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.467000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.832000,0.000000,27.559000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<52.832000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.832000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.562000,0.000000,27.559000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.562000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.562000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.927000,0.000000,28.194000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<50.927000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.927000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.927000,0.000000,29.464000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.927000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.927000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.562000,0.000000,30.099000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<50.927000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.562000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.832000,0.000000,30.099000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.562000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.832000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,29.464000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<52.832000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.007000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.007000,0.000000,29.464000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<56.007000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.372000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.007000,0.000000,28.194000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<55.372000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.007000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.372000,0.000000,30.099000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<55.372000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.102000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.372000,0.000000,30.099000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.102000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,27.559000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.862000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,28.194000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<38.227000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,29.464000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.227000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,30.099000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.227000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,28.194000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.132000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.767000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,30.099000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<40.132000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,30.099000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.862000,0.000000,30.099000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<42.037000,0.000000,28.829000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<44.577000,0.000000,28.829000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<47.117000,0.000000,28.829000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<49.657000,0.000000,28.829000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<52.197000,0.000000,28.829000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<54.737000,0.000000,28.829000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<39.497000,0.000000,28.829000>}
//MO1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,55.880000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.845000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,55.245000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<31.115000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.750000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,53.340000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.115000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.210000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,55.245000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.210000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,53.340000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<29.210000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,53.340000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.845000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,55.880000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.750000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,55.880000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.385000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,55.245000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<33.655000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,53.340000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<33.655000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,53.340000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.385000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.750000,0.000000,53.975000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<31.750000,0.000000,53.975000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<30.480000,0.000000,54.610000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<33.020000,0.000000,54.610000>}
//MO2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,55.880000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.865000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,55.245000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<64.135000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.770000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,53.340000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<64.135000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<62.230000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,55.245000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<62.230000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,53.340000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<62.230000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,53.340000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.865000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,55.880000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<64.770000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,55.880000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.405000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,55.245000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<66.675000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,53.975000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.310000,0.000000,53.975000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.310000,0.000000,53.975000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,53.340000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<66.675000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.675000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,53.340000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.405000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,53.975000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<64.770000,0.000000,53.975000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<63.500000,0.000000,54.610000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<66.040000,0.000000,54.610000>}
//OKA1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,42.291000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.050000,0.000000,42.291000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,36.449000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.050000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,36.449000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.130000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,40.386000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.050000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,38.354000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.050000,0.000000,38.354000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<19.050000,0.000000,39.370000>}
//OKA2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,42.291000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.070000,0.000000,42.291000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,36.449000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.070000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.150000,0.000000,36.449000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<57.150000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,40.386000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.070000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,38.354000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.070000,0.000000,38.354000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<52.070000,0.000000,39.370000>}
//OKB1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,42.291000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.640000,0.000000,42.291000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,36.449000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.640000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,36.449000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.720000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,40.386000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.640000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,38.354000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.640000,0.000000,38.354000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<40.640000,0.000000,39.370000>}
//OKB2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,42.291000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.660000,0.000000,42.291000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,36.449000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.660000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.740000,0.000000,36.449000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.740000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,40.386000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.660000,0.000000,40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.660000,0.000000,38.354000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.660000,0.000000,38.354000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<73.660000,0.000000,39.370000>}
//QA1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.718000,0.000000,65.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.464000,0.000000,65.913000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<29.464000,0.000000,65.913000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.718000,0.000000,65.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.718000,0.000000,56.261000>}
box{<0,0,-0.076200><9.398000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.718000,0.000000,56.261000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.464000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.718000,0.000000,56.261000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.464000,0.000000,56.007000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,66.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.464000,0.000000,65.913000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,2.489389,0> translate<26.543000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.464000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,55.880000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,-2.489389,0> translate<26.543000,0.000000,55.880000> }
difference{
cylinder{<29.108400,0,56.464200><29.108400,0.036000,56.464200>0.254000 translate<0,0.000000,0>}
cylinder{<29.108400,-0.1,56.464200><29.108400,0.135000,56.464200>0.254000 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-90.000000,0> translate<25.781000,0.000000,60.960000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,56.578500>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,59.690000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,58.420000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,62.230000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,65.341500>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,60.960000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,63.500000>}
//QA2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.468000,0.000000,65.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.214000,0.000000,65.913000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<61.214000,0.000000,65.913000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.468000,0.000000,65.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.468000,0.000000,56.261000>}
box{<0,0,-0.076200><9.398000,0.036000,0.076200> rotate<0,-90.000000,0> translate<61.468000,0.000000,56.261000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.214000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.468000,0.000000,56.261000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<61.214000,0.000000,56.007000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.293000,0.000000,66.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.214000,0.000000,65.913000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,2.489389,0> translate<58.293000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.214000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.293000,0.000000,55.880000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,-2.489389,0> translate<58.293000,0.000000,55.880000> }
difference{
cylinder{<60.858400,0,56.464200><60.858400,0.036000,56.464200>0.254000 translate<0,0.000000,0>}
cylinder{<60.858400,-0.1,56.464200><60.858400,0.135000,56.464200>0.254000 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-90.000000,0> translate<57.531000,0.000000,60.960000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,56.578500>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,59.690000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,58.420000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,62.230000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,65.341500>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,60.960000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,63.500000>}
//QB1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,65.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,65.913000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<39.624000,0.000000,65.913000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,65.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,56.261000>}
box{<0,0,-0.076200><9.398000,0.036000,0.076200> rotate<0,-90.000000,0> translate<39.878000,0.000000,56.261000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,56.261000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.624000,0.000000,56.007000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,66.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,65.913000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,2.489389,0> translate<36.703000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,55.880000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,-2.489389,0> translate<36.703000,0.000000,55.880000> }
difference{
cylinder{<39.268400,0,56.464200><39.268400,0.036000,56.464200>0.254000 translate<0,0.000000,0>}
cylinder{<39.268400,-0.1,56.464200><39.268400,0.135000,56.464200>0.254000 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-90.000000,0> translate<35.941000,0.000000,60.960000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,56.578500>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,59.690000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,58.420000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,62.230000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,65.341500>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,60.960000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,63.500000>}
//QB2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,65.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,65.913000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<72.644000,0.000000,65.913000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,65.659000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,56.261000>}
box{<0,0,-0.076200><9.398000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.898000,0.000000,56.261000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,56.261000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<72.644000,0.000000,56.007000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.723000,0.000000,66.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,65.913000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,2.489389,0> translate<69.723000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.723000,0.000000,55.880000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,-2.489389,0> translate<69.723000,0.000000,55.880000> }
difference{
cylinder{<72.288400,0,56.464200><72.288400,0.036000,56.464200>0.254000 translate<0,0.000000,0>}
cylinder{<72.288400,-0.1,56.464200><72.288400,0.135000,56.464200>0.254000 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-90.000000,0> translate<68.961000,0.000000,60.960000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,56.578500>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,59.690000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,58.420000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,62.230000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,65.341500>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,60.960000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,63.500000>}
//QC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.718000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.464000,0.000000,53.213000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<29.464000,0.000000,53.213000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.718000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.718000,0.000000,43.561000>}
box{<0,0,-0.076200><9.398000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.718000,0.000000,43.561000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.464000,0.000000,43.307000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.718000,0.000000,43.561000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.464000,0.000000,43.307000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.464000,0.000000,53.213000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,2.489389,0> translate<26.543000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.464000,0.000000,43.307000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,43.180000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,-2.489389,0> translate<26.543000,0.000000,43.180000> }
difference{
cylinder{<29.108400,0,43.764200><29.108400,0.036000,43.764200>0.254000 translate<0,0.000000,0>}
cylinder{<29.108400,-0.1,43.764200><29.108400,0.135000,43.764200>0.254000 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-90.000000,0> translate<25.781000,0.000000,48.260000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,43.878500>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,46.990000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,45.720000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,49.530000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,52.641500>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,48.260000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<26.416000,0.000000,50.800000>}
//QC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.468000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.214000,0.000000,53.213000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<61.214000,0.000000,53.213000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.468000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.468000,0.000000,43.561000>}
box{<0,0,-0.076200><9.398000,0.036000,0.076200> rotate<0,-90.000000,0> translate<61.468000,0.000000,43.561000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.214000,0.000000,43.307000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.468000,0.000000,43.561000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<61.214000,0.000000,43.307000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.293000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.214000,0.000000,53.213000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,2.489389,0> translate<58.293000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.214000,0.000000,43.307000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.293000,0.000000,43.180000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,-2.489389,0> translate<58.293000,0.000000,43.180000> }
difference{
cylinder{<60.858400,0,43.764200><60.858400,0.036000,43.764200>0.254000 translate<0,0.000000,0>}
cylinder{<60.858400,-0.1,43.764200><60.858400,0.135000,43.764200>0.254000 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-90.000000,0> translate<57.531000,0.000000,48.260000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,43.878500>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,46.990000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,45.720000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,49.530000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,52.641500>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,48.260000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<58.166000,0.000000,50.800000>}
//QD1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,53.213000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<39.624000,0.000000,53.213000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,43.561000>}
box{<0,0,-0.076200><9.398000,0.036000,0.076200> rotate<0,-90.000000,0> translate<39.878000,0.000000,43.561000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,43.307000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,43.561000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.624000,0.000000,43.307000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,53.213000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,2.489389,0> translate<36.703000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.624000,0.000000,43.307000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,43.180000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,-2.489389,0> translate<36.703000,0.000000,43.180000> }
difference{
cylinder{<39.268400,0,43.764200><39.268400,0.036000,43.764200>0.254000 translate<0,0.000000,0>}
cylinder{<39.268400,-0.1,43.764200><39.268400,0.135000,43.764200>0.254000 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-90.000000,0> translate<35.941000,0.000000,48.260000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,43.878500>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,46.990000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,45.720000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,49.530000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,52.641500>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,48.260000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<36.576000,0.000000,50.800000>}
//QD2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,53.213000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<72.644000,0.000000,53.213000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,43.561000>}
box{<0,0,-0.076200><9.398000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.898000,0.000000,43.561000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,43.307000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,43.561000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<72.644000,0.000000,43.307000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.723000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,53.213000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,2.489389,0> translate<69.723000,0.000000,53.340000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.644000,0.000000,43.307000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.723000,0.000000,43.180000>}
box{<0,0,-0.076200><2.923760,0.036000,0.076200> rotate<0,-2.489389,0> translate<69.723000,0.000000,43.180000> }
difference{
cylinder{<72.288400,0,43.764200><72.288400,0.036000,43.764200>0.254000 translate<0,0.000000,0>}
cylinder{<72.288400,-0.1,43.764200><72.288400,0.135000,43.764200>0.254000 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-90.000000,0> translate<68.961000,0.000000,48.260000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,43.878500>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,46.990000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,45.720000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,49.530000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,52.641500>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,48.260000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<69.596000,0.000000,50.800000>}
//RA1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.967200,-1.536000,40.322500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.967200,-1.536000,38.404800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.967200,-1.536000,38.404800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.592800,-1.536000,40.322500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.592800,-1.536000,38.404800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.592800,-1.536000,38.404800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<17.780000,-1.536000,38.049200>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<17.780000,-1.536000,40.690800>}
//RA2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.606200,-1.536000,40.195500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.606200,-1.536000,38.277800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.606200,-1.536000,38.277800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.231800,-1.536000,40.195500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.231800,-1.536000,38.277800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<51.231800,-1.536000,38.277800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<50.419000,-1.536000,37.922200>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<50.419000,-1.536000,40.563800>}
//RB1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.761200,-1.536000,50.228500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.761200,-1.536000,48.310800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.761200,-1.536000,48.310800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.386800,-1.536000,50.228500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.386800,-1.536000,48.310800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.386800,-1.536000,48.310800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<20.574000,-1.536000,47.955200>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<20.574000,-1.536000,50.596800>}
//RB2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.146200,-1.536000,50.482500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.146200,-1.536000,48.564800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.146200,-1.536000,48.564800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.771800,-1.536000,50.482500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.771800,-1.536000,48.564800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.771800,-1.536000,48.564800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<52.959000,-1.536000,48.209200>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<52.959000,-1.536000,50.850800>}
//RC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.637200,-1.536000,50.482500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.637200,-1.536000,48.564800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.637200,-1.536000,48.564800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.262800,-1.536000,50.482500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.262800,-1.536000,48.564800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.262800,-1.536000,48.564800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<44.450000,-1.536000,48.209200>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<44.450000,-1.536000,50.850800>}
//RC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.657200,-1.536000,50.482500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.657200,-1.536000,48.564800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.657200,-1.536000,48.564800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.282800,-1.536000,50.482500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<78.282800,-1.536000,48.564800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<78.282800,-1.536000,48.564800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<77.470000,-1.536000,48.209200>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<77.470000,-1.536000,50.850800>}
//RD1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.430200,-1.536000,39.687500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.430200,-1.536000,37.769800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.430200,-1.536000,37.769800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.055800,-1.536000,39.687500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.055800,-1.536000,37.769800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.055800,-1.536000,37.769800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<39.243000,-1.536000,37.414200>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<39.243000,-1.536000,40.055800>}
//RD2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.307200,-1.536000,39.052500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.307200,-1.536000,37.134800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.307200,-1.536000,37.134800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.932800,-1.536000,39.052500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.932800,-1.536000,37.134800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,-90.000000,0> translate<71.932800,-1.536000,37.134800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<71.120000,-1.536000,36.779200>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-90.000000,0> translate<71.120000,-1.536000,39.420800>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  DRIVER_FET(-48.450500,0,-45.783500,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
