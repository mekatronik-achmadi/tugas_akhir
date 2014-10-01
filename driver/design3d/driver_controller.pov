//POVRay-File created by 3d41.ulp v###VERSIONDUMMY###
///home/kubuntu/Projects/tugas_akhir/driver/design3d/driver_controller.brd
//10/1/14 1:11 PM

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
#local cam_y = 223;
#local cam_z = -119;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -5;
#local cam_look_z = 0;

#local pcb_rotate_x = 180;
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

#local lgt1_pos_x = 21;
#local lgt1_pos_y = 32;
#local lgt1_pos_z = 27;
#local lgt1_intense = 0.742626;
#local lgt2_pos_x = -21;
#local lgt2_pos_y = 32;
#local lgt2_pos_z = 27;
#local lgt2_intense = 0.742626;
#local lgt3_pos_x = 21;
#local lgt3_pos_y = 32;
#local lgt3_pos_z = -18;
#local lgt3_intense = 0.742626;
#local lgt4_pos_x = -21;
#local lgt4_pos_y = 32;
#local lgt4_pos_z = -18;
#local lgt4_intense = 0.742626;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 57.455000;
#declare pcb_y_size = 51.933000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(775);
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
	//translate<-28.727500,0,-25.966500>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro DRIVER_CONTROLLER(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<11.938000,9.779000><69.393000,9.779000>
<69.393000,9.779000><69.393000,61.712000>
<69.393000,61.712000><11.938000,61.585000>
<11.938000,61.585000><11.938000,9.779000>
texture{col_brd}}
}//End union(PCB)
//Holes(real)/Parts
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_C_XA_1) #declare global_pack_C_XA_1=yes; object {CAP_SMD_CHIP_1206()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<63.500000,-1.500000,48.260000>translate<0,-0.035000,0> }#end		//SMD Capacitor 1206 C-XA-1 22p C1206
#ifndef(pack_C_XA_2) #declare global_pack_C_XA_2=yes; object {CAP_SMD_CHIP_1206()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<63.500000,-1.500000,43.180000>translate<0,-0.035000,0> }#end		//SMD Capacitor 1206 C-XA-2 22p C1206
#ifndef(pack_C_XB_1) #declare global_pack_C_XB_1=yes; object {CAP_SMD_CHIP_1206()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,180> translate<63.500000,-1.500000,52.070000>translate<0,-0.035000,0> }#end		//SMD Capacitor 1206 C-XB-1 22p C1206
#ifndef(pack_C_XB_2) #declare global_pack_C_XB_2=yes; object {CAP_SMD_CHIP_1206()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,180> translate<63.500000,-1.500000,54.610000>translate<0,-0.035000,0> }#end		//SMD Capacitor 1206 C-XB-2 22p C1206
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_SMD_SSOP28("FT232RL","",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<30.988000,-1.500000,49.022000>translate<0,-0.035000,0> }#end		//SSOP28 IC1 FT232RL SSOP28
#ifndef(pack_OUTPUT) #declare global_pack_OUTPUT=yes; object {CON_PH_1X8()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<44.450000,0.000000,13.970000>}#end		//Header 2,54mm Grid 8Pin 1Row (jumper.lib) OUTPUT  1X08
#ifndef(pack_PROG) #declare global_pack_PROG=yes; object {CON_PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<48.260000,0.000000,50.800000>}#end		//Header 2,54mm Grid 3Pin 1Row (jumper.lib) PROG  1X03
#ifndef(pack_RL_PWR) #declare global_pack_RL_PWR=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,180> translate<26.924000,-1.500000,36.195000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL-PWR 330 R1206
#ifndef(pack_RL_RUN) #declare global_pack_RL_RUN=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,180> translate<26.924000,-1.500000,33.782000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL-RUN 330 R1206
#ifndef(pack_RL_RX) #declare global_pack_RL_RX=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,180> translate<26.797000,-1.500000,29.083000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL-RX 330 R1206
#ifndef(pack_RL_TX) #declare global_pack_RL_TX=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,180> translate<26.797000,-1.500000,31.496000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL-TX 330 R1206
#ifndef(pack_RL1) #declare global_pack_RL1=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<53.340000,-1.500000,21.590000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL1 330 R1206
#ifndef(pack_RL2) #declare global_pack_RL2=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<50.800000,-1.500000,21.590000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL2 330 R1206
#ifndef(pack_RL3) #declare global_pack_RL3=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<48.260000,-1.500000,21.590000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL3 330 R1206
#ifndef(pack_RL4) #declare global_pack_RL4=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<45.720000,-1.500000,21.590000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL4 330 R1206
#ifndef(pack_RL5) #declare global_pack_RL5=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<43.180000,-1.500000,21.590000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL5 330 R1206
#ifndef(pack_RL6) #declare global_pack_RL6=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<40.640000,-1.500000,21.590000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL6 330 R1206
#ifndef(pack_RL7) #declare global_pack_RL7=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<38.100000,-1.500000,21.590000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL7 330 R1206
#ifndef(pack_RL8) #declare global_pack_RL8=yes; object {RES_SMD_CHIP_1206("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<35.560000,-1.500000,21.590000>translate<0,-0.035000,0> }#end		//SMD Resistor 1206 RL8 330 R1206
#ifndef(pack_U1) #declare global_pack_U1=yes; object {QFP_TQFP_64_080MM("STM32F10XRXT6","",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,180> translate<46.990000,-1.500000,41.910000>translate<0,-0.035000,0> }#end		//TQFP-64 U1 STM32F10XRXT6 TQFP64
#ifndef(pack_X_B) #declare global_pack_X_B=yes; object {SPC_XTAL_CLOCK_025MM("32khz",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<59.690000,0.000000,53.340000>}#end		//Uhrenquarz mit 2,5MM Pitch X-B 32khz TC26V
#ifndef(pack_XA) #declare global_pack_XA=yes; object {SPC_XTAL_5MM("8mhz",3,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<59.690000,0.000000,45.720000>}#end		//Quarz 4,9MM XA 8mhz HC49/S
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<63.500000,-1.537000,49.660000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<63.500000,-1.537000,46.860000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.500000,-1.537000,41.780000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.500000,-1.537000,44.580000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<64.900000,-1.537000,52.070000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<62.100000,-1.537000,52.070000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<64.900000,-1.537000,54.610000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<62.100000,-1.537000,54.610000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,53.247000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,52.597000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,51.947000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,51.297000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,50.647000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,49.997000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,49.347000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,48.697000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,48.047000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,47.397000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,46.747000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,46.097000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,45.447000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<34.613000,-1.537000,44.797000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,44.797000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,45.447000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,46.097000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,46.747000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,47.397000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,48.047000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,48.697000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,49.347000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,49.997000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,50.647000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,51.297000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,51.947000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,52.597000>}
object{TOOLS_PCB_SMD(0.400000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.363000,-1.537000,53.247000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<29.718000,-1.537000,38.382000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<29.718000,-1.537000,41.882000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<32.258000,-1.537000,38.382000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<32.258000,-1.537000,41.882000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<38.227000,-1.537000,40.795000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<38.227000,-1.537000,44.295000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<36.322000,-1.537000,39.779000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<36.322000,-1.537000,43.279000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<53.340000,-1.537000,24.920000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<53.340000,-1.537000,28.420000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<50.800000,-1.537000,24.920000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<50.800000,-1.537000,28.420000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<48.260000,-1.537000,24.920000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<48.260000,-1.537000,28.420000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<45.720000,-1.537000,24.920000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<45.720000,-1.537000,28.420000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<43.180000,-1.537000,24.920000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<43.180000,-1.537000,28.420000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<40.640000,-1.537000,24.920000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<40.640000,-1.537000,28.420000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<38.100000,-1.537000,24.920000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<38.100000,-1.537000,28.420000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<35.560000,-1.537000,24.920000>}
object{TOOLS_PCB_SMD(1.500000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<35.560000,-1.537000,28.420000>}
#ifndef(global_pack_OUTPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<53.340000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_OUTPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<50.800000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_OUTPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<48.260000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_OUTPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<45.720000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_OUTPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<43.180000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_OUTPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<40.640000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_OUTPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<38.100000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_OUTPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<35.560000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_PROG) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<45.720000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_PROG) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.260000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_PROG) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.800000,0,50.800000> texture{col_thl}}
#ifndef(global_pack_PWR) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.981200,1.320800,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<51.993800,0,55.880000> texture{col_thl}}
#ifndef(global_pack_PWR) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.981200,1.320800,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<46.990000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_PWR) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.981200,1.320800,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<41.986200,0,55.880000> texture{col_thl}}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<28.346000,-1.537000,36.195000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<25.502000,-1.537000,36.195000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<28.346000,-1.537000,33.782000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<25.502000,-1.537000,33.782000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<28.219000,-1.537000,29.083000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<25.375000,-1.537000,29.083000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<28.219000,-1.537000,31.496000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<25.375000,-1.537000,31.496000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<53.340000,-1.537000,23.012000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<53.340000,-1.537000,20.168000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<50.800000,-1.537000,23.012000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<50.800000,-1.537000,20.168000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<48.260000,-1.537000,23.012000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<48.260000,-1.537000,20.168000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<45.720000,-1.537000,23.012000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<45.720000,-1.537000,20.168000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<43.180000,-1.537000,23.012000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<43.180000,-1.537000,20.168000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<40.640000,-1.537000,23.012000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<40.640000,-1.537000,20.168000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<38.100000,-1.537000,23.012000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<38.100000,-1.537000,20.168000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<35.560000,-1.537000,23.012000>}
object{TOOLS_PCB_SMD(1.600000,1.803000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<35.560000,-1.537000,20.168000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,45.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,45.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,44.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,44.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,43.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,43.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,42.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,42.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,41.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,41.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,40.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,40.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,39.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,39.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,38.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.690000,-1.537000,38.160000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.740000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.240000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<49.740000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<49.240000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<48.740000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<48.240000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<47.740000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<47.240000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<46.740000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<46.240000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<45.740000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<45.240000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<44.740000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<44.240000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<43.740000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<43.240000,-1.537000,36.210000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,38.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,38.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,39.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,39.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,40.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,40.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,41.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,41.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,42.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,42.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,43.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,43.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,44.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,44.660000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,45.160000>}
object{TOOLS_PCB_SMD(1.200000,0.300000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.290000,-1.537000,45.660000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<43.240000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<43.740000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<44.240000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<44.740000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<45.240000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<45.740000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<46.240000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<46.740000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<47.240000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<47.740000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<48.240000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<48.740000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<49.240000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<49.740000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.240000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(0.300000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.740000,-1.537000,47.610000>}
object{TOOLS_PCB_SMD(3.100000,0.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<20.272000,-1.537000,44.247000>}
object{TOOLS_PCB_SMD(3.100000,0.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<20.272000,-1.537000,45.047000>}
object{TOOLS_PCB_SMD(3.100000,0.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<20.272000,-1.537000,45.847000>}
object{TOOLS_PCB_SMD(3.100000,0.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<20.272000,-1.537000,46.647000>}
object{TOOLS_PCB_SMD(3.100000,0.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<20.272000,-1.537000,47.447000>}
object{TOOLS_PCB_SMD(2.500000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<14.272000,-1.537000,50.297000>}
object{TOOLS_PCB_SMD(2.500000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<14.272000,-1.537000,41.397000>}
object{TOOLS_PCB_SMD(3.300000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<20.172000,-1.537000,41.397000>}
object{TOOLS_PCB_SMD(3.300000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<20.172000,-1.537000,50.297000>}
#ifndef(global_pack_X_B) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<59.690000,0,52.070000> texture{col_thl}}
#ifndef(global_pack_X_B) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<59.690000,0,54.610000> texture{col_thl}}
#ifndef(global_pack_XA) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<59.690000,0,43.307000> texture{col_thl}}
#ifndef(global_pack_XA) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<59.690000,0,48.133000> texture{col_thl}}
//Pads/Vias
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<23.876000,0,41.275000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<23.876000,0,51.689000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<54.864000,0,60.325000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,0,0) translate<54.864000,0,54.483000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.272000,-1.535000,44.247000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.428000,-1.535000,44.247000>}
box{<0,0,-0.152400><2.156000,0.035000,0.152400> rotate<0,0.000000,0> translate<20.272000,-1.535000,44.247000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.272000,-1.535000,47.447000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.784000,-1.535000,47.447000>}
box{<0,0,-0.152400><2.512000,0.035000,0.152400> rotate<0,0.000000,0> translate<20.272000,-1.535000,47.447000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.428000,-1.535000,44.247000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.860000,-1.535000,43.815000>}
box{<0,0,-0.152400><0.610940,0.035000,0.152400> rotate<0,44.997030,0> translate<22.428000,-1.535000,44.247000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.784000,-1.535000,47.447000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.860000,-1.535000,47.371000>}
box{<0,0,-0.152400><0.107480,0.035000,0.152400> rotate<0,44.997030,0> translate<22.784000,-1.535000,47.447000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.860000,-1.535000,47.371000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.860000,-1.535000,54.737000>}
box{<0,0,-0.152400><7.366000,0.035000,0.152400> rotate<0,90.000000,0> translate<22.860000,-1.535000,54.737000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.860000,-1.535000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.368000,-1.535000,43.815000>}
box{<0,0,-0.152400><0.508000,0.035000,0.152400> rotate<0,0.000000,0> translate<22.860000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.860000,-1.535000,47.371000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.484000,-1.535000,46.747000>}
box{<0,0,-0.152400><0.882469,0.035000,0.152400> rotate<0,44.997030,0> translate<22.860000,-1.535000,47.371000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.484000,-1.535000,46.747000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.495000,-1.535000,46.736000>}
box{<0,0,-0.152400><0.015556,0.035000,0.152400> rotate<0,44.997030,0> translate<23.484000,-1.535000,46.747000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,-1.535000,37.846000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,-1.535000,26.416000>}
box{<0,0,-0.152400><11.430000,0.035000,0.152400> rotate<0,-90.000000,0> translate<23.876000,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,-1.535000,43.307000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,-1.535000,41.275000>}
box{<0,0,-0.152400><2.032000,0.035000,0.152400> rotate<0,-90.000000,0> translate<23.876000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.368000,-1.535000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,-1.535000,43.307000>}
box{<0,0,-0.152400><0.718420,0.035000,0.152400> rotate<0,44.997030,0> translate<23.368000,-1.535000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,0.000000,51.689000>}
box{<0,0,-0.152400><10.414000,0.035000,0.152400> rotate<0,90.000000,0> translate<23.876000,0.000000,51.689000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,-1.535000,51.689000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,-1.535000,53.975000>}
box{<0,0,-0.152400><2.286000,0.035000,0.152400> rotate<0,90.000000,0> translate<23.876000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.272000,-1.535000,45.047000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.914000,-1.535000,45.047000>}
box{<0,0,-0.152400><3.642000,0.035000,0.152400> rotate<0,0.000000,0> translate<20.272000,-1.535000,45.047000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,-1.535000,37.846000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.130000,-1.535000,38.100000>}
box{<0,0,-0.152400><0.359210,0.035000,0.152400> rotate<0,-44.997030,0> translate<23.876000,-1.535000,37.846000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.272000,-1.535000,45.847000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.130000,-1.535000,45.847000>}
box{<0,0,-0.152400><3.858000,0.035000,0.152400> rotate<0,0.000000,0> translate<20.272000,-1.535000,45.847000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,-1.535000,51.689000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.130000,-1.535000,51.689000>}
box{<0,0,-0.152400><0.254000,0.035000,0.152400> rotate<0,0.000000,0> translate<23.876000,-1.535000,51.689000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.892000,-1.535000,50.927000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.892000,-1.535000,48.514000>}
box{<0,0,-0.152400><2.413000,0.035000,0.152400> rotate<0,-90.000000,0> translate<24.892000,-1.535000,48.514000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.130000,-1.535000,51.689000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.892000,-1.535000,50.927000>}
box{<0,0,-0.152400><1.077631,0.035000,0.152400> rotate<0,44.997030,0> translate<24.130000,-1.535000,51.689000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.914000,-1.535000,45.047000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.019000,-1.535000,43.942000>}
box{<0,0,-0.152400><1.562706,0.035000,0.152400> rotate<0,44.997030,0> translate<23.914000,-1.535000,45.047000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.130000,-1.535000,45.847000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.146000,-1.535000,44.831000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,44.997030,0> translate<24.130000,-1.535000,45.847000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.892000,-1.535000,48.514000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.359000,-1.535000,48.047000>}
box{<0,0,-0.152400><0.660438,0.035000,0.152400> rotate<0,44.997030,0> translate<24.892000,-1.535000,48.514000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.375000,-1.535000,31.496000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.375000,-1.535000,29.083000>}
box{<0,0,-0.152400><2.413000,0.035000,0.152400> rotate<0,-90.000000,0> translate<25.375000,-1.535000,29.083000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.375000,-1.535000,31.496000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.375000,-1.535000,29.235000>}
box{<0,0,-0.152400><2.261000,0.035000,0.152400> rotate<0,-90.000000,0> translate<25.375000,-1.535000,29.235000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,26.289000>}
box{<0,0,-0.152400><2.921000,0.035000,0.152400> rotate<0,-90.000000,0> translate<25.400000,-1.535000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.375000,-1.535000,29.235000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,29.210000>}
box{<0,0,-0.152400><0.035355,0.035000,0.152400> rotate<0,44.997030,0> translate<25.375000,-1.535000,29.235000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,29.337000>}
box{<0,0,-0.152400><0.127000,0.035000,0.152400> rotate<0,90.000000,0> translate<25.400000,-1.535000,29.337000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.375000,-1.535000,31.496000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.502000,-1.535000,31.369000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,44.997030,0> translate<25.375000,-1.535000,31.496000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.502000,-1.535000,30.759000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.502000,-1.535000,31.369000>}
box{<0,0,-0.152400><0.610000,0.035000,0.152400> rotate<0,90.000000,0> translate<25.502000,-1.535000,31.369000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.502000,-1.535000,33.782000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.502000,-1.535000,31.369000>}
box{<0,0,-0.152400><2.413000,0.035000,0.152400> rotate<0,-90.000000,0> translate<25.502000,-1.535000,31.369000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.502000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.502000,-1.535000,33.782000>}
box{<0,0,-0.152400><2.413000,0.035000,0.152400> rotate<0,-90.000000,0> translate<25.502000,-1.535000,33.782000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.527000,-1.535000,29.337000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<25.400000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.527000,-1.535000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.527000,-1.535000,29.337000>}
box{<0,0,-0.152400><0.127000,0.035000,0.152400> rotate<0,-90.000000,0> translate<25.527000,-1.535000,29.337000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,29.337000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.527000,-1.535000,29.464000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<25.400000,-1.535000,29.337000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.502000,-1.535000,30.759000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.527000,-1.535000,30.734000>}
box{<0,0,-0.152400><0.035355,0.035000,0.152400> rotate<0,44.997030,0> translate<25.502000,-1.535000,30.759000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.860000,-1.535000,54.737000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.654000,-1.535000,57.531000>}
box{<0,0,-0.152400><3.951313,0.035000,0.152400> rotate<0,-44.997030,0> translate<22.860000,-1.535000,54.737000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.781000,-1.535000,55.880000>}
box{<0,0,-0.152400><2.694077,0.035000,0.152400> rotate<0,-44.997030,0> translate<23.876000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.146000,-1.535000,44.831000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.329000,-1.535000,44.831000>}
box{<0,0,-0.152400><2.183000,0.035000,0.152400> rotate<0,0.000000,0> translate<25.146000,-1.535000,44.831000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.329000,-1.535000,44.831000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.363000,-1.535000,44.797000>}
box{<0,0,-0.152400><0.048083,0.035000,0.152400> rotate<0,44.997030,0> translate<27.329000,-1.535000,44.831000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.484000,-1.535000,46.747000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.363000,-1.535000,46.747000>}
box{<0,0,-0.152400><3.879000,0.035000,0.152400> rotate<0,0.000000,0> translate<23.484000,-1.535000,46.747000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.359000,-1.535000,48.047000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.363000,-1.535000,48.047000>}
box{<0,0,-0.152400><2.004000,0.035000,0.152400> rotate<0,0.000000,0> translate<25.359000,-1.535000,48.047000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.130000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.940000,-1.535000,38.100000>}
box{<0,0,-0.152400><3.810000,0.035000,0.152400> rotate<0,0.000000,0> translate<24.130000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.940000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.067000,-1.535000,38.227000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<27.940000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.067000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.067000,-1.535000,38.227000>}
box{<0,0,-0.152400><3.048000,0.035000,0.152400> rotate<0,-90.000000,0> translate<28.067000,-1.535000,38.227000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.363000,-1.535000,45.447000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.213000,-1.535000,45.447000>}
box{<0,0,-0.152400><0.850000,0.035000,0.152400> rotate<0,0.000000,0> translate<27.363000,-1.535000,45.447000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.019000,-1.535000,43.942000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.321000,-1.535000,43.942000>}
box{<0,0,-0.152400><3.302000,0.035000,0.152400> rotate<0,0.000000,0> translate<25.019000,-1.535000,43.942000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.495000,-1.535000,46.736000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.448000,-1.535000,46.736000>}
box{<0,0,-0.152400><4.953000,0.035000,0.152400> rotate<0,0.000000,0> translate<23.495000,-1.535000,46.736000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.363000,-1.535000,46.747000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.459000,-1.535000,46.747000>}
box{<0,0,-0.152400><1.096000,0.035000,0.152400> rotate<0,0.000000,0> translate<27.363000,-1.535000,46.747000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.448000,-1.535000,46.736000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.459000,-1.535000,46.747000>}
box{<0,0,-0.152400><0.015556,0.035000,0.152400> rotate<0,-44.997030,0> translate<28.448000,-1.535000,46.736000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.575000,-1.535000,21.717000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.575000,-1.535000,14.605000>}
box{<0,0,-0.152400><7.112000,0.035000,0.152400> rotate<0,-90.000000,0> translate<28.575000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876000,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.575000,-1.535000,21.717000>}
box{<0,0,-0.152400><6.645390,0.035000,0.152400> rotate<0,44.997030,0> translate<23.876000,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.067000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.575000,-1.535000,41.783000>}
box{<0,0,-0.152400><0.718420,0.035000,0.152400> rotate<0,-44.997030,0> translate<28.067000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.219000,-1.535000,29.083000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.702000,-1.535000,29.083000>}
box{<0,0,-0.152400><0.483000,0.035000,0.152400> rotate<0,0.000000,0> translate<28.219000,-1.535000,29.083000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.321000,-1.535000,43.942000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.702000,-1.535000,44.323000>}
box{<0,0,-0.152400><0.538815,0.035000,0.152400> rotate<0,-44.997030,0> translate<28.321000,-1.535000,43.942000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.702000,-1.535000,44.958000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.702000,-1.535000,44.323000>}
box{<0,0,-0.152400><0.635000,0.035000,0.152400> rotate<0,-90.000000,0> translate<28.702000,-1.535000,44.323000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.213000,-1.535000,45.447000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.702000,-1.535000,44.958000>}
box{<0,0,-0.152400><0.691550,0.035000,0.152400> rotate<0,44.997030,0> translate<28.213000,-1.535000,45.447000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.363000,-1.535000,51.297000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.840000,-1.535000,51.297000>}
box{<0,0,-0.152400><1.477000,0.035000,0.152400> rotate<0,0.000000,0> translate<27.363000,-1.535000,51.297000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.363000,-1.535000,51.947000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.952000,-1.535000,51.947000>}
box{<0,0,-0.152400><1.589000,0.035000,0.152400> rotate<0,0.000000,0> translate<27.363000,-1.535000,51.947000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.363000,-1.535000,48.697000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.012000,-1.535000,48.697000>}
box{<0,0,-0.152400><1.649000,0.035000,0.152400> rotate<0,0.000000,0> translate<27.363000,-1.535000,48.697000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.459000,-1.535000,46.747000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.083000,-1.535000,47.371000>}
box{<0,0,-0.152400><0.882469,0.035000,0.152400> rotate<0,-44.997030,0> translate<28.459000,-1.535000,46.747000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.083000,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.083000,-1.535000,47.371000>}
box{<0,0,-0.152400><1.397000,0.035000,0.152400> rotate<0,-90.000000,0> translate<29.083000,-1.535000,47.371000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.012000,-1.535000,48.697000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.083000,-1.535000,48.768000>}
box{<0,0,-0.152400><0.100409,0.035000,0.152400> rotate<0,-44.997030,0> translate<29.012000,-1.535000,48.697000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.083000,-1.535000,51.054000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.083000,-1.535000,48.768000>}
box{<0,0,-0.152400><2.286000,0.035000,0.152400> rotate<0,-90.000000,0> translate<29.083000,-1.535000,48.768000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.840000,-1.535000,51.297000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.083000,-1.535000,51.054000>}
box{<0,0,-0.152400><0.343654,0.035000,0.152400> rotate<0,44.997030,0> translate<28.840000,-1.535000,51.297000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.083000,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.083000,-1.535000,51.054000>}
box{<0,0,-0.152400><0.762000,0.035000,0.152400> rotate<0,-90.000000,0> translate<29.083000,-1.535000,51.054000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.952000,-1.535000,51.947000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.083000,-1.535000,51.816000>}
box{<0,0,-0.152400><0.185262,0.035000,0.152400> rotate<0,44.997030,0> translate<28.952000,-1.535000,51.947000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.346000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.210000,-1.535000,36.195000>}
box{<0,0,-0.152400><0.864000,0.035000,0.152400> rotate<0,0.000000,0> translate<28.346000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.591000,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.591000,-1.535000,15.113000>}
box{<0,0,-0.152400><6.985000,0.035000,0.152400> rotate<0,-90.000000,0> translate<29.591000,-1.535000,15.113000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.400000,-1.535000,26.289000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.591000,-1.535000,22.098000>}
box{<0,0,-0.152400><5.926969,0.035000,0.152400> rotate<0,44.997030,0> translate<25.400000,-1.535000,26.289000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.575000,-1.535000,41.783000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.591000,-1.535000,41.783000>}
box{<0,0,-0.152400><1.016000,0.035000,0.152400> rotate<0,0.000000,0> translate<28.575000,-1.535000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.210000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.718000,-1.535000,36.703000>}
box{<0,0,-0.152400><0.718420,0.035000,0.152400> rotate<0,-44.997030,0> translate<29.210000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.718000,-1.535000,36.703000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.718000,-1.535000,38.382000>}
box{<0,0,-0.152400><1.679000,0.035000,0.152400> rotate<0,90.000000,0> translate<29.718000,-1.535000,38.382000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.718000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.718000,-1.535000,41.882000>}
box{<0,0,-0.152400><0.028000,0.035000,0.152400> rotate<0,-90.000000,0> translate<29.718000,-1.535000,41.882000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.591000,-1.535000,41.783000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.718000,-1.535000,41.910000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<29.591000,-1.535000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.718000,-1.535000,43.307000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.718000,-1.535000,41.910000>}
box{<0,0,-0.152400><1.397000,0.035000,0.152400> rotate<0,-90.000000,0> translate<29.718000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.718000,-1.535000,43.307000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.845000,-1.535000,43.434000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<29.718000,-1.535000,43.307000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.845000,-1.535000,43.561000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.845000,-1.535000,43.434000>}
box{<0,0,-0.152400><0.127000,0.035000,0.152400> rotate<0,-90.000000,0> translate<29.845000,-1.535000,43.434000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.219000,-1.535000,31.496000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.972000,-1.535000,31.496000>}
box{<0,0,-0.152400><1.753000,0.035000,0.152400> rotate<0,0.000000,0> translate<28.219000,-1.535000,31.496000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.845000,-1.535000,43.434000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.972000,-1.535000,43.561000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<29.845000,-1.535000,43.434000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.845000,-1.535000,43.561000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.972000,-1.535000,43.561000>}
box{<0,0,-0.152400><0.127000,0.035000,0.152400> rotate<0,0.000000,0> translate<29.845000,-1.535000,43.561000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.972000,-1.535000,43.561000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.861000,-1.535000,43.561000>}
box{<0,0,-0.152400><0.889000,0.035000,0.152400> rotate<0,0.000000,0> translate<29.972000,-1.535000,43.561000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.363000,-1.535000,46.097000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.984000,-1.535000,46.097000>}
box{<0,0,-0.152400><3.621000,0.035000,0.152400> rotate<0,0.000000,0> translate<27.363000,-1.535000,46.097000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.346000,-1.535000,33.782000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.242000,-1.535000,33.782000>}
box{<0,0,-0.152400><2.896000,0.035000,0.152400> rotate<0,0.000000,0> translate<28.346000,-1.535000,33.782000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.369000,-1.535000,30.607000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.369000,-1.535000,16.891000>}
box{<0,0,-0.152400><13.716000,0.035000,0.152400> rotate<0,-90.000000,0> translate<31.369000,-1.535000,16.891000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.496000,-1.535000,52.959000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.496000,-1.535000,50.038000>}
box{<0,0,-0.152400><2.921000,0.035000,0.152400> rotate<0,-90.000000,0> translate<31.496000,-1.535000,50.038000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.984000,-1.535000,46.097000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.623000,-1.535000,46.736000>}
box{<0,0,-0.152400><0.903682,0.035000,0.152400> rotate<0,-44.997030,0> translate<30.984000,-1.535000,46.097000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.623000,-1.535000,46.736000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.623000,-1.535000,49.657000>}
box{<0,0,-0.152400><2.921000,0.035000,0.152400> rotate<0,90.000000,0> translate<31.623000,-1.535000,49.657000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.496000,-1.535000,50.038000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.750000,-1.535000,49.784000>}
box{<0,0,-0.152400><0.359210,0.035000,0.152400> rotate<0,44.997030,0> translate<31.496000,-1.535000,50.038000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.623000,-1.535000,49.657000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.750000,-1.535000,49.784000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<31.623000,-1.535000,49.657000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.004000,-1.535000,30.099000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.004000,-1.535000,17.907000>}
box{<0,0,-0.152400><12.192000,0.035000,0.152400> rotate<0,-90.000000,0> translate<32.004000,-1.535000,17.907000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.369000,-1.535000,16.891000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.258000,-1.535000,16.002000>}
box{<0,0,-0.152400><1.257236,0.035000,0.152400> rotate<0,44.997030,0> translate<31.369000,-1.535000,16.891000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.242000,-1.535000,33.782000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.258000,-1.535000,34.798000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<31.242000,-1.535000,33.782000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.258000,-1.535000,34.798000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.258000,-1.535000,38.382000>}
box{<0,0,-0.152400><3.584000,0.035000,0.152400> rotate<0,90.000000,0> translate<32.258000,-1.535000,38.382000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.258000,-1.535000,41.882000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.488000,-1.535000,41.652000>}
box{<0,0,-0.152400><0.325269,0.035000,0.152400> rotate<0,44.997030,0> translate<32.258000,-1.535000,41.882000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.575000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.512000,-1.535000,10.668000>}
box{<0,0,-0.152400><5.567759,0.035000,0.152400> rotate<0,44.997030,0> translate<28.575000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.861000,-1.535000,43.561000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.512000,-1.535000,45.212000>}
box{<0,0,-0.152400><2.334867,0.035000,0.152400> rotate<0,-44.997030,0> translate<30.861000,-1.535000,43.561000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.512000,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.512000,-1.535000,45.212000>}
box{<0,0,-0.152400><3.556000,0.035000,0.152400> rotate<0,-90.000000,0> translate<32.512000,-1.535000,45.212000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.496000,-1.535000,52.959000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.512000,-1.535000,53.975000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<31.496000,-1.535000,52.959000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.258000,-1.535000,41.882000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.536000,-1.535000,42.160000>}
box{<0,0,-0.152400><0.393151,0.035000,0.152400> rotate<0,-44.997030,0> translate<32.258000,-1.535000,41.882000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.639000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.639000,-1.535000,18.288000>}
box{<0,0,-0.152400><11.557000,0.035000,0.152400> rotate<0,-90.000000,0> translate<32.639000,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.512000,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.091000,-1.535000,49.347000>}
box{<0,0,-0.152400><0.818830,0.035000,0.152400> rotate<0,-44.997030,0> translate<32.512000,-1.535000,48.768000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.591000,-1.535000,15.113000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.147000,-1.535000,11.557000>}
box{<0,0,-0.152400><5.028943,0.035000,0.152400> rotate<0,44.997030,0> translate<29.591000,-1.535000,15.113000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.750000,-1.535000,49.784000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.263000,-1.535000,51.297000>}
box{<0,0,-0.152400><2.139705,0.035000,0.152400> rotate<0,-44.997030,0> translate<31.750000,-1.535000,49.784000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.004000,-1.535000,17.907000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.274000,-1.535000,16.637000>}
box{<0,0,-0.152400><1.796051,0.035000,0.152400> rotate<0,44.997030,0> translate<32.004000,-1.535000,17.907000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.274000,-1.535000,29.591000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.274000,-1.535000,18.923000>}
box{<0,0,-0.152400><10.668000,0.035000,0.152400> rotate<0,-90.000000,0> translate<33.274000,-1.535000,18.923000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.258000,-1.535000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.528000,-1.535000,16.002000>}
box{<0,0,-0.152400><1.270000,0.035000,0.152400> rotate<0,0.000000,0> translate<32.258000,-1.535000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.639000,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.655000,-1.535000,17.272000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,44.997030,0> translate<32.639000,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.036000,-1.535000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.036000,-1.535000,19.177000>}
box{<0,0,-0.152400><10.287000,0.035000,0.152400> rotate<0,-90.000000,0> translate<34.036000,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.274000,-1.535000,18.923000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.290000,-1.535000,17.907000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,44.997030,0> translate<33.274000,-1.535000,18.923000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.036000,-1.535000,19.177000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.544000,-1.535000,18.669000>}
box{<0,0,-0.152400><0.718420,0.035000,0.152400> rotate<0,44.997030,0> translate<34.036000,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.091000,-1.535000,49.347000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.613000,-1.535000,49.347000>}
box{<0,0,-0.152400><1.522000,0.035000,0.152400> rotate<0,0.000000,0> translate<33.091000,-1.535000,49.347000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.263000,-1.535000,51.297000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.613000,-1.535000,51.297000>}
box{<0,0,-0.152400><1.350000,0.035000,0.152400> rotate<0,0.000000,0> translate<33.263000,-1.535000,51.297000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.613000,-1.535000,50.647000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.639000,-1.535000,50.673000>}
box{<0,0,-0.152400><0.036770,0.035000,0.152400> rotate<0,-44.997030,0> translate<34.613000,-1.535000,50.647000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.972000,-1.535000,31.496000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.179000,-1.535000,36.703000>}
box{<0,0,-0.152400><7.363810,0.035000,0.152400> rotate<0,-44.997030,0> translate<29.972000,-1.535000,31.496000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.179000,-1.535000,36.703000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.179000,-1.535000,39.624000>}
box{<0,0,-0.152400><2.921000,0.035000,0.152400> rotate<0,90.000000,0> translate<35.179000,-1.535000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.179000,-1.535000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.306000,-1.535000,39.751000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<35.179000,-1.535000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.528000,-1.535000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,13.970000>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,44.997030,0> translate<33.528000,-1.535000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,23.012000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,24.920000>}
box{<0,0,-0.152400><1.908000,0.035000,0.152400> rotate<0,90.000000,0> translate<35.560000,-1.535000,24.920000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,29.083000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,28.420000>}
box{<0,0,-0.152400><0.663000,0.035000,0.152400> rotate<0,-90.000000,0> translate<35.560000,-1.535000,28.420000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.639000,-1.535000,50.673000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.814000,-1.535000,50.673000>}
box{<0,0,-0.152400><1.175000,0.035000,0.152400> rotate<0,0.000000,0> translate<34.639000,-1.535000,50.673000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.306000,-1.535000,39.751000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.294000,-1.535000,39.751000>}
box{<0,0,-0.152400><0.988000,0.035000,0.152400> rotate<0,0.000000,0> translate<35.306000,-1.535000,39.751000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.294000,-1.535000,39.751000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.322000,-1.535000,39.779000>}
box{<0,0,-0.152400><0.039598,0.035000,0.152400> rotate<0,-44.997030,0> translate<36.294000,-1.535000,39.751000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.814000,-1.535000,50.673000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.322000,-1.535000,50.165000>}
box{<0,0,-0.152400><0.718420,0.035000,0.152400> rotate<0,44.997030,0> translate<35.814000,-1.535000,50.673000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.322000,-1.535000,43.279000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.322000,-1.535000,50.165000>}
box{<0,0,-0.152400><6.886000,0.035000,0.152400> rotate<0,90.000000,0> translate<36.322000,-1.535000,50.165000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.613000,-1.535000,53.247000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.923000,-1.535000,53.247000>}
box{<0,0,-0.152400><2.310000,0.035000,0.152400> rotate<0,0.000000,0> translate<34.613000,-1.535000,53.247000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.274000,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.084000,-1.535000,16.637000>}
box{<0,0,-0.152400><3.810000,0.035000,0.152400> rotate<0,0.000000,0> translate<33.274000,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.322000,-1.535000,43.279000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.322000,-1.535000,42.660000>}
box{<0,0,-0.152400><1.176079,0.035000,0.152400> rotate<0,31.755412,0> translate<36.322000,-1.535000,43.279000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.369000,-1.535000,30.607000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.338000,-1.535000,36.576000>}
box{<0,0,-0.152400><8.441441,0.035000,0.152400> rotate<0,-44.997030,0> translate<31.369000,-1.535000,30.607000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.702000,-1.535000,29.083000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.338000,-1.535000,37.719000>}
box{<0,0,-0.152400><12.213148,0.035000,0.152400> rotate<0,-44.997030,0> translate<28.702000,-1.535000,29.083000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.639000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.465000,-1.535000,34.671000>}
box{<0,0,-0.152400><6.824995,0.035000,0.152400> rotate<0,-44.997030,0> translate<32.639000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.274000,-1.535000,29.591000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.719000,-1.535000,34.036000>}
box{<0,0,-0.152400><6.286179,0.035000,0.152400> rotate<0,-44.997030,0> translate<33.274000,-1.535000,29.591000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.004000,-1.535000,30.099000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.719000,-1.535000,35.814000>}
box{<0,0,-0.152400><8.082231,0.035000,0.152400> rotate<0,-44.997030,0> translate<32.004000,-1.535000,30.099000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.036000,-1.535000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.973000,-1.535000,33.401000>}
box{<0,0,-0.152400><5.567759,0.035000,0.152400> rotate<0,-44.997030,0> translate<34.036000,-1.535000,29.464000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,20.168000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,-1.535000,20.168000>}
box{<0,0,-0.152400><2.540000,0.035000,0.152400> rotate<0,0.000000,0> translate<35.560000,-1.535000,20.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,-1.535000,23.012000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,-1.535000,24.920000>}
box{<0,0,-0.152400><1.908000,0.035000,0.152400> rotate<0,90.000000,0> translate<38.100000,-1.535000,24.920000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,-1.535000,30.353000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,-1.535000,28.420000>}
box{<0,0,-0.152400><1.933000,0.035000,0.152400> rotate<0,-90.000000,0> translate<38.100000,-1.535000,28.420000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,14.097000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<38.100000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,15.494000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,14.097000>}
box{<0,0,-0.152400><1.397000,0.035000,0.152400> rotate<0,-90.000000,0> translate<38.227000,-1.535000,14.097000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.084000,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,15.494000>}
box{<0,0,-0.152400><1.616446,0.035000,0.152400> rotate<0,44.997030,0> translate<37.084000,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.655000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,17.272000>}
box{<0,0,-0.152400><4.572000,0.035000,0.152400> rotate<0,0.000000,0> translate<33.655000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.338000,-1.535000,37.719000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,37.719000>}
box{<0,0,-0.152400><0.889000,0.035000,0.152400> rotate<0,0.000000,0> translate<37.338000,-1.535000,37.719000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,37.719000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,40.795000>}
box{<0,0,-0.152400><3.076000,0.035000,0.152400> rotate<0,90.000000,0> translate<38.227000,-1.535000,40.795000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<36.923000,-1.535000,53.247000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,51.943000>}
box{<0,0,-0.152400><1.844134,0.035000,0.152400> rotate<0,44.997030,0> translate<36.923000,-1.535000,53.247000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,44.295000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,51.943000>}
box{<0,0,-0.152400><7.648000,0.035000,0.152400> rotate<0,90.000000,0> translate<38.227000,-1.535000,51.943000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,44.295000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.354000,-1.535000,44.168000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,44.997030,0> translate<38.227000,-1.535000,44.295000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.354000,-1.535000,43.688000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.354000,-1.535000,44.168000>}
box{<0,0,-0.152400><0.480000,0.035000,0.152400> rotate<0,90.000000,0> translate<38.354000,-1.535000,44.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.354000,-1.535000,43.688000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.882000,-1.535000,43.160000>}
box{<0,0,-0.152400><0.746705,0.035000,0.152400> rotate<0,44.997030,0> translate<38.354000,-1.535000,43.688000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.338000,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.989000,-1.535000,36.576000>}
box{<0,0,-0.152400><1.651000,0.035000,0.152400> rotate<0,0.000000,0> translate<37.338000,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.147000,-1.535000,11.557000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.243000,-1.535000,11.557000>}
box{<0,0,-0.152400><6.096000,0.035000,0.152400> rotate<0,0.000000,0> translate<33.147000,-1.535000,11.557000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.560000,-1.535000,29.083000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.243000,-1.535000,32.766000>}
box{<0,0,-0.152400><5.208549,0.035000,0.152400> rotate<0,-44.997030,0> translate<35.560000,-1.535000,29.083000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.719000,-1.535000,35.814000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.243000,-1.535000,35.814000>}
box{<0,0,-0.152400><1.524000,0.035000,0.152400> rotate<0,0.000000,0> translate<37.719000,-1.535000,35.814000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.243000,-1.535000,11.557000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,11.684000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<39.243000,-1.535000,11.557000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,16.129000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,11.684000>}
box{<0,0,-0.152400><4.445000,0.035000,0.152400> rotate<0,-90.000000,0> translate<39.370000,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.227000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,16.129000>}
box{<0,0,-0.152400><1.616446,0.035000,0.152400> rotate<0,44.997030,0> translate<38.227000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.290000,-1.535000,17.907000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,17.907000>}
box{<0,0,-0.152400><5.080000,0.035000,0.152400> rotate<0,0.000000,0> translate<34.290000,-1.535000,17.907000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.989000,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,36.957000>}
box{<0,0,-0.152400><0.538815,0.035000,0.152400> rotate<0,-44.997030,0> translate<38.989000,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,40.132000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,36.957000>}
box{<0,0,-0.152400><3.175000,0.035000,0.152400> rotate<0,-90.000000,0> translate<39.370000,-1.535000,36.957000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.512000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,53.975000>}
box{<0,0,-0.152400><6.858000,0.035000,0.152400> rotate<0,0.000000,0> translate<32.512000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.654000,-1.535000,57.531000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.624000,-1.535000,57.531000>}
box{<0,0,-0.152400><13.970000,0.035000,0.152400> rotate<0,0.000000,0> translate<25.654000,-1.535000,57.531000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,-1.535000,30.353000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.878000,-1.535000,32.131000>}
box{<0,0,-0.152400><2.514472,0.035000,0.152400> rotate<0,-44.997030,0> translate<38.100000,-1.535000,30.353000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.243000,-1.535000,35.814000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.878000,-1.535000,36.449000>}
box{<0,0,-0.152400><0.898026,0.035000,0.152400> rotate<0,-44.997030,0> translate<39.243000,-1.535000,35.814000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.878000,-1.535000,39.878000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.878000,-1.535000,36.449000>}
box{<0,0,-0.152400><3.429000,0.035000,0.152400> rotate<0,-90.000000,0> translate<39.878000,-1.535000,36.449000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,53.975000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.878000,-1.535000,53.467000>}
box{<0,0,-0.152400><0.718420,0.035000,0.152400> rotate<0,44.997030,0> translate<39.370000,-1.535000,53.975000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.878000,-1.535000,49.911000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.878000,-1.535000,53.467000>}
box{<0,0,-0.152400><3.556000,0.035000,0.152400> rotate<0,90.000000,0> translate<39.878000,-1.535000,53.467000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,40.132000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.898000,-1.535000,40.660000>}
box{<0,0,-0.152400><0.746705,0.035000,0.152400> rotate<0,-44.997030,0> translate<39.370000,-1.535000,40.132000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.878000,-1.535000,49.911000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.005000,-1.535000,49.784000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,44.997030,0> translate<39.878000,-1.535000,49.911000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.878000,-1.535000,39.878000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.160000,-1.535000,40.160000>}
box{<0,0,-0.152400><0.398808,0.035000,0.152400> rotate<0,-44.997030,0> translate<39.878000,-1.535000,39.878000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,13.970000>}
box{<0,0,-0.152400><2.667000,0.035000,0.152400> rotate<0,-90.000000,0> translate<40.640000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.370000,-1.535000,17.907000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,16.637000>}
box{<0,0,-0.152400><1.796051,0.035000,0.152400> rotate<0,44.997030,0> translate<39.370000,-1.535000,17.907000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.100000,-1.535000,20.168000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,20.168000>}
box{<0,0,-0.152400><2.540000,0.035000,0.152400> rotate<0,0.000000,0> translate<38.100000,-1.535000,20.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,23.012000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,24.920000>}
box{<0,0,-0.152400><1.908000,0.035000,0.152400> rotate<0,90.000000,0> translate<40.640000,-1.535000,24.920000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,30.607000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,28.420000>}
box{<0,0,-0.152400><2.187000,0.035000,0.152400> rotate<0,-90.000000,0> translate<40.640000,-1.535000,28.420000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.160000,-1.535000,40.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,40.160000>}
box{<0,0,-0.152400><1.130000,0.035000,0.152400> rotate<0,0.000000,0> translate<40.160000,-1.535000,40.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.898000,-1.535000,40.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,40.660000>}
box{<0,0,-0.152400><1.392000,0.035000,0.152400> rotate<0,0.000000,0> translate<39.898000,-1.535000,40.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.536000,-1.535000,42.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,42.160000>}
box{<0,0,-0.152400><8.754000,0.035000,0.152400> rotate<0,0.000000,0> translate<32.536000,-1.535000,42.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.322000,-1.535000,42.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,42.660000>}
box{<0,0,-0.152400><3.968000,0.035000,0.152400> rotate<0,0.000000,0> translate<37.322000,-1.535000,42.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<38.882000,-1.535000,43.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,43.160000>}
box{<0,0,-0.152400><2.408000,0.035000,0.152400> rotate<0,0.000000,0> translate<38.882000,-1.535000,43.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,30.607000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.656000,-1.535000,31.623000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<40.640000,-1.535000,30.607000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.544000,-1.535000,18.669000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.783000,-1.535000,18.669000>}
box{<0,0,-0.152400><7.239000,0.035000,0.152400> rotate<0,0.000000,0> translate<34.544000,-1.535000,18.669000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,45.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.977000,-1.535000,45.660000>}
box{<0,0,-0.152400><0.687000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290000,-1.535000,45.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.781000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.986200,-1.535000,55.880000>}
box{<0,0,-0.152400><16.205200,0.035000,0.152400> rotate<0,0.000000,0> translate<25.781000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.977000,-1.535000,45.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.418000,-1.535000,46.101000>}
box{<0,0,-0.152400><0.623668,0.035000,0.152400> rotate<0,-44.997030,0> translate<41.977000,-1.535000,45.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.005000,-1.535000,49.784000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.418000,-1.535000,49.784000>}
box{<0,0,-0.152400><2.413000,0.035000,0.152400> rotate<0,0.000000,0> translate<40.005000,-1.535000,49.784000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.418000,-1.535000,46.101000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.418000,-1.535000,49.784000>}
box{<0,0,-0.152400><3.683000,0.035000,0.152400> rotate<0,90.000000,0> translate<42.418000,-1.535000,49.784000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.624000,-1.535000,57.531000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.418000,-1.535000,60.325000>}
box{<0,0,-0.152400><3.951313,0.035000,0.152400> rotate<0,-44.997030,0> translate<39.624000,-1.535000,57.531000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,45.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.470000,-1.535000,45.160000>}
box{<0,0,-0.152400><1.180000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290000,-1.535000,45.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,38.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.478000,-1.535000,38.160000>}
box{<0,0,-0.152400><1.188000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290000,-1.535000,38.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,38.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.620000,-1.535000,38.660000>}
box{<0,0,-0.152400><1.330000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290000,-1.535000,38.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,39.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.628000,-1.535000,39.160000>}
box{<0,0,-0.152400><1.338000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290000,-1.535000,39.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,44.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.628000,-1.535000,44.660000>}
box{<0,0,-0.152400><1.338000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290000,-1.535000,44.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,39.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.636000,-1.535000,39.660000>}
box{<0,0,-0.152400><1.346000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290000,-1.535000,39.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,44.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.636000,-1.535000,44.160000>}
box{<0,0,-0.152400><1.346000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290000,-1.535000,44.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,43.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.644000,-1.535000,43.660000>}
box{<0,0,-0.152400><1.354000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290000,-1.535000,43.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,41.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.660000,-1.535000,41.160000>}
box{<0,0,-0.152400><1.370000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290000,-1.535000,41.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290000,-1.535000,41.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.668000,-1.535000,41.660000>}
box{<0,0,-0.152400><1.378000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290000,-1.535000,41.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.478000,-1.535000,38.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,38.354000>}
box{<0,0,-0.152400><0.274357,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.478000,-1.535000,38.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.620000,-1.535000,38.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,38.608000>}
box{<0,0,-0.152400><0.073539,0.035000,0.152400> rotate<0,44.997030,0> translate<42.620000,-1.535000,38.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,38.354000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,38.608000>}
box{<0,0,-0.152400><0.254000,0.035000,0.152400> rotate<0,90.000000,0> translate<42.672000,-1.535000,38.608000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.628000,-1.535000,39.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,39.116000>}
box{<0,0,-0.152400><0.062225,0.035000,0.152400> rotate<0,44.997030,0> translate<42.628000,-1.535000,39.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,38.608000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,39.116000>}
box{<0,0,-0.152400><0.508000,0.035000,0.152400> rotate<0,90.000000,0> translate<42.672000,-1.535000,39.116000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.636000,-1.535000,39.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,39.624000>}
box{<0,0,-0.152400><0.050912,0.035000,0.152400> rotate<0,44.997030,0> translate<42.636000,-1.535000,39.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,39.116000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,39.624000>}
box{<0,0,-0.152400><0.508000,0.035000,0.152400> rotate<0,90.000000,0> translate<42.672000,-1.535000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.660000,-1.535000,41.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,41.148000>}
box{<0,0,-0.152400><0.016971,0.035000,0.152400> rotate<0,44.997030,0> translate<42.660000,-1.535000,41.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,41.148000>}
box{<0,0,-0.152400><1.524000,0.035000,0.152400> rotate<0,90.000000,0> translate<42.672000,-1.535000,41.148000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.668000,-1.535000,41.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,41.656000>}
box{<0,0,-0.152400><0.005657,0.035000,0.152400> rotate<0,44.997030,0> translate<42.668000,-1.535000,41.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,41.148000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,41.656000>}
box{<0,0,-0.152400><0.508000,0.035000,0.152400> rotate<0,90.000000,0> translate<42.672000,-1.535000,41.656000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.545000,-1.535000,41.656000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,41.783000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.545000,-1.535000,41.656000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,41.656000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,41.783000>}
box{<0,0,-0.152400><0.127000,0.035000,0.152400> rotate<0,90.000000,0> translate<42.672000,-1.535000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,43.688000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,41.783000>}
box{<0,0,-0.152400><1.905000,0.035000,0.152400> rotate<0,-90.000000,0> translate<42.672000,-1.535000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.644000,-1.535000,43.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,43.688000>}
box{<0,0,-0.152400><0.039598,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.644000,-1.535000,43.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.636000,-1.535000,44.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,44.196000>}
box{<0,0,-0.152400><0.050912,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.636000,-1.535000,44.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,43.688000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,44.196000>}
box{<0,0,-0.152400><0.508000,0.035000,0.152400> rotate<0,90.000000,0> translate<42.672000,-1.535000,44.196000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.628000,-1.535000,44.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,44.704000>}
box{<0,0,-0.152400><0.062225,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.628000,-1.535000,44.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,44.196000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,44.704000>}
box{<0,0,-0.152400><0.508000,0.035000,0.152400> rotate<0,90.000000,0> translate<42.672000,-1.535000,44.704000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.470000,-1.535000,45.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,44.958000>}
box{<0,0,-0.152400><0.285671,0.035000,0.152400> rotate<0,44.997030,0> translate<42.470000,-1.535000,45.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,44.704000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,44.958000>}
box{<0,0,-0.152400><0.254000,0.035000,0.152400> rotate<0,90.000000,0> translate<42.672000,-1.535000,44.958000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.465000,-1.535000,34.671000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.926000,-1.535000,34.671000>}
box{<0,0,-0.152400><5.461000,0.035000,0.152400> rotate<0,0.000000,0> translate<37.465000,-1.535000,34.671000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.470000,-1.535000,45.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.001000,-1.535000,45.160000>}
box{<0,0,-0.152400><0.531000,0.035000,0.152400> rotate<0,0.000000,0> translate<42.470000,-1.535000,45.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.640000,-1.535000,20.168000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,20.168000>}
box{<0,0,-0.152400><2.540000,0.035000,0.152400> rotate<0,0.000000,0> translate<40.640000,-1.535000,20.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,23.012000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,24.920000>}
box{<0,0,-0.152400><1.908000,0.035000,0.152400> rotate<0,90.000000,0> translate<43.180000,-1.535000,24.920000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,28.420000>}
box{<0,0,-0.152400><2.060000,0.035000,0.152400> rotate<0,-90.000000,0> translate<43.180000,-1.535000,28.420000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.926000,-1.535000,34.671000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.240000,-1.535000,34.985000>}
box{<0,0,-0.152400><0.444063,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.926000,-1.535000,34.671000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.240000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.240000,-1.535000,34.985000>}
box{<0,0,-0.152400><1.225000,0.035000,0.152400> rotate<0,-90.000000,0> translate<43.240000,-1.535000,34.985000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.240000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.240000,-1.535000,46.549000>}
box{<0,0,-0.152400><1.061000,0.035000,0.152400> rotate<0,-90.000000,0> translate<43.240000,-1.535000,46.549000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.307000,-1.535000,14.097000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<43.180000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.307000,-1.535000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.307000,-1.535000,14.097000>}
box{<0,0,-0.152400><3.048000,0.035000,0.152400> rotate<0,-90.000000,0> translate<43.307000,-1.535000,14.097000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.783000,-1.535000,18.669000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.307000,-1.535000,17.145000>}
box{<0,0,-0.152400><2.155261,0.035000,0.152400> rotate<0,44.997030,0> translate<41.783000,-1.535000,18.669000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.672000,-1.535000,38.354000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.307000,-1.535000,38.354000>}
box{<0,0,-0.152400><0.635000,0.035000,0.152400> rotate<0,0.000000,0> translate<42.672000,-1.535000,38.354000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.001000,-1.535000,45.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.307000,-1.535000,45.466000>}
box{<0,0,-0.152400><0.432749,0.035000,0.152400> rotate<0,-44.997030,0> translate<43.001000,-1.535000,45.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.307000,-1.535000,45.466000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.307000,-1.535000,46.228000>}
box{<0,0,-0.152400><0.762000,0.035000,0.152400> rotate<0,90.000000,0> translate<43.307000,-1.535000,46.228000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.240000,-1.535000,46.549000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.434000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.274357,0.035000,0.152400> rotate<0,44.997030,0> translate<43.240000,-1.535000,46.549000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.307000,-1.535000,46.228000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.434000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<43.307000,-1.535000,46.228000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.418000,-1.535000,49.784000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.434000,-1.535000,50.800000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.418000,-1.535000,49.784000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.688000,-1.535000,30.988000>}
box{<0,0,-0.152400><0.718420,0.035000,0.152400> rotate<0,-44.997030,0> translate<43.180000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.434000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.688000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.254000,0.035000,0.152400> rotate<0,0.000000,0> translate<43.434000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740000,-1.535000,37.263000>}
box{<0,0,-0.152400><1.053000,0.035000,0.152400> rotate<0,90.000000,0> translate<43.740000,-1.535000,37.263000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.688000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740000,-1.535000,46.407000>}
box{<0,0,-0.152400><0.073539,0.035000,0.152400> rotate<0,-44.997030,0> translate<43.688000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740000,-1.535000,46.407000>}
box{<0,0,-0.152400><1.203000,0.035000,0.152400> rotate<0,-90.000000,0> translate<43.740000,-1.535000,46.407000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.307000,-1.535000,38.354000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.069000,-1.535000,37.592000>}
box{<0,0,-0.152400><1.077631,0.035000,0.152400> rotate<0,44.997030,0> translate<43.307000,-1.535000,38.354000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740000,-1.535000,37.263000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.069000,-1.535000,37.592000>}
box{<0,0,-0.152400><0.465276,0.035000,0.152400> rotate<0,-44.997030,0> translate<43.740000,-1.535000,37.263000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.243000,-1.535000,11.557000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.196000,-1.535000,11.557000>}
box{<0,0,-0.152400><4.953000,0.035000,0.152400> rotate<0,0.000000,0> translate<39.243000,-1.535000,11.557000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240000,-1.535000,37.382000>}
box{<0,0,-0.152400><1.172000,0.035000,0.152400> rotate<0,90.000000,0> translate<44.240000,-1.535000,37.382000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240000,-1.535000,46.438000>}
box{<0,0,-0.152400><1.172000,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.240000,-1.535000,46.438000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.180000,-1.535000,20.168000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.323000,-1.535000,20.168000>}
box{<0,0,-0.152400><1.143000,0.035000,0.152400> rotate<0,0.000000,0> translate<43.180000,-1.535000,20.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.688000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.323000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.635000,0.035000,0.152400> rotate<0,0.000000,0> translate<43.688000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240000,-1.535000,46.438000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.323000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.117380,0.035000,0.152400> rotate<0,44.997030,0> translate<44.240000,-1.535000,46.438000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.196000,-1.535000,11.557000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,11.811000>}
box{<0,0,-0.152400><0.359210,0.035000,0.152400> rotate<0,-44.997030,0> translate<44.196000,-1.535000,11.557000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,11.811000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,20.041000>}
box{<0,0,-0.152400><8.230000,0.035000,0.152400> rotate<0,90.000000,0> translate<44.450000,-1.535000,20.041000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.323000,-1.535000,20.168000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,20.295000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<44.323000,-1.535000,20.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,29.718000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,20.295000>}
box{<0,0,-0.152400><9.423000,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.450000,-1.535000,20.295000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.069000,-1.535000,37.592000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,37.592000>}
box{<0,0,-0.152400><0.381000,0.035000,0.152400> rotate<0,0.000000,0> translate<44.069000,-1.535000,37.592000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240000,-1.535000,37.382000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,37.592000>}
box{<0,0,-0.152400><0.296985,0.035000,0.152400> rotate<0,-44.997030,0> translate<44.240000,-1.535000,37.382000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,11.811000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.577000,-1.535000,11.684000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,44.997030,0> translate<44.450000,-1.535000,11.811000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.323000,-1.535000,20.168000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.577000,-1.535000,20.168000>}
box{<0,0,-0.152400><0.254000,0.035000,0.152400> rotate<0,0.000000,0> translate<44.323000,-1.535000,20.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,20.041000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.577000,-1.535000,20.168000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<44.450000,-1.535000,20.041000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,29.718000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.577000,-1.535000,29.845000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<44.450000,-1.535000,29.718000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740000,-1.535000,37.501000>}
box{<0,0,-0.152400><1.291000,0.035000,0.152400> rotate<0,90.000000,0> translate<44.740000,-1.535000,37.501000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740000,-1.535000,46.446000>}
box{<0,0,-0.152400><1.164000,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.740000,-1.535000,46.446000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.450000,-1.535000,37.592000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.831000,-1.535000,37.592000>}
box{<0,0,-0.152400><0.381000,0.035000,0.152400> rotate<0,0.000000,0> translate<44.450000,-1.535000,37.592000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740000,-1.535000,37.501000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.831000,-1.535000,37.592000>}
box{<0,0,-0.152400><0.128693,0.035000,0.152400> rotate<0,-44.997030,0> translate<44.740000,-1.535000,37.501000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.323000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.831000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.508000,0.035000,0.152400> rotate<0,0.000000,0> translate<44.323000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740000,-1.535000,46.446000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.831000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.128693,0.035000,0.152400> rotate<0,44.997030,0> translate<44.740000,-1.535000,46.446000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.831000,-1.535000,37.592000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.085000,-1.535000,37.592000>}
box{<0,0,-0.152400><0.254000,0.035000,0.152400> rotate<0,0.000000,0> translate<44.831000,-1.535000,37.592000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.831000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.212000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.381000,0.035000,0.152400> rotate<0,0.000000,0> translate<44.831000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.085000,-1.535000,37.592000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240000,-1.535000,37.437000>}
box{<0,0,-0.152400><0.219203,0.035000,0.152400> rotate<0,44.997030,0> translate<45.085000,-1.535000,37.592000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240000,-1.535000,37.437000>}
box{<0,0,-0.152400><1.227000,0.035000,0.152400> rotate<0,90.000000,0> translate<45.240000,-1.535000,37.437000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.212000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240000,-1.535000,46.383000>}
box{<0,0,-0.152400><0.039598,0.035000,0.152400> rotate<0,-44.997030,0> translate<45.212000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240000,-1.535000,46.383000>}
box{<0,0,-0.152400><1.227000,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.240000,-1.535000,46.383000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.719000,-1.535000,34.036000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.339000,-1.535000,34.036000>}
box{<0,0,-0.152400><7.620000,0.035000,0.152400> rotate<0,0.000000,0> translate<37.719000,-1.535000,34.036000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<37.973000,-1.535000,33.401000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.593000,-1.535000,33.401000>}
box{<0,0,-0.152400><7.620000,0.035000,0.152400> rotate<0,0.000000,0> translate<37.973000,-1.535000,33.401000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,13.970000>}
box{<0,0,-0.152400><2.286000,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.720000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.577000,-1.535000,20.168000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,20.168000>}
box{<0,0,-0.152400><1.143000,0.035000,0.152400> rotate<0,0.000000,0> translate<44.577000,-1.535000,20.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,23.012000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,24.920000>}
box{<0,0,-0.152400><1.908000,0.035000,0.152400> rotate<0,90.000000,0> translate<45.720000,-1.535000,24.920000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.243000,-1.535000,32.766000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,32.766000>}
box{<0,0,-0.152400><6.477000,0.035000,0.152400> rotate<0,0.000000,0> translate<39.243000,-1.535000,32.766000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.085000,-1.535000,37.592000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,37.592000>}
box{<0,0,-0.152400><0.635000,0.035000,0.152400> rotate<0,0.000000,0> translate<45.085000,-1.535000,37.592000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.212000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.508000,0.035000,0.152400> rotate<0,0.000000,0> translate<45.212000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.434000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,50.800000>}
box{<0,0,-0.152400><2.286000,0.035000,0.152400> rotate<0,0.000000,0> translate<43.434000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,53.594000>}
box{<0,0,-0.152400><2.794000,0.035000,0.152400> rotate<0,90.000000,0> translate<45.720000,-1.535000,53.594000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,53.594000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,54.610000>}
box{<0,0,-0.152400><1.016000,0.035000,0.152400> rotate<0,90.000000,0> translate<45.720000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,37.592000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740000,-1.535000,37.572000>}
box{<0,0,-0.152400><0.028284,0.035000,0.152400> rotate<0,44.997030,0> translate<45.720000,-1.535000,37.592000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740000,-1.535000,37.572000>}
box{<0,0,-0.152400><1.362000,0.035000,0.152400> rotate<0,90.000000,0> translate<45.740000,-1.535000,37.572000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740000,-1.535000,46.375000>}
box{<0,0,-0.152400><0.028284,0.035000,0.152400> rotate<0,-44.997030,0> translate<45.720000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740000,-1.535000,46.375000>}
box{<0,0,-0.152400><1.235000,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.740000,-1.535000,46.375000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.878000,-1.535000,32.131000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.974000,-1.535000,32.131000>}
box{<0,0,-0.152400><6.096000,0.035000,0.152400> rotate<0,0.000000,0> translate<39.878000,-1.535000,32.131000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,37.592000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.974000,-1.535000,37.592000>}
box{<0,0,-0.152400><0.254000,0.035000,0.152400> rotate<0,0.000000,0> translate<45.720000,-1.535000,37.592000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.228000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.508000,0.035000,0.152400> rotate<0,0.000000,0> translate<45.720000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.974000,-1.535000,37.592000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240000,-1.535000,37.326000>}
box{<0,0,-0.152400><0.376181,0.035000,0.152400> rotate<0,44.997030,0> translate<45.974000,-1.535000,37.592000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240000,-1.535000,37.326000>}
box{<0,0,-0.152400><1.116000,0.035000,0.152400> rotate<0,90.000000,0> translate<46.240000,-1.535000,37.326000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.228000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240000,-1.535000,46.367000>}
box{<0,0,-0.152400><0.016971,0.035000,0.152400> rotate<0,-44.997030,0> translate<46.228000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240000,-1.535000,46.367000>}
box{<0,0,-0.152400><1.243000,0.035000,0.152400> rotate<0,-90.000000,0> translate<46.240000,-1.535000,46.367000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240000,-1.535000,37.326000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.252000,-1.535000,37.338000>}
box{<0,0,-0.152400><0.016971,0.035000,0.152400> rotate<0,-44.997030,0> translate<46.240000,-1.535000,37.326000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,28.420000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.355000,-1.535000,29.055000>}
box{<0,0,-0.152400><0.898026,0.035000,0.152400> rotate<0,-44.997030,0> translate<45.720000,-1.535000,28.420000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.355000,-1.535000,29.083000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.355000,-1.535000,29.055000>}
box{<0,0,-0.152400><0.028000,0.035000,0.152400> rotate<0,-90.000000,0> translate<46.355000,-1.535000,29.055000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.577000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.355000,-1.535000,29.845000>}
box{<0,0,-0.152400><1.778000,0.035000,0.152400> rotate<0,0.000000,0> translate<44.577000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.656000,-1.535000,31.623000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.355000,-1.535000,31.623000>}
box{<0,0,-0.152400><4.699000,0.035000,0.152400> rotate<0,0.000000,0> translate<41.656000,-1.535000,31.623000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.688000,-1.535000,30.988000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.609000,-1.535000,30.988000>}
box{<0,0,-0.152400><2.921000,0.035000,0.152400> rotate<0,0.000000,0> translate<43.688000,-1.535000,30.988000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.339000,-1.535000,34.036000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740000,-1.535000,35.437000>}
box{<0,0,-0.152400><1.981313,0.035000,0.152400> rotate<0,-44.997030,0> translate<45.339000,-1.535000,34.036000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740000,-1.535000,35.437000>}
box{<0,0,-0.152400><0.773000,0.035000,0.152400> rotate<0,-90.000000,0> translate<46.740000,-1.535000,35.437000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740000,-1.535000,46.478000>}
box{<0,0,-0.152400><1.132000,0.035000,0.152400> rotate<0,-90.000000,0> translate<46.740000,-1.535000,46.478000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.228000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.863000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.635000,0.035000,0.152400> rotate<0,0.000000,0> translate<46.228000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740000,-1.535000,46.478000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.863000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.173948,0.035000,0.152400> rotate<0,44.997030,0> translate<46.740000,-1.535000,46.478000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.990000,-1.535000,55.880000>}
box{<0,0,-0.152400><1.796051,0.035000,0.152400> rotate<0,-44.997030,0> translate<45.720000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.117000,-1.535000,17.653000>}
box{<0,0,-0.152400><1.975656,0.035000,0.152400> rotate<0,-44.997030,0> translate<45.720000,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.863000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.117000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.254000,0.035000,0.152400> rotate<0,0.000000,0> translate<46.863000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.593000,-1.535000,33.401000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240000,-1.535000,35.048000>}
box{<0,0,-0.152400><2.329210,0.035000,0.152400> rotate<0,-44.997030,0> translate<45.593000,-1.535000,33.401000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240000,-1.535000,35.048000>}
box{<0,0,-0.152400><1.162000,0.035000,0.152400> rotate<0,-90.000000,0> translate<47.240000,-1.535000,35.048000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.117000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240000,-1.535000,46.478000>}
box{<0,0,-0.152400><0.173948,0.035000,0.152400> rotate<0,-44.997030,0> translate<47.117000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240000,-1.535000,46.478000>}
box{<0,0,-0.152400><1.132000,0.035000,0.152400> rotate<0,-90.000000,0> translate<47.240000,-1.535000,46.478000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.117000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.625000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.508000,0.035000,0.152400> rotate<0,0.000000,0> translate<47.117000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,32.766000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740000,-1.535000,34.786000>}
box{<0,0,-0.152400><2.856711,0.035000,0.152400> rotate<0,-44.997030,0> translate<45.720000,-1.535000,32.766000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740000,-1.535000,34.786000>}
box{<0,0,-0.152400><1.424000,0.035000,0.152400> rotate<0,-90.000000,0> translate<47.740000,-1.535000,34.786000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.625000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740000,-1.535000,46.470000>}
box{<0,0,-0.152400><0.162635,0.035000,0.152400> rotate<0,-44.997030,0> translate<47.625000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740000,-1.535000,46.470000>}
box{<0,0,-0.152400><1.140000,0.035000,0.152400> rotate<0,-90.000000,0> translate<47.740000,-1.535000,46.470000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740000,-1.535000,46.470000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.855000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.162635,0.035000,0.152400> rotate<0,44.997030,0> translate<47.740000,-1.535000,46.470000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.625000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.006000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.381000,0.035000,0.152400> rotate<0,0.000000,0> translate<47.625000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.974000,-1.535000,32.131000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.240000,-1.535000,34.397000>}
box{<0,0,-0.152400><3.204608,0.035000,0.152400> rotate<0,-44.997030,0> translate<45.974000,-1.535000,32.131000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.240000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.240000,-1.535000,34.397000>}
box{<0,0,-0.152400><1.813000,0.035000,0.152400> rotate<0,-90.000000,0> translate<48.240000,-1.535000,34.397000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.006000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.240000,-1.535000,46.589000>}
box{<0,0,-0.152400><0.330926,0.035000,0.152400> rotate<0,-44.997030,0> translate<48.006000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.240000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.240000,-1.535000,46.589000>}
box{<0,0,-0.152400><1.021000,0.035000,0.152400> rotate<0,-90.000000,0> translate<48.240000,-1.535000,46.589000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,-1.535000,13.970000>}
box{<0,0,-0.152400><2.286000,0.035000,0.152400> rotate<0,-90.000000,0> translate<48.260000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,20.168000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,-1.535000,20.168000>}
box{<0,0,-0.152400><2.540000,0.035000,0.152400> rotate<0,0.000000,0> translate<45.720000,-1.535000,20.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,-1.535000,23.012000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,-1.535000,24.920000>}
box{<0,0,-0.152400><1.908000,0.035000,0.152400> rotate<0,90.000000,0> translate<48.260000,-1.535000,24.920000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,-1.535000,29.972000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,-1.535000,28.420000>}
box{<0,0,-0.152400><1.552000,0.035000,0.152400> rotate<0,-90.000000,0> translate<48.260000,-1.535000,28.420000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.355000,-1.535000,31.623000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.740000,-1.535000,34.008000>}
box{<0,0,-0.152400><3.372899,0.035000,0.152400> rotate<0,-44.997030,0> translate<46.355000,-1.535000,31.623000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.740000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.740000,-1.535000,34.008000>}
box{<0,0,-0.152400><2.202000,0.035000,0.152400> rotate<0,-90.000000,0> translate<48.740000,-1.535000,34.008000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,-1.535000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.740000,-1.535000,50.320000>}
box{<0,0,-0.152400><0.678823,0.035000,0.152400> rotate<0,44.997030,0> translate<48.260000,-1.535000,50.800000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.740000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.740000,-1.535000,50.320000>}
box{<0,0,-0.152400><2.710000,0.035000,0.152400> rotate<0,90.000000,0> translate<48.740000,-1.535000,50.320000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.149000,-1.535000,17.145000>}
box{<0,0,-0.152400><1.257236,0.035000,0.152400> rotate<0,-44.997030,0> translate<48.260000,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.609000,-1.535000,30.988000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.240000,-1.535000,33.619000>}
box{<0,0,-0.152400><3.720796,0.035000,0.152400> rotate<0,-44.997030,0> translate<46.609000,-1.535000,30.988000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.240000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.240000,-1.535000,33.619000>}
box{<0,0,-0.152400><2.591000,0.035000,0.152400> rotate<0,-90.000000,0> translate<49.240000,-1.535000,33.619000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.240000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.240000,-1.535000,46.518000>}
box{<0,0,-0.152400><1.092000,0.035000,0.152400> rotate<0,-90.000000,0> translate<49.240000,-1.535000,46.518000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.990000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.276000,-1.535000,55.880000>}
box{<0,0,-0.152400><2.286000,0.035000,0.152400> rotate<0,0.000000,0> translate<46.990000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.855000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.403000,-1.535000,46.355000>}
box{<0,0,-0.152400><1.548000,0.035000,0.152400> rotate<0,0.000000,0> translate<47.855000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.240000,-1.535000,46.518000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.403000,-1.535000,46.355000>}
box{<0,0,-0.152400><0.230517,0.035000,0.152400> rotate<0,44.997030,0> translate<49.240000,-1.535000,46.518000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.276000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.403000,-1.535000,56.007000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.276000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.403000,-1.535000,56.007000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.403000,-1.535000,57.531000>}
box{<0,0,-0.152400><1.524000,0.035000,0.152400> rotate<0,90.000000,0> translate<49.403000,-1.535000,57.531000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.403000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.530000,-1.535000,46.228000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,44.997030,0> translate<49.403000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.355000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.740000,-1.535000,33.230000>}
box{<0,0,-0.152400><4.787113,0.035000,0.152400> rotate<0,-44.997030,0> translate<46.355000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.740000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.740000,-1.535000,33.230000>}
box{<0,0,-0.152400><2.980000,0.035000,0.152400> rotate<0,-90.000000,0> translate<49.740000,-1.535000,33.230000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.740000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.740000,-1.535000,46.272000>}
box{<0,0,-0.152400><1.338000,0.035000,0.152400> rotate<0,-90.000000,0> translate<49.740000,-1.535000,46.272000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.530000,-1.535000,46.228000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.784000,-1.535000,46.228000>}
box{<0,0,-0.152400><0.254000,0.035000,0.152400> rotate<0,0.000000,0> translate<49.530000,-1.535000,46.228000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.740000,-1.535000,46.272000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.784000,-1.535000,46.228000>}
box{<0,0,-0.152400><0.062225,0.035000,0.152400> rotate<0,44.997030,0> translate<49.740000,-1.535000,46.272000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.252000,-1.535000,37.338000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.038000,-1.535000,37.338000>}
box{<0,0,-0.152400><3.786000,0.035000,0.152400> rotate<0,0.000000,0> translate<46.252000,-1.535000,37.338000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.038000,-1.535000,37.338000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.240000,-1.535000,37.136000>}
box{<0,0,-0.152400><0.285671,0.035000,0.152400> rotate<0,44.997030,0> translate<50.038000,-1.535000,37.338000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.240000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.240000,-1.535000,37.136000>}
box{<0,0,-0.152400><0.926000,0.035000,0.152400> rotate<0,90.000000,0> translate<50.240000,-1.535000,37.136000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.784000,-1.535000,46.228000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.240000,-1.535000,46.684000>}
box{<0,0,-0.152400><0.644881,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.784000,-1.535000,46.228000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.240000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.240000,-1.535000,46.684000>}
box{<0,0,-0.152400><0.926000,0.035000,0.152400> rotate<0,-90.000000,0> translate<50.240000,-1.535000,46.684000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.240000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.240000,-1.535000,50.240000>}
box{<0,0,-0.152400><2.630000,0.035000,0.152400> rotate<0,90.000000,0> translate<50.240000,-1.535000,50.240000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.403000,-1.535000,57.531000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.419000,-1.535000,58.547000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.403000,-1.535000,57.531000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.530000,-1.535000,46.228000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.598000,-1.535000,45.160000>}
box{<0,0,-0.152400><1.510380,0.035000,0.152400> rotate<0,44.997030,0> translate<49.530000,-1.535000,46.228000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.355000,-1.535000,29.083000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.740000,-1.535000,33.468000>}
box{<0,0,-0.152400><6.201326,0.035000,0.152400> rotate<0,-44.997030,0> translate<46.355000,-1.535000,29.083000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.740000,-1.535000,36.210000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.740000,-1.535000,33.468000>}
box{<0,0,-0.152400><2.742000,0.035000,0.152400> rotate<0,-90.000000,0> translate<50.740000,-1.535000,33.468000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.740000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.740000,-1.535000,48.327000>}
box{<0,0,-0.152400><0.717000,0.035000,0.152400> rotate<0,90.000000,0> translate<50.740000,-1.535000,48.327000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,13.970000>}
box{<0,0,-0.152400><2.032000,0.035000,0.152400> rotate<0,-90.000000,0> translate<50.800000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,-1.535000,20.168000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,20.168000>}
box{<0,0,-0.152400><2.540000,0.035000,0.152400> rotate<0,0.000000,0> translate<48.260000,-1.535000,20.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,23.012000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,24.920000>}
box{<0,0,-0.152400><1.908000,0.035000,0.152400> rotate<0,90.000000,0> translate<50.800000,-1.535000,24.920000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,30.226000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,28.420000>}
box{<0,0,-0.152400><1.806000,0.035000,0.152400> rotate<0,-90.000000,0> translate<50.800000,-1.535000,28.420000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.740000,-1.535000,47.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,47.550000>}
box{<0,0,-0.152400><0.084853,0.035000,0.152400> rotate<0,44.997030,0> translate<50.740000,-1.535000,47.610000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,45.974000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,47.550000>}
box{<0,0,-0.152400><1.576000,0.035000,0.152400> rotate<0,90.000000,0> translate<50.800000,-1.535000,47.550000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.740000,-1.535000,48.327000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,48.387000>}
box{<0,0,-0.152400><0.084853,0.035000,0.152400> rotate<0,-44.997030,0> translate<50.740000,-1.535000,48.327000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,47.550000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,48.387000>}
box{<0,0,-0.152400><0.837000,0.035000,0.152400> rotate<0,90.000000,0> translate<50.800000,-1.535000,48.387000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.240000,-1.535000,50.240000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,50.800000>}
box{<0,0,-0.152400><0.791960,0.035000,0.152400> rotate<0,-44.997030,0> translate<50.240000,-1.535000,50.240000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,45.974000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.114000,-1.535000,45.660000>}
box{<0,0,-0.152400><0.444063,0.035000,0.152400> rotate<0,44.997030,0> translate<50.800000,-1.535000,45.974000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.308000,-1.535000,16.510000>}
box{<0,0,-0.152400><0.718420,0.035000,0.152400> rotate<0,-44.997030,0> translate<50.800000,-1.535000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,48.387000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.308000,-1.535000,48.895000>}
box{<0,0,-0.152400><0.718420,0.035000,0.152400> rotate<0,-44.997030,0> translate<50.800000,-1.535000,48.387000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.720000,-1.535000,53.594000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.308000,-1.535000,53.594000>}
box{<0,0,-0.152400><5.588000,0.035000,0.152400> rotate<0,0.000000,0> translate<45.720000,-1.535000,53.594000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.598000,-1.535000,45.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.435000,-1.535000,45.160000>}
box{<0,0,-0.152400><0.837000,0.035000,0.152400> rotate<0,0.000000,0> translate<50.598000,-1.535000,45.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.435000,-1.535000,40.513000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.435000,-1.535000,45.160000>}
box{<0,0,-0.152400><4.647000,0.035000,0.152400> rotate<0,90.000000,0> translate<51.435000,-1.535000,45.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.435000,-1.535000,40.513000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.788000,-1.535000,40.160000>}
box{<0,0,-0.152400><0.499217,0.035000,0.152400> rotate<0,44.997030,0> translate<51.435000,-1.535000,40.513000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.308000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.070000,-1.535000,48.895000>}
box{<0,0,-0.152400><0.762000,0.035000,0.152400> rotate<0,0.000000,0> translate<51.308000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.788000,-1.535000,40.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,40.160000>}
box{<0,0,-0.152400><0.902000,0.035000,0.152400> rotate<0,0.000000,0> translate<51.788000,-1.535000,40.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.435000,-1.535000,45.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,45.160000>}
box{<0,0,-0.152400><1.255000,0.035000,0.152400> rotate<0,0.000000,0> translate<51.435000,-1.535000,45.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.114000,-1.535000,45.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,45.660000>}
box{<0,0,-0.152400><1.576000,0.035000,0.152400> rotate<0,0.000000,0> translate<51.114000,-1.535000,45.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.070000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.832000,-1.535000,49.657000>}
box{<0,0,-0.152400><1.077631,0.035000,0.152400> rotate<0,-44.997030,0> translate<52.070000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.308000,-1.535000,53.594000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.832000,-1.535000,52.070000>}
box{<0,0,-0.152400><2.155261,0.035000,0.152400> rotate<0,44.997030,0> translate<51.308000,-1.535000,53.594000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.832000,-1.535000,49.657000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.832000,-1.535000,52.070000>}
box{<0,0,-0.152400><2.413000,0.035000,0.152400> rotate<0,90.000000,0> translate<52.832000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.213000,-1.535000,15.494000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.213000,-1.535000,14.097000>}
box{<0,0,-0.152400><1.397000,0.035000,0.152400> rotate<0,-90.000000,0> translate<53.213000,-1.535000,14.097000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.213000,-1.535000,14.097000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.340000,-1.535000,13.970000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,44.997030,0> translate<53.213000,-1.535000,14.097000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,20.168000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.340000,-1.535000,20.168000>}
box{<0,0,-0.152400><2.540000,0.035000,0.152400> rotate<0,0.000000,0> translate<50.800000,-1.535000,20.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.340000,-1.535000,23.012000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.340000,-1.535000,24.920000>}
box{<0,0,-0.152400><1.908000,0.035000,0.152400> rotate<0,90.000000,0> translate<53.340000,-1.535000,24.920000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.340000,-1.535000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.340000,-1.535000,28.420000>}
box{<0,0,-0.152400><1.044000,0.035000,0.152400> rotate<0,-90.000000,0> translate<53.340000,-1.535000,28.420000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.340000,-1.535000,20.168000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.365000,-1.535000,20.193000>}
box{<0,0,-0.152400><0.035355,0.035000,0.152400> rotate<0,-44.997030,0> translate<53.340000,-1.535000,20.168000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,38.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.407000,-1.535000,38.160000>}
box{<0,0,-0.152400><0.717000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,38.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.213000,-1.535000,15.494000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.594000,-1.535000,15.875000>}
box{<0,0,-0.152400><0.538815,0.035000,0.152400> rotate<0,-44.997030,0> translate<53.213000,-1.535000,15.494000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,38.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.796000,-1.535000,38.660000>}
box{<0,0,-0.152400><1.106000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,38.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.260000,-1.535000,29.972000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.848000,-1.535000,35.560000>}
box{<0,0,-0.152400><7.902625,0.035000,0.152400> rotate<0,-44.997030,0> translate<48.260000,-1.535000,29.972000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.848000,-1.535000,37.719000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.848000,-1.535000,35.560000>}
box{<0,0,-0.152400><2.159000,0.035000,0.152400> rotate<0,-90.000000,0> translate<53.848000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.407000,-1.535000,38.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.848000,-1.535000,37.719000>}
box{<0,0,-0.152400><0.623668,0.035000,0.152400> rotate<0,44.997030,0> translate<53.407000,-1.535000,38.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.993800,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.102000,-1.535000,55.880000>}
box{<0,0,-0.152400><2.108200,0.035000,0.152400> rotate<0,0.000000,0> translate<51.993800,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.102000,-1.535000,54.991000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.102000,-1.535000,55.880000>}
box{<0,0,-0.152400><0.889000,0.035000,0.152400> rotate<0,90.000000,0> translate<54.102000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,39.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.185000,-1.535000,39.160000>}
box{<0,0,-0.152400><1.495000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,39.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.577000,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.229000,-1.535000,11.684000>}
box{<0,0,-0.152400><9.652000,0.035000,0.152400> rotate<0,0.000000,0> translate<44.577000,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.117000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.229000,-1.535000,17.653000>}
box{<0,0,-0.152400><7.112000,0.035000,0.152400> rotate<0,0.000000,0> translate<47.117000,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.365000,-1.535000,20.193000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.229000,-1.535000,20.193000>}
box{<0,0,-0.152400><0.864000,0.035000,0.152400> rotate<0,0.000000,0> translate<53.365000,-1.535000,20.193000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,40.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.336000,-1.535000,40.660000>}
box{<0,0,-0.152400><1.646000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,40.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,45.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.431000,-1.535000,45.160000>}
box{<0,0,-0.152400><1.741000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,45.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.149000,-1.535000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.483000,-1.535000,17.145000>}
box{<0,0,-0.152400><5.334000,0.035000,0.152400> rotate<0,0.000000,0> translate<49.149000,-1.535000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.800000,-1.535000,30.226000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.483000,-1.535000,33.909000>}
box{<0,0,-0.152400><5.208549,0.035000,0.152400> rotate<0,-44.997030,0> translate<50.800000,-1.535000,30.226000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.483000,-1.535000,37.973000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.483000,-1.535000,33.909000>}
box{<0,0,-0.152400><4.064000,0.035000,0.152400> rotate<0,-90.000000,0> translate<54.483000,-1.535000,33.909000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.796000,-1.535000,38.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.483000,-1.535000,37.973000>}
box{<0,0,-0.152400><0.971565,0.035000,0.152400> rotate<0,44.997030,0> translate<53.796000,-1.535000,38.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,39.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.574000,-1.535000,39.660000>}
box{<0,0,-0.152400><1.884000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,39.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,41.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.598000,-1.535000,41.160000>}
box{<0,0,-0.152400><1.908000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,41.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.512000,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.610000,-1.535000,10.668000>}
box{<0,0,-0.152400><22.098000,0.035000,0.152400> rotate<0,0.000000,0> translate<32.512000,-1.535000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.102000,-1.535000,54.991000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.610000,-1.535000,54.483000>}
box{<0,0,-0.152400><0.718420,0.035000,0.152400> rotate<0,44.997030,0> translate<54.102000,-1.535000,54.991000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,41.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.860000,-1.535000,41.660000>}
box{<0,0,-0.152400><2.170000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,41.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.308000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.864000,-1.535000,16.510000>}
box{<0,0,-0.152400><3.556000,0.035000,0.152400> rotate<0,0.000000,0> translate<51.308000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.610000,-1.535000,54.483000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.864000,-1.535000,54.483000>}
box{<0,0,-0.152400><0.254000,0.035000,0.152400> rotate<0,0.000000,0> translate<54.610000,-1.535000,54.483000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.864000,0.000000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.864000,0.000000,54.483000>}
box{<0,0,-0.152400><5.842000,0.035000,0.152400> rotate<0,-90.000000,0> translate<54.864000,0.000000,54.483000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.418000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.864000,-1.535000,60.325000>}
box{<0,0,-0.152400><12.446000,0.035000,0.152400> rotate<0,0.000000,0> translate<42.418000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,44.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.947000,-1.535000,44.660000>}
box{<0,0,-0.152400><2.257000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,44.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.594000,-1.535000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.118000,-1.535000,15.875000>}
box{<0,0,-0.152400><1.524000,0.035000,0.152400> rotate<0,0.000000,0> translate<53.594000,-1.535000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.340000,-1.535000,29.464000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.118000,-1.535000,31.242000>}
box{<0,0,-0.152400><2.514472,0.035000,0.152400> rotate<0,-44.997030,0> translate<53.340000,-1.535000,29.464000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.118000,-1.535000,38.227000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.118000,-1.535000,31.242000>}
box{<0,0,-0.152400><6.985000,0.035000,0.152400> rotate<0,-90.000000,0> translate<55.118000,-1.535000,31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.185000,-1.535000,39.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.118000,-1.535000,38.227000>}
box{<0,0,-0.152400><1.319461,0.035000,0.152400> rotate<0,44.997030,0> translate<54.185000,-1.535000,39.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,42.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.122000,-1.535000,42.160000>}
box{<0,0,-0.152400><2.432000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,42.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,44.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.336000,-1.535000,44.160000>}
box{<0,0,-0.152400><2.646000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,44.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.229000,-1.535000,20.193000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.626000,-1.535000,21.590000>}
box{<0,0,-0.152400><1.975656,0.035000,0.152400> rotate<0,-44.997030,0> translate<54.229000,-1.535000,20.193000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.626000,-1.535000,38.608000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.626000,-1.535000,21.590000>}
box{<0,0,-0.152400><17.018000,0.035000,0.152400> rotate<0,-90.000000,0> translate<55.626000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.574000,-1.535000,39.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.626000,-1.535000,38.608000>}
box{<0,0,-0.152400><1.487753,0.035000,0.152400> rotate<0,44.997030,0> translate<54.574000,-1.535000,39.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.229000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.261000,-1.535000,19.685000>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,-44.997030,0> translate<54.229000,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.261000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.261000,-1.535000,19.685000>}
box{<0,0,-0.152400><19.050000,0.035000,0.152400> rotate<0,-90.000000,0> translate<56.261000,-1.535000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.336000,-1.535000,40.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.261000,-1.535000,38.735000>}
box{<0,0,-0.152400><2.722361,0.035000,0.152400> rotate<0,44.997030,0> translate<54.336000,-1.535000,40.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.431000,-1.535000,45.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.515000,-1.535000,47.244000>}
box{<0,0,-0.152400><2.947221,0.035000,0.152400> rotate<0,-44.997030,0> translate<54.431000,-1.535000,45.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.515000,-1.535000,47.244000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.515000,-1.535000,55.499000>}
box{<0,0,-0.152400><8.255000,0.035000,0.152400> rotate<0,90.000000,0> translate<56.515000,-1.535000,55.499000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.102000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.515000,-1.535000,55.880000>}
box{<0,0,-0.152400><2.413000,0.035000,0.152400> rotate<0,0.000000,0> translate<54.102000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.515000,-1.535000,55.499000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.705500,-1.535000,55.689500>}
box{<0,0,-0.152400><0.269408,0.035000,0.152400> rotate<0,-44.997030,0> translate<56.515000,-1.535000,55.499000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.515000,-1.535000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.705500,-1.535000,55.689500>}
box{<0,0,-0.152400><0.269408,0.035000,0.152400> rotate<0,44.997030,0> translate<56.515000,-1.535000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,43.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.741000,-1.535000,43.660000>}
box{<0,0,-0.152400><4.051000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,43.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.483000,-1.535000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.896000,-1.535000,19.558000>}
box{<0,0,-0.152400><3.412497,0.035000,0.152400> rotate<0,-44.997030,0> translate<54.483000,-1.535000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.896000,-1.535000,38.862000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.896000,-1.535000,19.558000>}
box{<0,0,-0.152400><19.304000,0.035000,0.152400> rotate<0,-90.000000,0> translate<56.896000,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.598000,-1.535000,41.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.896000,-1.535000,38.862000>}
box{<0,0,-0.152400><3.249863,0.035000,0.152400> rotate<0,44.997030,0> translate<54.598000,-1.535000,41.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.947000,-1.535000,44.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.404000,-1.535000,47.117000>}
box{<0,0,-0.152400><3.474723,0.035000,0.152400> rotate<0,-44.997030,0> translate<54.947000,-1.535000,44.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.404000,-1.535000,47.117000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.404000,-1.535000,52.324000>}
box{<0,0,-0.152400><5.207000,0.035000,0.152400> rotate<0,90.000000,0> translate<57.404000,-1.535000,52.324000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.864000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.531000,-1.535000,19.177000>}
box{<0,0,-0.152400><3.771708,0.035000,0.152400> rotate<0,-44.997030,0> translate<54.864000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.531000,-1.535000,38.989000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.531000,-1.535000,19.177000>}
box{<0,0,-0.152400><19.812000,0.035000,0.152400> rotate<0,-90.000000,0> translate<57.531000,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.860000,-1.535000,41.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.531000,-1.535000,38.989000>}
box{<0,0,-0.152400><3.777364,0.035000,0.152400> rotate<0,44.997030,0> translate<54.860000,-1.535000,41.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.705500,-1.535000,55.689500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.658000,-1.535000,56.642000>}
box{<0,0,-0.152400><1.347038,0.035000,0.152400> rotate<0,-44.997030,0> translate<56.705500,-1.535000,55.689500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,42.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.797000,-1.535000,42.660000>}
box{<0,0,-0.152400><5.107000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,42.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.118000,-1.535000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.166000,-1.535000,18.923000>}
box{<0,0,-0.152400><4.310523,0.035000,0.152400> rotate<0,-44.997030,0> translate<55.118000,-1.535000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.166000,-1.535000,39.116000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.166000,-1.535000,18.923000>}
box{<0,0,-0.152400><20.193000,0.035000,0.152400> rotate<0,-90.000000,0> translate<58.166000,-1.535000,18.923000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.122000,-1.535000,42.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.166000,-1.535000,39.116000>}
box{<0,0,-0.152400><4.304866,0.035000,0.152400> rotate<0,44.997030,0> translate<55.122000,-1.535000,42.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.336000,-1.535000,44.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.293000,-1.535000,47.117000>}
box{<0,0,-0.152400><4.181830,0.035000,0.152400> rotate<0,-44.997030,0> translate<55.336000,-1.535000,44.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.293000,-1.535000,47.117000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.293000,-1.535000,50.673000>}
box{<0,0,-0.152400><3.556000,0.035000,0.152400> rotate<0,90.000000,0> translate<58.293000,-1.535000,50.673000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.229000,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.801000,-1.535000,16.256000>}
box{<0,0,-0.152400><6.465784,0.035000,0.152400> rotate<0,-44.997030,0> translate<54.229000,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.801000,-1.535000,38.608000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.801000,-1.535000,16.256000>}
box{<0,0,-0.152400><22.352000,0.035000,0.152400> rotate<0,-90.000000,0> translate<58.801000,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.610000,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.436000,-1.535000,15.494000>}
box{<0,0,-0.152400><6.824995,0.035000,0.152400> rotate<0,-44.997030,0> translate<54.610000,-1.535000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.436000,-1.535000,15.494000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.436000,-1.535000,37.211000>}
box{<0,0,-0.152400><21.717000,0.035000,0.152400> rotate<0,90.000000,0> translate<59.436000,-1.535000,37.211000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.690000,-1.535000,43.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.543000,-1.535000,43.160000>}
box{<0,0,-0.152400><6.853000,0.035000,0.152400> rotate<0,0.000000,0> translate<52.690000,-1.535000,43.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,43.307000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,42.545000>}
box{<0,0,-0.152400><0.762000,0.035000,0.152400> rotate<0,-90.000000,0> translate<59.690000,-1.535000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.543000,-1.535000,43.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,43.307000>}
box{<0,0,-0.152400><0.207889,0.035000,0.152400> rotate<0,-44.997030,0> translate<59.543000,-1.535000,43.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.741000,-1.535000,43.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,46.609000>}
box{<0,0,-0.152400><4.170516,0.035000,0.152400> rotate<0,-44.997030,0> translate<56.741000,-1.535000,43.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,46.609000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,48.133000>}
box{<0,0,-0.152400><1.524000,0.035000,0.152400> rotate<0,90.000000,0> translate<59.690000,-1.535000,48.133000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,48.133000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,48.641000>}
box{<0,0,-0.152400><0.508000,0.035000,0.152400> rotate<0,90.000000,0> translate<59.690000,-1.535000,48.641000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.293000,-1.535000,50.673000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,52.070000>}
box{<0,0,-0.152400><1.975656,0.035000,0.152400> rotate<0,-44.997030,0> translate<58.293000,-1.535000,50.673000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.404000,-1.535000,52.324000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,54.610000>}
box{<0,0,-0.152400><3.232892,0.035000,0.152400> rotate<0,-44.997030,0> translate<57.404000,-1.535000,52.324000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.801000,-1.535000,38.608000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.817000,-1.535000,38.608000>}
box{<0,0,-0.152400><1.016000,0.035000,0.152400> rotate<0,0.000000,0> translate<58.801000,-1.535000,38.608000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.817000,-1.535000,38.608000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.944000,-1.535000,38.735000>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<59.817000,-1.535000,38.608000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.944000,-1.535000,40.513000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.944000,-1.535000,38.735000>}
box{<0,0,-0.152400><1.778000,0.035000,0.152400> rotate<0,-90.000000,0> translate<59.944000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.797000,-1.535000,42.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.944000,-1.535000,40.513000>}
box{<0,0,-0.152400><3.036317,0.035000,0.152400> rotate<0,44.997030,0> translate<57.797000,-1.535000,42.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.436000,-1.535000,37.211000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.071000,-1.535000,37.846000>}
box{<0,0,-0.152400><0.898026,0.035000,0.152400> rotate<0,-44.997030,0> translate<59.436000,-1.535000,37.211000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.452000,-1.535000,41.783000>}
box{<0,0,-0.152400><1.077631,0.035000,0.152400> rotate<0,44.997030,0> translate<59.690000,-1.535000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,48.641000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.706000,-1.535000,49.657000>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<59.690000,-1.535000,48.641000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.100000,-1.535000,52.070000>}
box{<0,0,-0.152400><2.410000,0.035000,0.152400> rotate<0,0.000000,0> translate<59.690000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.690000,-1.535000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.100000,-1.535000,54.610000>}
box{<0,0,-0.152400><2.410000,0.035000,0.152400> rotate<0,0.000000,0> translate<59.690000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.452000,-1.535000,41.783000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.497000,-1.535000,41.783000>}
box{<0,0,-0.152400><3.045000,0.035000,0.152400> rotate<0,0.000000,0> translate<60.452000,-1.535000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.706000,-1.535000,49.657000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.497000,-1.535000,49.657000>}
box{<0,0,-0.152400><2.791000,0.035000,0.152400> rotate<0,0.000000,0> translate<60.706000,-1.535000,49.657000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.497000,-1.535000,41.783000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.500000,-1.535000,41.780000>}
box{<0,0,-0.152400><0.004243,0.035000,0.152400> rotate<0,44.997030,0> translate<63.497000,-1.535000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.500000,-1.535000,44.580000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.500000,-1.535000,46.860000>}
box{<0,0,-0.152400><2.280000,0.035000,0.152400> rotate<0,90.000000,0> translate<63.500000,-1.535000,46.860000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.497000,-1.535000,49.657000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.500000,-1.535000,49.660000>}
box{<0,0,-0.152400><0.004243,0.035000,0.152400> rotate<0,-44.997030,0> translate<63.497000,-1.535000,49.657000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.817000,-1.535000,38.608000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.135000,-1.535000,38.608000>}
box{<0,0,-0.152400><4.318000,0.035000,0.152400> rotate<0,0.000000,0> translate<59.817000,-1.535000,38.608000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.658000,-1.535000,56.642000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.262000,-1.535000,56.642000>}
box{<0,0,-0.152400><6.604000,0.035000,0.152400> rotate<0,0.000000,0> translate<57.658000,-1.535000,56.642000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.071000,-1.535000,37.846000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.770000,-1.535000,37.846000>}
box{<0,0,-0.152400><4.699000,0.035000,0.152400> rotate<0,0.000000,0> translate<60.071000,-1.535000,37.846000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.419000,-1.535000,58.547000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.770000,-1.535000,58.547000>}
box{<0,0,-0.152400><14.351000,0.035000,0.152400> rotate<0,0.000000,0> translate<50.419000,-1.535000,58.547000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.897000,-1.535000,56.007000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.897000,-1.535000,54.613000>}
box{<0,0,-0.152400><1.394000,0.035000,0.152400> rotate<0,-90.000000,0> translate<64.897000,-1.535000,54.613000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.262000,-1.535000,56.642000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.897000,-1.535000,56.007000>}
box{<0,0,-0.152400><0.898026,0.035000,0.152400> rotate<0,44.997030,0> translate<64.262000,-1.535000,56.642000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.897000,-1.535000,54.613000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.900000,-1.535000,54.610000>}
box{<0,0,-0.152400><0.004243,0.035000,0.152400> rotate<0,44.997030,0> translate<64.897000,-1.535000,54.613000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.900000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.900000,-1.535000,54.610000>}
box{<0,0,-0.152400><2.540000,0.035000,0.152400> rotate<0,90.000000,0> translate<64.900000,-1.535000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.500000,-1.535000,46.860000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.148000,-1.535000,46.860000>}
box{<0,0,-0.152400><1.648000,0.035000,0.152400> rotate<0,0.000000,0> translate<63.500000,-1.535000,46.860000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.148000,-1.535000,46.860000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.913000,-1.535000,47.625000>}
box{<0,0,-0.152400><1.081873,0.035000,0.152400> rotate<0,-44.997030,0> translate<65.148000,-1.535000,46.860000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.900000,-1.535000,52.070000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.913000,-1.535000,51.057000>}
box{<0,0,-0.152400><1.432598,0.035000,0.152400> rotate<0,44.997030,0> translate<64.900000,-1.535000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.913000,-1.535000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.913000,-1.535000,51.057000>}
box{<0,0,-0.152400><3.432000,0.035000,0.152400> rotate<0,90.000000,0> translate<65.913000,-1.535000,51.057000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.864000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.913000,-1.535000,60.325000>}
box{<0,0,-0.152400><11.049000,0.035000,0.152400> rotate<0,0.000000,0> translate<54.864000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.135000,-1.535000,38.608000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.310000,-1.535000,41.783000>}
box{<0,0,-0.152400><4.490128,0.035000,0.152400> rotate<0,-44.997030,0> translate<64.135000,-1.535000,38.608000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.310000,-1.535000,56.007000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.310000,-1.535000,41.783000>}
box{<0,0,-0.152400><14.224000,0.035000,0.152400> rotate<0,-90.000000,0> translate<67.310000,-1.535000,41.783000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.770000,-1.535000,58.547000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.310000,-1.535000,56.007000>}
box{<0,0,-0.152400><3.592102,0.035000,0.152400> rotate<0,44.997030,0> translate<64.770000,-1.535000,58.547000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.770000,-1.535000,37.846000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.945000,-1.535000,41.021000>}
box{<0,0,-0.152400><4.490128,0.035000,0.152400> rotate<0,-44.997030,0> translate<64.770000,-1.535000,37.846000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.913000,-1.535000,60.325000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.945000,-1.535000,58.293000>}
box{<0,0,-0.152400><2.873682,0.035000,0.152400> rotate<0,44.997030,0> translate<65.913000,-1.535000,60.325000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.945000,-1.535000,41.021000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.945000,-1.535000,58.293000>}
box{<0,0,-0.152400><17.272000,0.035000,0.152400> rotate<0,90.000000,0> translate<67.945000,-1.535000,58.293000> }
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
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,10.947397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,39.635000>}
box{<0,0,-0.152400><28.687603,0.035000,0.152400> rotate<0,90.000000,0> translate<13.106397,-1.535000,39.635000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,10.947397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.463447,-1.535000,10.947397>}
box{<0,0,-0.152400><19.357050,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,10.947397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.438041,-1.535000,10.972800>}
box{<0,0,-0.152400><19.331644,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,11.277600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.133241,-1.535000,11.277600>}
box{<0,0,-0.152400><19.026844,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,11.277600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,11.582400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.828441,-1.535000,11.582400>}
box{<0,0,-0.152400><18.722044,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,11.582400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,11.887200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.523641,-1.535000,11.887200>}
box{<0,0,-0.152400><18.417244,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,11.887200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.218841,-1.535000,12.192000>}
box{<0,0,-0.152400><18.112444,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,12.496800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.914041,-1.535000,12.496800>}
box{<0,0,-0.152400><17.807644,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,12.496800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,12.801600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.609241,-1.535000,12.801600>}
box{<0,0,-0.152400><17.502844,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,12.801600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,13.106400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.304441,-1.535000,13.106400>}
box{<0,0,-0.152400><17.198044,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,13.106400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.999641,-1.535000,13.411200>}
box{<0,0,-0.152400><16.893244,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.694841,-1.535000,13.716000>}
box{<0,0,-0.152400><16.588444,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,14.020800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.390041,-1.535000,14.020800>}
box{<0,0,-0.152400><16.283644,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,14.020800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,14.325600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.085241,-1.535000,14.325600>}
box{<0,0,-0.152400><15.978844,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,14.325600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.801156,-1.535000,14.630400>}
box{<0,0,-0.152400><15.694759,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,14.935200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,14.935200>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,14.935200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,15.240000>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,15.544800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,15.544800>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,15.544800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,15.849600>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,16.154400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,16.154400>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,16.154400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,16.459200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,16.459200>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,16.459200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,16.764000>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,17.068800>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,17.373600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,17.373600>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,17.373600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,17.678400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,17.678400>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,17.678400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,17.983200>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,18.288000>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,18.592800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,18.592800>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,18.592800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,18.897600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,18.897600>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,18.897600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,19.202400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,19.202400>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,19.202400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,19.507200>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,19.812000>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,20.116800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,20.116800>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,20.116800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,20.421600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,20.421600>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,20.421600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,20.726400>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,21.031200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,21.031200>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,21.031200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,21.336000>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,21.640800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,21.640800>}
box{<0,0,-0.152400><15.570203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,21.640800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.450241,-1.535000,21.945600>}
box{<0,0,-0.152400><15.343844,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,22.250400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.145441,-1.535000,22.250400>}
box{<0,0,-0.152400><15.039044,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,22.250400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,22.555200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.840641,-1.535000,22.555200>}
box{<0,0,-0.152400><14.734244,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,22.555200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.535841,-1.535000,22.860000>}
box{<0,0,-0.152400><14.429444,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.231041,-1.535000,23.164800>}
box{<0,0,-0.152400><14.124644,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,23.469600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.926241,-1.535000,23.469600>}
box{<0,0,-0.152400><13.819844,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,23.469600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,23.774400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.621441,-1.535000,23.774400>}
box{<0,0,-0.152400><13.515044,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,23.774400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,24.079200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.316641,-1.535000,24.079200>}
box{<0,0,-0.152400><13.210244,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,24.079200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.011841,-1.535000,24.384000>}
box{<0,0,-0.152400><12.905444,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,24.688800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.707041,-1.535000,24.688800>}
box{<0,0,-0.152400><12.600644,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,24.688800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,24.993600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.402241,-1.535000,24.993600>}
box{<0,0,-0.152400><12.295844,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,24.993600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,25.298400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.097441,-1.535000,25.298400>}
box{<0,0,-0.152400><11.991044,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,25.298400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.792641,-1.535000,25.603200>}
box{<0,0,-0.152400><11.686244,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.568075,-1.535000,25.908000>}
box{<0,0,-0.152400><11.461678,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.485600,-1.535000,26.212800>}
box{<0,0,-0.152400><11.379203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,26.517600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.485600,-1.535000,26.517600>}
box{<0,0,-0.152400><11.379203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,26.517600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.485600,-1.535000,26.822400>}
box{<0,0,-0.152400><11.379203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,27.127200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.485600,-1.535000,27.127200>}
box{<0,0,-0.152400><11.379203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,27.127200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.393247,-1.535000,27.432000>}
box{<0,0,-0.152400><11.286850,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,27.736800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.942066,-1.535000,27.736800>}
box{<0,0,-0.152400><10.835669,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,27.736800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,28.041600>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,28.346400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,28.346400>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,28.346400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,28.651200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,28.651200>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,28.651200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,28.956000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,28.956000>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,28.956000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,29.260800>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,29.565600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,29.565600>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,29.565600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,29.870400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,29.870400>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,30.175200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.829209,-1.535000,30.175200>}
box{<0,0,-0.152400><10.722812,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,30.175200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,30.480000>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,30.784800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,30.784800>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,30.784800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,31.089600>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,31.089600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,31.394400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,31.394400>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,31.394400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,31.699200>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,32.004000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,32.004000>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,32.004000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,32.308800>}
box{<0,0,-0.152400><10.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,32.613600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.839731,-1.535000,32.613600>}
box{<0,0,-0.152400><10.733334,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,32.613600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,32.918400>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,33.223200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,33.223200>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,33.223200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,33.528000>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,33.832800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,33.832800>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,33.832800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,34.137600>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,34.442400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,34.442400>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,34.442400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,34.747200>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,35.052000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977247,-1.535000,35.052000>}
box{<0,0,-0.152400><10.870850,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,35.052000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,35.356800>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,35.661600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,35.661600>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,35.661600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,35.966400>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,36.271200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,36.271200>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,36.271200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,36.576000>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,36.880800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,36.880800>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,36.880800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,37.185600>}
box{<0,0,-0.152400><10.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,37.490400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.040375,-1.535000,37.490400>}
box{<0,0,-0.152400><10.933978,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,37.490400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.397613,-1.535000,37.795200>}
box{<0,0,-0.152400><11.291216,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.206000,-1.535000,38.100000>}
box{<0,0,-0.152400><15.099603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.206000,-1.535000,38.404800>}
box{<0,0,-0.152400><15.099603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,38.709600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.206000,-1.535000,38.709600>}
box{<0,0,-0.152400><15.099603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,38.709600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.206000,-1.535000,39.014400>}
box{<0,0,-0.152400><15.099603,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,39.319200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.220759,-1.535000,39.319200>}
box{<0,0,-0.152400><15.114362,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,39.319200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.382369,-1.535000,39.624000>}
box{<0,0,-0.152400><15.275972,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,39.635000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.673572,-1.535000,39.635000>}
box{<0,0,-0.152400><2.567175,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,39.635000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,52.058997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,60.419181>}
box{<0,0,-0.152400><8.360184,0.035000,0.152400> rotate<0,90.000000,0> translate<13.106397,-1.535000,60.419181> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,52.058997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.673572,-1.535000,52.058997>}
box{<0,0,-0.152400><2.567175,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,52.058997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,52.120800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,52.120800>}
box{<0,0,-0.152400><9.504403,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,52.120800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.644697,-1.535000,52.425600>}
box{<0,0,-0.152400><9.538300,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,52.730400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.833369,-1.535000,52.730400>}
box{<0,0,-0.152400><9.726972,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,52.730400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,53.035200>}
box{<0,0,-0.152400><9.855203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,53.340000>}
box{<0,0,-0.152400><9.855203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,53.644800>}
box{<0,0,-0.152400><9.855203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,53.949600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,53.949600>}
box{<0,0,-0.152400><9.855203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,53.949600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.001994,-1.535000,54.254400>}
box{<0,0,-0.152400><9.895597,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,54.559200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.167044,-1.535000,54.559200>}
box{<0,0,-0.152400><10.060647,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,54.559200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.471844,-1.535000,54.864000>}
box{<0,0,-0.152400><10.365447,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,55.168800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.776644,-1.535000,55.168800>}
box{<0,0,-0.152400><10.670247,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,55.168800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.081444,-1.535000,55.473600>}
box{<0,0,-0.152400><10.975047,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,55.778400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.386244,-1.535000,55.778400>}
box{<0,0,-0.152400><11.279847,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,55.778400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.691044,-1.535000,56.083200>}
box{<0,0,-0.152400><11.584647,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,56.388000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.995844,-1.535000,56.388000>}
box{<0,0,-0.152400><11.889447,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,56.388000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.353838,-1.535000,56.692800>}
box{<0,0,-0.152400><12.247441,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,56.997600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.233600,-1.535000,56.997600>}
box{<0,0,-0.152400><27.127203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,56.997600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.268059,-1.535000,57.302400>}
box{<0,0,-0.152400><27.161662,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,57.607200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.394309,-1.535000,57.607200>}
box{<0,0,-0.152400><27.287912,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,57.607200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.549050,-1.535000,57.912000>}
box{<0,0,-0.152400><27.442653,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,58.216800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.853850,-1.535000,58.216800>}
box{<0,0,-0.152400><27.747453,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,58.216800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.392309,-1.535000,58.521600>}
box{<0,0,-0.152400><28.285913,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,58.826400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.405244,-1.535000,58.826400>}
box{<0,0,-0.152400><36.298847,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,58.826400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.710044,-1.535000,59.131200>}
box{<0,0,-0.152400><36.603647,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,59.436000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.175800,-1.535000,59.436000>}
box{<0,0,-0.152400><37.069403,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,59.436000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,59.740800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,59.740800>}
box{<0,0,-0.152400><55.118203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,59.740800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,60.045600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,60.045600>}
box{<0,0,-0.152400><55.118203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,60.045600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,60.350400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,60.350400>}
box{<0,0,-0.152400><55.118203,0.035000,0.152400> rotate<0,0.000000,0> translate<13.106397,-1.535000,60.350400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<13.106397,-1.535000,60.419181>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,60.541016>}
box{<0,0,-0.152400><55.118338,0.035000,0.152400> rotate<0,-0.126639,0> translate<13.106397,-1.535000,60.419181> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.673572,-1.535000,39.635000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.953638,-1.535000,39.751006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<15.673572,-1.535000,39.635000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.673572,-1.535000,52.058997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.953638,-1.535000,51.942991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<15.673572,-1.535000,52.058997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.953638,-1.535000,39.751006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.167991,-1.535000,39.965359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<15.953638,-1.535000,39.751006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<15.953638,-1.535000,51.942991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.167991,-1.535000,51.728638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<15.953638,-1.535000,51.942991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.080628,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.963369,-1.535000,51.816000>}
box{<0,0,-0.152400><1.882741,0.035000,0.152400> rotate<0,0.000000,0> translate<16.080628,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.131431,-1.535000,39.928800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.912566,-1.535000,39.928800>}
box{<0,0,-0.152400><1.781134,0.035000,0.152400> rotate<0,0.000000,0> translate<16.131431,-1.535000,39.928800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.167991,-1.535000,39.965359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,40.245425>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<16.167991,-1.535000,39.965359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.167991,-1.535000,51.728638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,51.448572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<16.167991,-1.535000,51.728638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.258056,-1.535000,51.511200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.785944,-1.535000,51.511200>}
box{<0,0,-0.152400><1.527888,0.035000,0.152400> rotate<0,0.000000,0> translate<16.258056,-1.535000,51.511200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.279097,-1.535000,40.233600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.764897,-1.535000,40.233600>}
box{<0,0,-0.152400><1.485800,0.035000,0.152400> rotate<0,0.000000,0> translate<16.279097,-1.535000,40.233600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,40.245425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,42.346244>}
box{<0,0,-0.152400><2.100819,0.035000,0.152400> rotate<0,90.000000,0> translate<16.283997,-1.535000,42.346244> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,40.538400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,40.538400>}
box{<0,0,-0.152400><1.476003,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,40.538400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,40.843200>}
box{<0,0,-0.152400><1.476003,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,41.148000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,41.148000>}
box{<0,0,-0.152400><1.476003,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,41.148000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,41.452800>}
box{<0,0,-0.152400><1.476003,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,41.757600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,41.757600>}
box{<0,0,-0.152400><1.476003,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,41.757600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.868478,-1.535000,42.062400>}
box{<0,0,-0.152400><0.584481,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,42.346244>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.355250,-1.535000,42.274988>}
box{<0,0,-0.152400><0.100769,0.035000,0.152400> rotate<0,44.998286,0> translate<16.283997,-1.535000,42.346244> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,49.347753>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,51.448572>}
box{<0,0,-0.152400><2.100819,0.035000,0.152400> rotate<0,90.000000,0> translate<16.283997,-1.535000,51.448572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,49.347753>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.355250,-1.535000,49.419009>}
box{<0,0,-0.152400><0.100769,0.035000,0.152400> rotate<0,-44.998286,0> translate<16.283997,-1.535000,49.347753> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.313844,-1.535000,49.377600>}
box{<0,0,-0.152400><0.029847,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,49.682400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,49.682400>}
box{<0,0,-0.152400><1.476003,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,49.682400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,49.987200>}
box{<0,0,-0.152400><1.476003,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,50.292000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,50.292000>}
box{<0,0,-0.152400><1.476003,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,50.292000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,50.596800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,50.596800>}
box{<0,0,-0.152400><1.476003,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,50.596800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,50.901600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,50.901600>}
box{<0,0,-0.152400><1.476003,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,50.901600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.283997,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,51.206400>}
box{<0,0,-0.152400><1.476003,0.035000,0.152400> rotate<0,0.000000,0> translate<16.283997,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.355250,-1.535000,42.274988>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.950078,-1.535000,42.028600>}
box{<0,0,-0.152400><0.643838,0.035000,0.152400> rotate<0,22.498649,0> translate<16.355250,-1.535000,42.274988> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.355250,-1.535000,49.419009>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.950078,-1.535000,49.665397>}
box{<0,0,-0.152400><0.643838,0.035000,0.152400> rotate<0,-22.498649,0> translate<16.355250,-1.535000,49.419009> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.950078,-1.535000,42.028600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.593919,-1.535000,42.028600>}
box{<0,0,-0.152400><0.643841,0.035000,0.152400> rotate<0,0.000000,0> translate<16.950078,-1.535000,42.028600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<16.950078,-1.535000,49.665397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.593919,-1.535000,49.665397>}
box{<0,0,-0.152400><0.643841,0.035000,0.152400> rotate<0,0.000000,0> translate<16.950078,-1.535000,49.665397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.593919,-1.535000,42.028600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,42.097397>}
box{<0,0,-0.152400><0.179766,0.035000,0.152400> rotate<0,-22.499625,0> translate<17.593919,-1.535000,42.028600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.593919,-1.535000,49.665397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,49.596600>}
box{<0,0,-0.152400><0.179766,0.035000,0.152400> rotate<0,22.499625,0> translate<17.593919,-1.535000,49.665397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.675512,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,42.062400>}
box{<0,0,-0.152400><0.084488,0.035000,0.152400> rotate<0,0.000000,0> translate<17.675512,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,40.245425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.876006,-1.535000,39.965359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<17.760000,-1.535000,40.245425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,42.097397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,40.245425>}
box{<0,0,-0.152400><1.851972,0.035000,0.152400> rotate<0,-90.000000,0> translate<17.760000,-1.535000,40.245425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,51.448572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,49.596600>}
box{<0,0,-0.152400><1.851972,0.035000,0.152400> rotate<0,-90.000000,0> translate<17.760000,-1.535000,49.596600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.760000,-1.535000,51.448572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.876006,-1.535000,51.728638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<17.760000,-1.535000,51.448572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.876006,-1.535000,39.965359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.090359,-1.535000,39.751006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<17.876006,-1.535000,39.965359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<17.876006,-1.535000,51.728638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.090359,-1.535000,51.942991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<17.876006,-1.535000,51.728638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.090359,-1.535000,39.751006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.370425,-1.535000,39.635000>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<18.090359,-1.535000,39.751006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.090359,-1.535000,51.942991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.370425,-1.535000,52.058997>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<18.090359,-1.535000,51.942991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.370425,-1.535000,39.635000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.973572,-1.535000,39.635000>}
box{<0,0,-0.152400><3.603147,0.035000,0.152400> rotate<0,0.000000,0> translate<18.370425,-1.535000,39.635000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.370425,-1.535000,52.058997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.973572,-1.535000,52.058997>}
box{<0,0,-0.152400><3.603147,0.035000,0.152400> rotate<0,0.000000,0> translate<18.370425,-1.535000,52.058997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.821600,-1.535000,43.158997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.853084,-1.535000,43.235000>}
box{<0,0,-0.152400><0.082266,0.035000,0.152400> rotate<0,-67.493712,0> translate<18.821600,-1.535000,43.158997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.821600,-1.535000,43.158997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.973572,-1.535000,43.158997>}
box{<0,0,-0.152400><3.151972,0.035000,0.152400> rotate<0,0.000000,0> translate<18.821600,-1.535000,43.158997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.821600,-1.535000,48.535000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.890397,-1.535000,48.368919>}
box{<0,0,-0.152400><0.179766,0.035000,0.152400> rotate<0,67.494436,0> translate<18.821600,-1.535000,48.535000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.821600,-1.535000,48.535000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.973572,-1.535000,48.535000>}
box{<0,0,-0.152400><3.151972,0.035000,0.152400> rotate<0,0.000000,0> translate<18.821600,-1.535000,48.535000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.851344,-1.535000,48.463200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,48.463200>}
box{<0,0,-0.152400><5.126256,0.035000,0.152400> rotate<0,0.000000,0> translate<18.851344,-1.535000,48.463200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.853084,-1.535000,43.235000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.973572,-1.535000,43.235000>}
box{<0,0,-0.152400><3.120487,0.035000,0.152400> rotate<0,0.000000,0> translate<18.853084,-1.535000,43.235000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.890397,-1.535000,48.103397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.890397,-1.535000,48.368919>}
box{<0,0,-0.152400><0.265522,0.035000,0.152400> rotate<0,90.000000,0> translate<18.890397,-1.535000,48.368919> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.890397,-1.535000,48.103397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.271981,-1.535000,48.103397>}
box{<0,0,-0.152400><1.381584,0.035000,0.152400> rotate<0,0.000000,0> translate<18.890397,-1.535000,48.103397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<18.890397,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.049553,-1.535000,48.158400>}
box{<0,0,-0.152400><5.159156,0.035000,0.152400> rotate<0,0.000000,0> translate<18.890397,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.271981,-1.535000,47.658997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.271981,-1.535000,48.103397>}
box{<0,0,-0.152400><0.444400,0.035000,0.152400> rotate<0,90.000000,0> translate<20.271981,-1.535000,48.103397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.271981,-1.535000,47.658997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.272013,-1.535000,47.658997>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<20.271981,-1.535000,47.658997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.271981,-1.535000,47.853600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.272013,-1.535000,47.853600>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<20.271981,-1.535000,47.853600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.272013,-1.535000,48.103394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.272013,-1.535000,47.658997>}
box{<0,0,-0.152400><0.444397,0.035000,0.152400> rotate<0,-90.000000,0> translate<20.272013,-1.535000,47.658997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<20.272013,-1.535000,48.103394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.875503,-1.535000,48.103397>}
box{<0,0,-0.152400><1.603491,0.035000,0.152400> rotate<0,-0.000112,0> translate<20.272013,-1.535000,48.103394> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.875503,-1.535000,48.103397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.978863,-1.535000,48.075703>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,14.998332,0> translate<21.875503,-1.535000,48.103397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.973572,-1.535000,39.635000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.253637,-1.535000,39.751006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<21.973572,-1.535000,39.635000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.973572,-1.535000,43.158997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.253637,-1.535000,43.042991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<21.973572,-1.535000,43.158997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.973572,-1.535000,43.235000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.096094,-1.535000,43.285750>}
box{<0,0,-0.152400><0.132617,0.035000,0.152400> rotate<0,-22.498426,0> translate<21.973572,-1.535000,43.235000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.973572,-1.535000,48.535000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.253637,-1.535000,48.651006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<21.973572,-1.535000,48.535000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.973572,-1.535000,52.058997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.253637,-1.535000,51.942991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<21.973572,-1.535000,52.058997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<21.978863,-1.535000,48.075703>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.071534,-1.535000,48.022197>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,29.999002,0> translate<21.978863,-1.535000,48.075703> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.071534,-1.535000,48.022197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.147197,-1.535000,47.946534>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,44.997030,0> translate<22.071534,-1.535000,48.022197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.086072,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.100241,-1.535000,43.281600>}
box{<0,0,-0.152400><0.014169,0.035000,0.152400> rotate<0,0.000000,0> translate<22.086072,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.096094,-1.535000,43.285750>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.342031,-1.535000,43.039809>}
box{<0,0,-0.152400><0.347810,0.035000,0.152400> rotate<0,44.997394,0> translate<22.096094,-1.535000,43.285750> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.147197,-1.535000,47.946534>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.200703,-1.535000,47.853863>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,59.995058,0> translate<22.147197,-1.535000,47.946534> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.200703,-1.535000,47.853863>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.228397,-1.535000,47.750503>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,74.995728,0> translate<22.200703,-1.535000,47.853863> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.200775,-1.535000,47.853600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.259241,-1.535000,47.853600>}
box{<0,0,-0.152400><2.058466,0.035000,0.152400> rotate<0,0.000000,0> translate<22.200775,-1.535000,47.853600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.228397,-1.535000,47.553444>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.228397,-1.535000,47.750503>}
box{<0,0,-0.152400><0.197059,0.035000,0.152400> rotate<0,90.000000,0> translate<22.228397,-1.535000,47.750503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.228397,-1.535000,47.553444>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.253637,-1.535000,47.542991>}
box{<0,0,-0.152400><0.027320,0.035000,0.152400> rotate<0,22.494865,0> translate<22.228397,-1.535000,47.553444> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.239612,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.564041,-1.535000,47.548800>}
box{<0,0,-0.152400><2.324428,0.035000,0.152400> rotate<0,0.000000,0> translate<22.239612,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.253637,-1.535000,39.751006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.467991,-1.535000,39.965359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<22.253637,-1.535000,39.751006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.253637,-1.535000,43.042991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.467991,-1.535000,42.828637>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<22.253637,-1.535000,43.042991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.253637,-1.535000,47.542991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.467991,-1.535000,47.328637>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<22.253637,-1.535000,47.542991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.253637,-1.535000,48.651006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.467991,-1.535000,48.865359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<22.253637,-1.535000,48.651006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.253637,-1.535000,51.942991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.467991,-1.535000,51.728638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<22.253637,-1.535000,51.942991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.319828,-1.535000,42.976800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.494147,-1.535000,42.976800>}
box{<0,0,-0.152400><0.174319,0.035000,0.152400> rotate<0,0.000000,0> translate<22.319828,-1.535000,42.976800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.342031,-1.535000,43.039809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.678113,-1.535000,42.900600>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,22.498510,0> translate<22.342031,-1.535000,43.039809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.370631,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,48.768000>}
box{<0,0,-0.152400><1.606969,0.035000,0.152400> rotate<0,0.000000,0> translate<22.370631,-1.535000,48.768000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.380628,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,51.816000>}
box{<0,0,-0.152400><0.230172,0.035000,0.152400> rotate<0,0.000000,0> translate<22.380628,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.431431,-1.535000,39.928800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.315516,-1.535000,39.928800>}
box{<0,0,-0.152400><11.884084,0.035000,0.152400> rotate<0,0.000000,0> translate<22.431431,-1.535000,39.928800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.467991,-1.535000,39.965359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,40.245425>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<22.467991,-1.535000,39.965359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.467991,-1.535000,42.828637>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,42.548572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<22.467991,-1.535000,42.828637> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.467991,-1.535000,47.328637>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,47.048572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<22.467991,-1.535000,47.328637> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.467991,-1.535000,48.865359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,49.145425>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<22.467991,-1.535000,48.865359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.467991,-1.535000,51.728638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,51.448572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<22.467991,-1.535000,51.728638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.503050,-1.535000,47.244000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.908169,-1.535000,47.244000>}
box{<0,0,-0.152400><2.405119,0.035000,0.152400> rotate<0,0.000000,0> translate<22.503050,-1.535000,47.244000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.532872,-1.535000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,42.672000>}
box{<0,0,-0.152400><0.428728,0.035000,0.152400> rotate<0,0.000000,0> translate<22.532872,-1.535000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.553913,-1.535000,49.072800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,49.072800>}
box{<0,0,-0.152400><1.423687,0.035000,0.152400> rotate<0,0.000000,0> translate<22.553913,-1.535000,49.072800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.558056,-1.535000,51.511200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,51.511200>}
box{<0,0,-0.152400><0.052744,0.035000,0.152400> rotate<0,0.000000,0> translate<22.558056,-1.535000,51.511200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.579097,-1.535000,40.233600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.833366,-1.535000,40.233600>}
box{<0,0,-0.152400><0.254269,0.035000,0.152400> rotate<0,0.000000,0> translate<22.579097,-1.535000,40.233600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,40.245425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,42.548572>}
box{<0,0,-0.152400><2.303147,0.035000,0.152400> rotate<0,90.000000,0> translate<22.583997,-1.535000,42.548572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,40.538400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.644691,-1.535000,40.538400>}
box{<0,0,-0.152400><0.060694,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,40.538400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,40.843200>}
box{<0,0,-0.152400><0.026803,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,41.148000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,41.148000>}
box{<0,0,-0.152400><0.026803,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,41.148000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,41.452800>}
box{<0,0,-0.152400><0.026803,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,41.757600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,41.757600>}
box{<0,0,-0.152400><0.026803,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,41.757600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.665738,-1.535000,42.062400>}
box{<0,0,-0.152400><0.081741,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,42.367200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.884169,-1.535000,42.367200>}
box{<0,0,-0.152400><0.300172,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,42.367200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,46.761397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,47.048572>}
box{<0,0,-0.152400><0.287175,0.035000,0.152400> rotate<0,90.000000,0> translate<22.583997,-1.535000,47.048572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,46.761397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.311884,-1.535000,46.761397>}
box{<0,0,-0.152400><1.727888,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,46.761397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,46.939200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.894997,-1.535000,46.939200>}
box{<0,0,-0.152400><3.311000,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,46.939200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,49.145425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,51.448572>}
box{<0,0,-0.152400><2.303147,0.035000,0.152400> rotate<0,90.000000,0> translate<22.583997,-1.535000,51.448572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,49.377600>}
box{<0,0,-0.152400><1.393603,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,49.682400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,49.682400>}
box{<0,0,-0.152400><1.393603,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,49.682400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,49.987200>}
box{<0,0,-0.152400><1.393603,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,50.292000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,50.292000>}
box{<0,0,-0.152400><1.393603,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,50.292000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,50.596800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.884166,-1.535000,50.596800>}
box{<0,0,-0.152400><0.300169,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,50.596800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,50.901600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.665734,-1.535000,50.901600>}
box{<0,0,-0.152400><0.081737,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,50.901600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.583997,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,51.206400>}
box{<0,0,-0.152400><0.026803,0.035000,0.152400> rotate<0,0.000000,0> translate<22.583997,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,40.620225>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.726806,-1.535000,40.340159>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<22.610800,-1.535000,40.620225> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,41.929772>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,40.620225>}
box{<0,0,-0.152400><1.309547,0.035000,0.152400> rotate<0,-90.000000,0> translate<22.610800,-1.535000,40.620225> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,41.929772>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.726806,-1.535000,42.209837>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<22.610800,-1.535000,41.929772> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,51.034225>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.726806,-1.535000,50.754159>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<22.610800,-1.535000,51.034225> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,52.343772>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,51.034225>}
box{<0,0,-0.152400><1.309547,0.035000,0.152400> rotate<0,-90.000000,0> translate<22.610800,-1.535000,51.034225> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.610800,-1.535000,52.343772>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.726806,-1.535000,52.623838>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<22.610800,-1.535000,52.343772> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.678113,-1.535000,42.900600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,42.900600>}
box{<0,0,-0.152400><0.283487,0.035000,0.152400> rotate<0,0.000000,0> translate<22.678113,-1.535000,42.900600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.726806,-1.535000,40.340159>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.941159,-1.535000,40.125806>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<22.726806,-1.535000,40.340159> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.726806,-1.535000,42.209837>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.941159,-1.535000,42.424191>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<22.726806,-1.535000,42.209837> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.726806,-1.535000,50.754159>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.941159,-1.535000,50.539806>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<22.726806,-1.535000,50.754159> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.726806,-1.535000,52.623838>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.941159,-1.535000,52.838191>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<22.726806,-1.535000,52.623838> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.941159,-1.535000,40.125806>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.221225,-1.535000,40.009800>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<22.941159,-1.535000,40.125806> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.941159,-1.535000,42.424191>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,42.432656>}
box{<0,0,-0.152400><0.022124,0.035000,0.152400> rotate<0,-22.495742,0> translate<22.941159,-1.535000,42.424191> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.941159,-1.535000,50.539806>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.221225,-1.535000,50.423800>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<22.941159,-1.535000,50.539806> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.941159,-1.535000,52.838191>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,52.846656>}
box{<0,0,-0.152400><0.022124,0.035000,0.152400> rotate<0,-22.495742,0> translate<22.941159,-1.535000,52.838191> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,42.900600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,42.432656>}
box{<0,0,-0.152400><0.467944,0.035000,0.152400> rotate<0,-90.000000,0> translate<22.961600,-1.535000,42.432656> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,53.793112>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,52.846656>}
box{<0,0,-0.152400><0.946456,0.035000,0.152400> rotate<0,-90.000000,0> translate<22.961600,-1.535000,52.846656> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,54.156884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,53.793112>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-90.000000,0> translate<22.961600,-1.535000,53.793112> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<22.961600,-1.535000,54.156884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.100809,-1.535000,54.492966>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<22.961600,-1.535000,54.156884> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.100809,-1.535000,54.492966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.263031,-1.535000,56.655188>}
box{<0,0,-0.152400><3.057844,0.035000,0.152400> rotate<0,-44.997030,0> translate<23.100809,-1.535000,54.492966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.221225,-1.535000,40.009800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.530772,-1.535000,40.009800>}
box{<0,0,-0.152400><1.309547,0.035000,0.152400> rotate<0,0.000000,0> translate<23.221225,-1.535000,40.009800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.221225,-1.535000,50.423800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,50.423800>}
box{<0,0,-0.152400><0.756375,0.035000,0.152400> rotate<0,0.000000,0> translate<23.221225,-1.535000,50.423800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,28.029925>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.929006,-1.535000,27.749859>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<23.813000,-1.535000,28.029925> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,30.136072>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,28.029925>}
box{<0,0,-0.152400><2.106147,0.035000,0.152400> rotate<0,-90.000000,0> translate<23.813000,-1.535000,28.029925> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,30.136072>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876553,-1.535000,30.289500>}
box{<0,0,-0.152400><0.166070,0.035000,0.152400> rotate<0,-67.495190,0> translate<23.813000,-1.535000,30.136072> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,30.442925>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.876553,-1.535000,30.289500>}
box{<0,0,-0.152400><0.166067,0.035000,0.152400> rotate<0,67.494777,0> translate<23.813000,-1.535000,30.442925> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,32.549072>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,30.442925>}
box{<0,0,-0.152400><2.106147,0.035000,0.152400> rotate<0,-90.000000,0> translate<23.813000,-1.535000,30.442925> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.813000,-1.535000,32.549072>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.929006,-1.535000,32.829138>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<23.813000,-1.535000,32.549072> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.929006,-1.535000,27.749859>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.143359,-1.535000,27.535506>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<23.929006,-1.535000,27.749859> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.929006,-1.535000,32.829138>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,32.840128>}
box{<0,0,-0.152400><0.015545,0.035000,0.152400> rotate<0,-44.988886,0> translate<23.929006,-1.535000,32.829138> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,34.835072>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,32.840128>}
box{<0,0,-0.152400><1.994944,0.035000,0.152400> rotate<0,-90.000000,0> translate<23.940000,-1.535000,32.840128> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,34.835072>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.003553,-1.535000,34.988500>}
box{<0,0,-0.152400><0.166070,0.035000,0.152400> rotate<0,-67.495190,0> translate<23.940000,-1.535000,34.835072> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,35.141925>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.003553,-1.535000,34.988500>}
box{<0,0,-0.152400><0.166067,0.035000,0.152400> rotate<0,67.494777,0> translate<23.940000,-1.535000,35.141925> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,37.248072>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,35.141925>}
box{<0,0,-0.152400><2.106147,0.035000,0.152400> rotate<0,-90.000000,0> translate<23.940000,-1.535000,35.141925> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.940000,-1.535000,37.248072>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.056006,-1.535000,37.528137>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<23.940000,-1.535000,37.248072> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,48.332113>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.116809,-1.535000,47.996031>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,67.495551,0> translate<23.977600,-1.535000,48.332113> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,50.423800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<23.977600,-1.535000,48.332113>}
box{<0,0,-0.152400><2.091687,0.035000,0.152400> rotate<0,-90.000000,0> translate<23.977600,-1.535000,48.332113> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.056006,-1.535000,37.528137>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.270359,-1.535000,37.742491>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<24.056006,-1.535000,37.528137> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.116809,-1.535000,47.996031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.583809,-1.535000,47.529031>}
box{<0,0,-0.152400><0.660438,0.035000,0.152400> rotate<0,44.997030,0> translate<24.116809,-1.535000,47.996031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.143359,-1.535000,27.535506>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.423425,-1.535000,27.419500>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<24.143359,-1.535000,27.535506> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.270359,-1.535000,37.742491>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.550425,-1.535000,37.858497>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<24.270359,-1.535000,37.742491> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.311884,-1.535000,46.761397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.647966,-1.535000,46.622188>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,22.498510,0> translate<24.311884,-1.535000,46.761397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.423425,-1.535000,27.419500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.485600,-1.535000,27.419500>}
box{<0,0,-0.152400><0.062175,0.035000,0.152400> rotate<0,0.000000,0> translate<24.423425,-1.535000,27.419500> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.485600,-1.535000,26.107112>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.624809,-1.535000,25.771031>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,67.495551,0> translate<24.485600,-1.535000,26.107112> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.485600,-1.535000,27.419500>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.485600,-1.535000,26.107112>}
box{<0,0,-0.152400><1.312388,0.035000,0.152400> rotate<0,-90.000000,0> translate<24.485600,-1.535000,26.107112> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.530772,-1.535000,40.009800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.810838,-1.535000,40.125806>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<24.530772,-1.535000,40.009800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.550425,-1.535000,37.858497>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.453572,-1.535000,37.858497>}
box{<0,0,-0.152400><1.903147,0.035000,0.152400> rotate<0,0.000000,0> translate<24.550425,-1.535000,37.858497> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.583809,-1.535000,47.529031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.841031,-1.535000,47.271809>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,44.997030,0> translate<24.583809,-1.535000,47.529031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.618484,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.927975,-1.535000,46.634400>}
box{<0,0,-0.152400><1.309491,0.035000,0.152400> rotate<0,0.000000,0> translate<24.618484,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.624809,-1.535000,25.771031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,21.719241>}
box{<0,0,-0.152400><5.730097,0.035000,0.152400> rotate<0,44.997030,0> translate<24.624809,-1.535000,25.771031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.647966,-1.535000,46.622188>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.524756,-1.535000,45.745397>}
box{<0,0,-0.152400><1.239969,0.035000,0.152400> rotate<0,44.997030,0> translate<24.647966,-1.535000,46.622188> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,42.432656>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,43.046953>}
box{<0,0,-0.152400><0.614297,0.035000,0.152400> rotate<0,90.000000,0> translate<24.790397,-1.535000,43.046953> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,42.432656>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.810838,-1.535000,42.424191>}
box{<0,0,-0.152400><0.022124,0.035000,0.152400> rotate<0,22.495742,0> translate<24.790397,-1.535000,42.432656> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561600,-1.535000,42.672000>}
box{<0,0,-0.152400><3.771203,0.035000,0.152400> rotate<0,0.000000,0> translate<24.790397,-1.535000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,42.976800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.752416,-1.535000,42.976800>}
box{<0,0,-0.152400><3.962019,0.035000,0.152400> rotate<0,0.000000,0> translate<24.790397,-1.535000,42.976800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,43.046953>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.837112,-1.535000,43.027600>}
box{<0,0,-0.152400><0.050566,0.035000,0.152400> rotate<0,22.501529,0> translate<24.790397,-1.535000,43.046953> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,52.846656>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,53.596241>}
box{<0,0,-0.152400><0.749584,0.035000,0.152400> rotate<0,90.000000,0> translate<24.790397,-1.535000,53.596241> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,52.846656>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.810838,-1.535000,52.838191>}
box{<0,0,-0.152400><0.022124,0.035000,0.152400> rotate<0,22.495742,0> translate<24.790397,-1.535000,52.846656> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,53.035200>}
box{<0,0,-0.152400><1.060603,0.035000,0.152400> rotate<0,0.000000,0> translate<24.790397,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,53.340000>}
box{<0,0,-0.152400><1.060603,0.035000,0.152400> rotate<0,0.000000,0> translate<24.790397,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.790397,-1.535000,53.596241>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.159756,-1.535000,54.965600>}
box{<0,0,-0.152400><1.936567,0.035000,0.152400> rotate<0,-44.997030,0> translate<24.790397,-1.535000,53.596241> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.810838,-1.535000,40.125806>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.025191,-1.535000,40.340159>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<24.810838,-1.535000,40.125806> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.810838,-1.535000,42.424191>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.025191,-1.535000,42.209837>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<24.810838,-1.535000,42.424191> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.810838,-1.535000,52.838191>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.025191,-1.535000,52.623838>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<24.810838,-1.535000,52.838191> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.837112,-1.535000,43.027600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.502884,-1.535000,43.027600>}
box{<0,0,-0.152400><3.665772,0.035000,0.152400> rotate<0,0.000000,0> translate<24.837112,-1.535000,43.027600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.838956,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.870150,-1.535000,53.644800>}
box{<0,0,-0.152400><1.031194,0.035000,0.152400> rotate<0,0.000000,0> translate<24.838956,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.841031,-1.535000,47.271809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.177112,-1.535000,47.132600>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,22.498510,0> translate<24.841031,-1.535000,47.271809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.867828,-1.535000,42.367200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561600,-1.535000,42.367200>}
box{<0,0,-0.152400><3.693772,0.035000,0.152400> rotate<0,0.000000,0> translate<24.867828,-1.535000,42.367200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.918628,-1.535000,52.730400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,52.730400>}
box{<0,0,-0.152400><0.932372,0.035000,0.152400> rotate<0,0.000000,0> translate<24.918628,-1.535000,52.730400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.918631,-1.535000,40.233600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.495444,-1.535000,40.233600>}
box{<0,0,-0.152400><9.576812,0.035000,0.152400> rotate<0,0.000000,0> translate<24.918631,-1.535000,40.233600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<24.940553,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,46.329600>}
box{<0,0,-0.152400><0.910447,0.035000,0.152400> rotate<0,0.000000,0> translate<24.940553,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.025191,-1.535000,40.340159>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,40.620225>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<25.025191,-1.535000,40.340159> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.025191,-1.535000,42.209837>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,41.929772>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<25.025191,-1.535000,42.209837> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.025191,-1.535000,52.623838>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,52.343772>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<25.025191,-1.535000,52.623838> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.086263,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561600,-1.535000,42.062400>}
box{<0,0,-0.152400><3.475338,0.035000,0.152400> rotate<0,0.000000,0> translate<25.086263,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.107303,-1.535000,40.538400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.023966,-1.535000,40.538400>}
box{<0,0,-0.152400><5.916663,0.035000,0.152400> rotate<0,0.000000,0> translate<25.107303,-1.535000,40.538400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.107303,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,52.425600>}
box{<0,0,-0.152400><0.743697,0.035000,0.152400> rotate<0,0.000000,0> translate<25.107303,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,40.620225>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,41.929772>}
box{<0,0,-0.152400><1.309547,0.035000,0.152400> rotate<0,90.000000,0> translate<25.141197,-1.535000,41.929772> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.682063,-1.535000,40.843200>}
box{<0,0,-0.152400><3.540866,0.035000,0.152400> rotate<0,0.000000,0> translate<25.141197,-1.535000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,41.148000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561597,-1.535000,41.148000>}
box{<0,0,-0.152400><3.420400,0.035000,0.152400> rotate<0,0.000000,0> translate<25.141197,-1.535000,41.148000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561597,-1.535000,41.452800>}
box{<0,0,-0.152400><3.420400,0.035000,0.152400> rotate<0,0.000000,0> translate<25.141197,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,41.757600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565588,-1.535000,41.757600>}
box{<0,0,-0.152400><4.424391,0.035000,0.152400> rotate<0,0.000000,0> translate<25.141197,-1.535000,41.757600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,51.970956>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,52.343772>}
box{<0,0,-0.152400><0.372816,0.035000,0.152400> rotate<0,90.000000,0> translate<25.141197,-1.535000,52.343772> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,51.970956>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.409966,-1.535000,51.702188>}
box{<0,0,-0.152400><0.380096,0.035000,0.152400> rotate<0,44.997030,0> translate<25.141197,-1.535000,51.970956> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.141197,-1.535000,52.120800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.902619,-1.535000,52.120800>}
box{<0,0,-0.152400><0.761422,0.035000,0.152400> rotate<0,0.000000,0> translate<25.141197,-1.535000,52.120800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.143756,-1.535000,53.949600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.037969,-1.535000,53.949600>}
box{<0,0,-0.152400><0.894212,0.035000,0.152400> rotate<0,0.000000,0> translate<25.143756,-1.535000,53.949600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.177112,-1.535000,47.132600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,47.132600>}
box{<0,0,-0.152400><0.673888,0.035000,0.152400> rotate<0,0.000000,0> translate<25.177112,-1.535000,47.132600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.245353,-1.535000,46.024800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,46.024800>}
box{<0,0,-0.152400><0.605647,0.035000,0.152400> rotate<0,0.000000,0> translate<25.245353,-1.535000,46.024800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.263031,-1.535000,56.655188>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.599113,-1.535000,56.794397>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-22.498510,0> translate<25.263031,-1.535000,56.655188> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.296153,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.116366,-1.535000,51.816000>}
box{<0,0,-0.152400><0.820213,0.035000,0.152400> rotate<0,0.000000,0> translate<25.296153,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.409966,-1.535000,51.702188>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.667188,-1.535000,51.444966>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,44.997030,0> translate<25.409966,-1.535000,51.702188> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.448556,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.498244,-1.535000,54.254400>}
box{<0,0,-0.152400><6.049687,0.035000,0.152400> rotate<0,0.000000,0> translate<25.448556,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.524756,-1.535000,45.745397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,45.745397>}
box{<0,0,-0.152400><0.326244,0.035000,0.152400> rotate<0,0.000000,0> translate<25.524756,-1.535000,45.745397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.599113,-1.535000,56.794397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.233600,-1.535000,56.794397>}
box{<0,0,-0.152400><14.634488,0.035000,0.152400> rotate<0,0.000000,0> translate<25.599113,-1.535000,56.794397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.600953,-1.535000,51.511200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.206600,-1.535000,51.511200>}
box{<0,0,-0.152400><0.605647,0.035000,0.152400> rotate<0,0.000000,0> translate<25.600953,-1.535000,51.511200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.667188,-1.535000,51.444966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.806397,-1.535000,51.108884>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,67.495551,0> translate<25.667188,-1.535000,51.444966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.753356,-1.535000,54.559200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.803044,-1.535000,54.559200>}
box{<0,0,-0.152400><6.049688,0.035000,0.152400> rotate<0,0.000000,0> translate<25.753356,-1.535000,54.559200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.766006,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.937088,-1.535000,51.206400>}
box{<0,0,-0.152400><0.171081,0.035000,0.152400> rotate<0,0.000000,0> translate<25.766006,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.806397,-1.535000,48.961397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.806397,-1.535000,51.108884>}
box{<0,0,-0.152400><2.147487,0.035000,0.152400> rotate<0,90.000000,0> translate<25.806397,-1.535000,51.108884> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.806397,-1.535000,48.961397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.865097,-1.535000,48.961397>}
box{<0,0,-0.152400><0.058700,0.035000,0.152400> rotate<0,0.000000,0> translate<25.806397,-1.535000,48.961397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.806397,-1.535000,49.072800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,49.072800>}
box{<0,0,-0.152400><0.044603,0.035000,0.152400> rotate<0,0.000000,0> translate<25.806397,-1.535000,49.072800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.806397,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,49.377600>}
box{<0,0,-0.152400><0.044603,0.035000,0.152400> rotate<0,0.000000,0> translate<25.806397,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.806397,-1.535000,49.682400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,49.682400>}
box{<0,0,-0.152400><0.044603,0.035000,0.152400> rotate<0,0.000000,0> translate<25.806397,-1.535000,49.682400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.806397,-1.535000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,49.987200>}
box{<0,0,-0.152400><0.044603,0.035000,0.152400> rotate<0,0.000000,0> translate<25.806397,-1.535000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.806397,-1.535000,50.292000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,50.292000>}
box{<0,0,-0.152400><0.044603,0.035000,0.152400> rotate<0,0.000000,0> translate<25.806397,-1.535000,50.292000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.806397,-1.535000,50.596800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,50.596800>}
box{<0,0,-0.152400><0.044603,0.035000,0.152400> rotate<0,0.000000,0> translate<25.806397,-1.535000,50.596800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.806397,-1.535000,50.901600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,50.901600>}
box{<0,0,-0.152400><0.044603,0.035000,0.152400> rotate<0,0.000000,0> translate<25.806397,-1.535000,50.901600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,46.448572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,45.745397>}
box{<0,0,-0.152400><0.703175,0.035000,0.152400> rotate<0,-90.000000,0> translate<25.851000,-1.535000,45.745397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,46.448572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.967006,-1.535000,46.728638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<25.851000,-1.535000,46.448572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,47.045425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.967006,-1.535000,46.765359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<25.851000,-1.535000,47.045425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,47.132600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,47.045425>}
box{<0,0,-0.152400><0.087175,0.035000,0.152400> rotate<0,-90.000000,0> translate<25.851000,-1.535000,47.045425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,48.995425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.865097,-1.535000,48.961397>}
box{<0,0,-0.152400><0.036833,0.035000,0.152400> rotate<0,67.492723,0> translate<25.851000,-1.535000,48.995425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,50.998572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,48.995425>}
box{<0,0,-0.152400><2.003147,0.035000,0.152400> rotate<0,-90.000000,0> translate<25.851000,-1.535000,48.995425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,50.998572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.967006,-1.535000,51.278638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<25.851000,-1.535000,50.998572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,52.245425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.967006,-1.535000,51.965359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<25.851000,-1.535000,52.245425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,53.598572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,52.245425>}
box{<0,0,-0.152400><1.353147,0.035000,0.152400> rotate<0,-90.000000,0> translate<25.851000,-1.535000,52.245425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.851000,-1.535000,53.598572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.967006,-1.535000,53.878638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<25.851000,-1.535000,53.598572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.967006,-1.535000,46.728638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.985369,-1.535000,46.746997>}
box{<0,0,-0.152400><0.025966,0.035000,0.152400> rotate<0,-44.992155,0> translate<25.967006,-1.535000,46.728638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.967006,-1.535000,46.765359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.985369,-1.535000,46.746997>}
box{<0,0,-0.152400><0.025968,0.035000,0.152400> rotate<0,44.997030,0> translate<25.967006,-1.535000,46.765359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.967006,-1.535000,51.278638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.181359,-1.535000,51.492991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<25.967006,-1.535000,51.278638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.967006,-1.535000,51.965359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.181359,-1.535000,51.751006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<25.967006,-1.535000,51.965359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<25.967006,-1.535000,53.878638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.181359,-1.535000,54.092991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<25.967006,-1.535000,53.878638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.058156,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.268800,-1.535000,54.864000>}
box{<0,0,-0.152400><6.210644,0.035000,0.152400> rotate<0,0.000000,0> translate<26.058156,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.159756,-1.535000,54.965600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.233600,-1.535000,54.965600>}
box{<0,0,-0.152400><14.073844,0.035000,0.152400> rotate<0,0.000000,0> translate<26.159756,-1.535000,54.965600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.181359,-1.535000,51.492991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.206600,-1.535000,51.503444>}
box{<0,0,-0.152400><0.027320,0.035000,0.152400> rotate<0,-22.494865,0> translate<26.181359,-1.535000,51.492991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.181359,-1.535000,51.751006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.206600,-1.535000,51.740553>}
box{<0,0,-0.152400><0.027320,0.035000,0.152400> rotate<0,22.494865,0> translate<26.181359,-1.535000,51.751006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.181359,-1.535000,54.092991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.461425,-1.535000,54.208997>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<26.181359,-1.535000,54.092991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.206600,-1.535000,51.550503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.206600,-1.535000,51.503444>}
box{<0,0,-0.152400><0.047059,0.035000,0.152400> rotate<0,-90.000000,0> translate<26.206600,-1.535000,51.503444> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.206600,-1.535000,51.550503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.225756,-1.535000,51.621997>}
box{<0,0,-0.152400><0.074016,0.035000,0.152400> rotate<0,-74.995381,0> translate<26.206600,-1.535000,51.550503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.206600,-1.535000,51.693494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.225756,-1.535000,51.621997>}
box{<0,0,-0.152400><0.074019,0.035000,0.152400> rotate<0,74.996007,0> translate<26.206600,-1.535000,51.693494> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.206600,-1.535000,51.740553>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.206600,-1.535000,51.693494>}
box{<0,0,-0.152400><0.047059,0.035000,0.152400> rotate<0,-90.000000,0> translate<26.206600,-1.535000,51.693494> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.453572,-1.535000,37.858497>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.733638,-1.535000,37.742491>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<26.453572,-1.535000,37.858497> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.461425,-1.535000,54.208997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.264572,-1.535000,54.208997>}
box{<0,0,-0.152400><1.803147,0.035000,0.152400> rotate<0,0.000000,0> translate<26.461425,-1.535000,54.208997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.606388,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.241613,-1.535000,37.795200>}
box{<0,0,-0.152400><0.635225,0.035000,0.152400> rotate<0,0.000000,0> translate<26.606388,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.733638,-1.535000,37.742491>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.923997,-1.535000,37.552128>}
box{<0,0,-0.152400><0.269211,0.035000,0.152400> rotate<0,44.997500,0> translate<26.733638,-1.535000,37.742491> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<26.923997,-1.535000,37.552128>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.114359,-1.535000,37.742491>}
box{<0,0,-0.152400><0.269213,0.035000,0.152400> rotate<0,-44.997030,0> translate<26.923997,-1.535000,37.552128> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.114359,-1.535000,37.742491>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.394425,-1.535000,37.858497>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<27.114359,-1.535000,37.742491> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<27.394425,-1.535000,37.858497>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.206000,-1.535000,37.858497>}
box{<0,0,-0.152400><0.811575,0.035000,0.152400> rotate<0,0.000000,0> translate<27.394425,-1.535000,37.858497> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.206000,-1.535000,39.283572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.206000,-1.535000,37.858497>}
box{<0,0,-0.152400><1.425075,0.035000,0.152400> rotate<0,-90.000000,0> translate<28.206000,-1.535000,37.858497> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.206000,-1.535000,39.283572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.322006,-1.535000,39.563637>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<28.206000,-1.535000,39.283572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.264572,-1.535000,54.208997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.544638,-1.535000,54.092991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<28.264572,-1.535000,54.208997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.322006,-1.535000,39.563637>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.536359,-1.535000,39.777991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<28.322006,-1.535000,39.563637> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.500241,-1.535000,51.621997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.519397,-1.535000,51.550503>}
box{<0,0,-0.152400><0.074016,0.035000,0.152400> rotate<0,74.995381,0> translate<28.500241,-1.535000,51.621997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.500241,-1.535000,51.621997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.519397,-1.535000,51.693494>}
box{<0,0,-0.152400><0.074019,0.035000,0.152400> rotate<0,-74.996007,0> translate<28.500241,-1.535000,51.621997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.502884,-1.535000,43.027600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.838966,-1.535000,43.166809>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-22.498510,0> translate<28.502884,-1.535000,43.027600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.519397,-1.535000,51.503444>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.519397,-1.535000,51.550503>}
box{<0,0,-0.152400><0.047059,0.035000,0.152400> rotate<0,90.000000,0> translate<28.519397,-1.535000,51.550503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.519397,-1.535000,51.503444>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.544638,-1.535000,51.492991>}
box{<0,0,-0.152400><0.027320,0.035000,0.152400> rotate<0,22.494865,0> translate<28.519397,-1.535000,51.503444> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.519397,-1.535000,51.511200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,51.511200>}
box{<0,0,-0.152400><2.062203,0.035000,0.152400> rotate<0,0.000000,0> translate<28.519397,-1.535000,51.511200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.519397,-1.535000,51.693494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.519397,-1.535000,51.740553>}
box{<0,0,-0.152400><0.047059,0.035000,0.152400> rotate<0,90.000000,0> translate<28.519397,-1.535000,51.740553> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.519397,-1.535000,51.740553>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.544638,-1.535000,51.751006>}
box{<0,0,-0.152400><0.027320,0.035000,0.152400> rotate<0,-22.494865,0> translate<28.519397,-1.535000,51.740553> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.536359,-1.535000,39.777991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.816425,-1.535000,39.893997>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<28.536359,-1.535000,39.777991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.544638,-1.535000,51.492991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.758991,-1.535000,51.278638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<28.544638,-1.535000,51.492991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.544638,-1.535000,51.751006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.758991,-1.535000,51.965359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<28.544638,-1.535000,51.751006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.544638,-1.535000,54.092991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.758991,-1.535000,53.878638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<28.544638,-1.535000,54.092991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561597,-1.535000,41.729603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561600,-1.535000,41.078494>}
box{<0,0,-0.152400><0.651109,0.035000,0.152400> rotate<0,89.993785,0> translate<28.561597,-1.535000,41.729603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561597,-1.535000,41.729603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565588,-1.535000,41.729603>}
box{<0,0,-0.152400><1.003991,0.035000,0.152400> rotate<0,0.000000,0> translate<28.561597,-1.535000,41.729603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561600,-1.535000,41.078494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.589294,-1.535000,40.975134>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,74.995728,0> translate<28.561600,-1.535000,41.078494> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561600,-1.535000,42.034391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565588,-1.535000,42.034391>}
box{<0,0,-0.152400><1.003988,0.035000,0.152400> rotate<0,0.000000,0> translate<28.561600,-1.535000,42.034391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561600,-1.535000,42.685503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561600,-1.535000,42.034391>}
box{<0,0,-0.152400><0.651113,0.035000,0.152400> rotate<0,-90.000000,0> translate<28.561600,-1.535000,42.034391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.561600,-1.535000,42.685503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.589294,-1.535000,42.788863>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-74.995728,0> translate<28.561600,-1.535000,42.685503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.589294,-1.535000,40.975134>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.642800,-1.535000,40.882463>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,59.995058,0> translate<28.589294,-1.535000,40.975134> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.589294,-1.535000,42.788863>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.642800,-1.535000,42.881534>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-59.995058,0> translate<28.589294,-1.535000,42.788863> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.609631,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,51.816000>}
box{<0,0,-0.152400><1.971969,0.035000,0.152400> rotate<0,0.000000,0> translate<28.609631,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.642800,-1.535000,40.882463>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.718463,-1.535000,40.806800>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,44.997030,0> translate<28.642800,-1.535000,40.882463> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.642800,-1.535000,42.881534>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.718463,-1.535000,42.957197>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,-44.997030,0> translate<28.642800,-1.535000,42.881534> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,14.931113>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.815809,-1.535000,14.595031>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,67.495551,0> translate<28.676600,-1.535000,14.931113> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,21.719241>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.676600,-1.535000,14.931113>}
box{<0,0,-0.152400><6.788128,0.035000,0.152400> rotate<0,-90.000000,0> translate<28.676600,-1.535000,14.931113> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.688028,-1.535000,53.949600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.193444,-1.535000,53.949600>}
box{<0,0,-0.152400><2.505416,0.035000,0.152400> rotate<0,0.000000,0> translate<28.688028,-1.535000,53.949600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.718463,-1.535000,40.806800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.811134,-1.535000,40.753294>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,29.999002,0> translate<28.718463,-1.535000,40.806800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.718463,-1.535000,42.957197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.811134,-1.535000,43.010703>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-29.999002,0> translate<28.718463,-1.535000,42.957197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.740628,-1.535000,48.696997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.758991,-1.535000,48.678638>}
box{<0,0,-0.152400><0.025966,0.035000,0.152400> rotate<0,44.992155,0> translate<28.740628,-1.535000,48.696997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.740628,-1.535000,48.696997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.758991,-1.535000,48.715359>}
box{<0,0,-0.152400><0.025968,0.035000,0.152400> rotate<0,-44.997030,0> translate<28.740628,-1.535000,48.696997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.758991,-1.535000,48.678638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,48.398572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<28.758991,-1.535000,48.678638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.758991,-1.535000,48.715359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,48.995425>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<28.758991,-1.535000,48.715359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.758991,-1.535000,51.278638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,50.998572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<28.758991,-1.535000,51.278638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.758991,-1.535000,51.965359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,52.245425>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<28.758991,-1.535000,51.965359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.758991,-1.535000,53.878638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,53.598572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<28.758991,-1.535000,53.878638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.780794,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,48.768000>}
box{<0,0,-0.152400><1.927806,0.035000,0.152400> rotate<0,0.000000,0> translate<28.780794,-1.535000,48.768000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.788913,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,51.206400>}
box{<0,0,-0.152400><1.792687,0.035000,0.152400> rotate<0,0.000000,0> translate<28.788913,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.811134,-1.535000,40.753294>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.914494,-1.535000,40.725600>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,14.998332,0> translate<28.811134,-1.535000,40.753294> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.811134,-1.535000,43.010703>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.914494,-1.535000,43.038397>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-14.998332,0> translate<28.811134,-1.535000,43.010703> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.815809,-1.535000,14.595031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.073031,-1.535000,14.337809>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,44.997030,0> translate<28.815809,-1.535000,14.595031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.816425,-1.535000,39.893997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.619572,-1.535000,39.893997>}
box{<0,0,-0.152400><1.803147,0.035000,0.152400> rotate<0,0.000000,0> translate<28.816425,-1.535000,39.893997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.823375,-1.535000,52.120800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,52.120800>}
box{<0,0,-0.152400><1.758225,0.035000,0.152400> rotate<0,0.000000,0> translate<28.823375,-1.535000,52.120800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.838966,-1.535000,43.166809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.096188,-1.535000,43.424031>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,-44.997030,0> translate<28.838966,-1.535000,43.166809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.848228,-1.535000,48.463200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,48.463200>}
box{<0,0,-0.152400><1.860372,0.035000,0.152400> rotate<0,0.000000,0> translate<28.848228,-1.535000,48.463200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.855850,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.888644,-1.535000,53.644800>}
box{<0,0,-0.152400><2.032794,0.035000,0.152400> rotate<0,0.000000,0> translate<28.855850,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.860900,-1.535000,47.011397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,47.045425>}
box{<0,0,-0.152400><0.036833,0.035000,0.152400> rotate<0,-67.492723,0> translate<28.860900,-1.535000,47.011397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.860900,-1.535000,47.011397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.605241,-1.535000,47.011397>}
box{<0,0,-0.152400><1.744341,0.035000,0.152400> rotate<0,0.000000,0> translate<28.860900,-1.535000,47.011397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,47.045425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,48.398572>}
box{<0,0,-0.152400><1.353147,0.035000,0.152400> rotate<0,90.000000,0> translate<28.874997,-1.535000,48.398572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,47.244000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,47.244000>}
box{<0,0,-0.152400><1.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,47.244000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,47.548800>}
box{<0,0,-0.152400><1.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,47.853600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,47.853600>}
box{<0,0,-0.152400><1.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,47.853600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,48.158400>}
box{<0,0,-0.152400><1.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,48.995425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,50.998572>}
box{<0,0,-0.152400><2.003147,0.035000,0.152400> rotate<0,90.000000,0> translate<28.874997,-1.535000,50.998572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,49.072800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,49.072800>}
box{<0,0,-0.152400><1.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,49.072800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,49.377600>}
box{<0,0,-0.152400><1.833603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,49.682400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.653553,-1.535000,49.682400>}
box{<0,0,-0.152400><1.778556,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,49.682400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,49.987200>}
box{<0,0,-0.152400><1.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,50.292000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,50.292000>}
box{<0,0,-0.152400><1.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,50.292000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,50.596800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,50.596800>}
box{<0,0,-0.152400><1.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,50.596800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,50.901600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,50.901600>}
box{<0,0,-0.152400><1.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,50.901600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,52.245425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,53.598572>}
box{<0,0,-0.152400><1.353147,0.035000,0.152400> rotate<0,90.000000,0> translate<28.874997,-1.535000,53.598572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,52.425600>}
box{<0,0,-0.152400><1.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,52.730400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,52.730400>}
box{<0,0,-0.152400><1.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,52.730400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,53.035200>}
box{<0,0,-0.152400><1.706603,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.874997,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.664078,-1.535000,53.340000>}
box{<0,0,-0.152400><1.789081,0.035000,0.152400> rotate<0,0.000000,0> translate<28.874997,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.914494,-1.535000,40.725600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,40.725600>}
box{<0,0,-0.152400><0.651109,0.035000,0.152400> rotate<0,0.000000,0> translate<28.914494,-1.535000,40.725600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.914494,-1.535000,43.038397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,43.038397>}
box{<0,0,-0.152400><0.651109,0.035000,0.152400> rotate<0,0.000000,0> translate<28.914494,-1.535000,43.038397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<28.953756,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.085075,-1.535000,43.281600>}
box{<0,0,-0.152400><2.131319,0.035000,0.152400> rotate<0,0.000000,0> translate<28.953756,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.073031,-1.535000,14.337809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.073034,-1.535000,14.337809>}
box{<0,0,-0.152400><0.000003,0.035000,0.152400> rotate<0,0.000000,0> translate<29.073031,-1.535000,14.337809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.073034,-1.535000,14.337809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.371809,-1.535000,11.039031>}
box{<0,0,-0.152400><4.665175,0.035000,0.152400> rotate<0,44.997057,0> translate<29.073034,-1.535000,14.337809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.096188,-1.535000,43.424031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.477188,-1.535000,43.805031>}
box{<0,0,-0.152400><0.538815,0.035000,0.152400> rotate<0,-44.997030,0> translate<29.096188,-1.535000,43.424031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.258556,-1.535000,43.586400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.810000,-1.535000,43.586400>}
box{<0,0,-0.152400><5.551444,0.035000,0.152400> rotate<0,0.000000,0> translate<29.258556,-1.535000,43.586400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.477188,-1.535000,43.805031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.616397,-1.535000,44.141113>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<29.477188,-1.535000,43.805031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.512878,-1.535000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.575744,-1.535000,43.891200>}
box{<0,0,-0.152400><4.062866,0.035000,0.152400> rotate<0,0.000000,0> translate<29.512878,-1.535000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565588,-1.535000,42.034391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565588,-1.535000,41.729603>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,-90.000000,0> translate<29.565588,-1.535000,41.729603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,40.725600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,41.729588>}
box{<0,0,-0.152400><1.003988,0.035000,0.152400> rotate<0,90.000000,0> translate<29.565603,-1.535000,41.729588> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,40.843200>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<29.565603,-1.535000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,41.148000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,41.148000>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<29.565603,-1.535000,41.148000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,41.452800>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<29.565603,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,41.729588>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,41.729588>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<29.565603,-1.535000,41.729588> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,42.034409>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,43.038397>}
box{<0,0,-0.152400><1.003988,0.035000,0.152400> rotate<0,90.000000,0> translate<29.565603,-1.535000,43.038397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,42.034409>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,42.034409>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<29.565603,-1.535000,42.034409> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,42.062400>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<29.565603,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,42.367200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,42.367200>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<29.565603,-1.535000,42.367200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,42.672000>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<29.565603,-1.535000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.565603,-1.535000,42.976800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,42.976800>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<29.565603,-1.535000,42.976800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.598703,-1.535000,45.182600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.616397,-1.535000,45.139884>}
box{<0,0,-0.152400><0.046235,0.035000,0.152400> rotate<0,67.495135,0> translate<29.598703,-1.535000,45.182600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.598703,-1.535000,45.182600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.165884,-1.535000,45.182600>}
box{<0,0,-0.152400><1.567181,0.035000,0.152400> rotate<0,0.000000,0> translate<29.598703,-1.535000,45.182600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.616397,-1.535000,44.141113>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.616397,-1.535000,45.139884>}
box{<0,0,-0.152400><0.998772,0.035000,0.152400> rotate<0,90.000000,0> translate<29.616397,-1.535000,45.139884> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.616397,-1.535000,44.196000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.204313,-1.535000,44.196000>}
box{<0,0,-0.152400><3.587916,0.035000,0.152400> rotate<0,0.000000,0> translate<29.616397,-1.535000,44.196000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.616397,-1.535000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,44.500800>}
box{<0,0,-0.152400><3.484603,0.035000,0.152400> rotate<0,0.000000,0> translate<29.616397,-1.535000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.616397,-1.535000,44.805600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,44.805600>}
box{<0,0,-0.152400><3.484603,0.035000,0.152400> rotate<0,0.000000,0> translate<29.616397,-1.535000,44.805600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.616397,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,45.110400>}
box{<0,0,-0.152400><3.484603,0.035000,0.152400> rotate<0,0.000000,0> translate<29.616397,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,40.725600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.521503,-1.535000,40.725600>}
box{<0,0,-0.152400><0.651112,0.035000,0.152400> rotate<0,0.000000,0> translate<29.870391,-1.535000,40.725600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,41.729588>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,40.725600>}
box{<0,0,-0.152400><1.003988,0.035000,0.152400> rotate<0,-90.000000,0> translate<29.870391,-1.535000,40.725600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,43.038397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,42.034409>}
box{<0,0,-0.152400><1.003988,0.035000,0.152400> rotate<0,-90.000000,0> translate<29.870391,-1.535000,42.034409> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<29.870391,-1.535000,43.038397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.521503,-1.535000,43.038397>}
box{<0,0,-0.152400><0.651112,0.035000,0.152400> rotate<0,0.000000,0> translate<29.870391,-1.535000,43.038397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.521503,-1.535000,40.725600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.624863,-1.535000,40.753294>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-14.998332,0> translate<30.521503,-1.535000,40.725600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.521503,-1.535000,43.038397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.624863,-1.535000,43.010703>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,14.998332,0> translate<30.521503,-1.535000,43.038397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,49.856113>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,49.549509>}
box{<0,0,-0.152400><0.331865,0.035000,0.152400> rotate<0,67.495413,0> translate<30.581600,-1.535000,49.856113> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,53.140884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,49.856113>}
box{<0,0,-0.152400><3.284772,0.035000,0.152400> rotate<0,-90.000000,0> translate<30.581600,-1.535000,49.856113> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.581600,-1.535000,53.140884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.720809,-1.535000,53.476966>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<30.581600,-1.535000,53.140884> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.605241,-1.535000,47.011397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,47.114756>}
box{<0,0,-0.152400><0.146172,0.035000,0.152400> rotate<0,-44.997030,0> translate<30.605241,-1.535000,47.011397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.619572,-1.535000,39.893997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.899638,-1.535000,39.777991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<30.619572,-1.535000,39.893997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.624863,-1.535000,40.753294>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.717534,-1.535000,40.806800>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-29.999002,0> translate<30.624863,-1.535000,40.753294> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.624863,-1.535000,43.010703>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.717534,-1.535000,42.957197>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,29.999002,0> translate<30.624863,-1.535000,43.010703> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.683584,-1.535000,42.976800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.826041,-1.535000,42.976800>}
box{<0,0,-0.152400><0.142456,0.035000,0.152400> rotate<0,0.000000,0> translate<30.683584,-1.535000,42.976800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,49.549509>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.708600,-1.535000,47.114756>}
box{<0,0,-0.152400><2.434753,0.035000,0.152400> rotate<0,-90.000000,0> translate<30.708600,-1.535000,47.114756> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.717534,-1.535000,40.806800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.788516,-1.535000,40.877784>}
box{<0,0,-0.152400><0.100385,0.035000,0.152400> rotate<0,-44.998291,0> translate<30.717534,-1.535000,40.806800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.717534,-1.535000,42.957197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.788516,-1.535000,42.886212>}
box{<0,0,-0.152400><0.100385,0.035000,0.152400> rotate<0,44.998291,0> translate<30.717534,-1.535000,42.957197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.720809,-1.535000,53.476966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.978031,-1.535000,53.734188>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,-44.997030,0> translate<30.720809,-1.535000,53.476966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.753931,-1.535000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.802841,-1.535000,40.843200>}
box{<0,0,-0.152400><0.048909,0.035000,0.152400> rotate<0,0.000000,0> translate<30.753931,-1.535000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.788516,-1.535000,40.877784>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.862006,-1.535000,40.700359>}
box{<0,0,-0.152400><0.192043,0.035000,0.152400> rotate<0,67.495881,0> translate<30.788516,-1.535000,40.877784> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.788516,-1.535000,42.886212>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.862006,-1.535000,43.063637>}
box{<0,0,-0.152400><0.192043,0.035000,0.152400> rotate<0,-67.495881,0> translate<30.788516,-1.535000,42.886212> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.862006,-1.535000,40.700359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.076359,-1.535000,40.486006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<30.862006,-1.535000,40.700359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.862006,-1.535000,43.063637>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.076359,-1.535000,43.277991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<30.862006,-1.535000,43.063637> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.899638,-1.535000,39.777991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.987997,-1.535000,39.689628>}
box{<0,0,-0.152400><0.124961,0.035000,0.152400> rotate<0,44.998043,0> translate<30.899638,-1.535000,39.777991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.978031,-1.535000,53.734188>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.994031,-1.535000,54.750188>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<30.978031,-1.535000,53.734188> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<30.987997,-1.535000,39.689628>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.076359,-1.535000,39.777991>}
box{<0,0,-0.152400><0.124963,0.035000,0.152400> rotate<0,-44.997030,0> translate<30.987997,-1.535000,39.689628> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.076359,-1.535000,39.777991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.356425,-1.535000,39.893997>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<31.076359,-1.535000,39.777991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.076359,-1.535000,40.486006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.356425,-1.535000,40.370000>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<31.076359,-1.535000,40.486006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.076359,-1.535000,43.277991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.356425,-1.535000,43.393997>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<31.076359,-1.535000,43.277991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.165884,-1.535000,45.182600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.501966,-1.535000,45.321809>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-22.498510,0> translate<31.165884,-1.535000,45.182600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.356425,-1.535000,39.893997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.159572,-1.535000,39.893997>}
box{<0,0,-0.152400><1.803147,0.035000,0.152400> rotate<0,0.000000,0> translate<31.356425,-1.535000,39.893997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.356425,-1.535000,40.370000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.159572,-1.535000,40.370000>}
box{<0,0,-0.152400><1.803147,0.035000,0.152400> rotate<0,0.000000,0> translate<31.356425,-1.535000,40.370000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.356425,-1.535000,43.393997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.159572,-1.535000,43.393997>}
box{<0,0,-0.152400><1.803147,0.035000,0.152400> rotate<0,0.000000,0> translate<31.356425,-1.535000,43.393997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.501966,-1.535000,45.321809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.140966,-1.535000,45.960809>}
box{<0,0,-0.152400><0.903682,0.035000,0.152400> rotate<0,-44.997030,0> translate<31.501966,-1.535000,45.321809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.595356,-1.535000,45.415200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,45.415200>}
box{<0,0,-0.152400><1.505644,0.035000,0.152400> rotate<0,0.000000,0> translate<31.595356,-1.535000,45.415200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.900156,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,45.720000>}
box{<0,0,-0.152400><1.200844,0.035000,0.152400> rotate<0,0.000000,0> translate<31.900156,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<31.994031,-1.535000,54.750188>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.330112,-1.535000,54.889397>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-22.498510,0> translate<31.994031,-1.535000,54.750188> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.140966,-1.535000,45.960809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.398187,-1.535000,46.218031>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,-44.997030,0> translate<32.140966,-1.535000,45.960809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.204956,-1.535000,46.024800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,46.024800>}
box{<0,0,-0.152400><0.896044,0.035000,0.152400> rotate<0,0.000000,0> translate<32.204956,-1.535000,46.024800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.330112,-1.535000,54.889397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.551884,-1.535000,54.889397>}
box{<0,0,-0.152400><7.221772,0.035000,0.152400> rotate<0,0.000000,0> translate<32.330112,-1.535000,54.889397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.371809,-1.535000,11.039031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.463447,-1.535000,10.947397>}
box{<0,0,-0.152400><0.129593,0.035000,0.152400> rotate<0,44.996053,0> translate<32.371809,-1.535000,11.039031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.398187,-1.535000,46.218031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,46.554113>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<32.398187,-1.535000,46.218031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.444400,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,46.329600>}
box{<0,0,-0.152400><0.656600,0.035000,0.152400> rotate<0,0.000000,0> translate<32.444400,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,46.554113>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,49.278241>}
box{<0,0,-0.152400><2.724128,0.035000,0.152400> rotate<0,90.000000,0> translate<32.537397,-1.535000,49.278241> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,46.634400>}
box{<0,0,-0.152400><0.563603,0.035000,0.152400> rotate<0,0.000000,0> translate<32.537397,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,46.939200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,46.939200>}
box{<0,0,-0.152400><0.563603,0.035000,0.152400> rotate<0,0.000000,0> translate<32.537397,-1.535000,46.939200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,47.244000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,47.244000>}
box{<0,0,-0.152400><0.563603,0.035000,0.152400> rotate<0,0.000000,0> translate<32.537397,-1.535000,47.244000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,47.548800>}
box{<0,0,-0.152400><0.563603,0.035000,0.152400> rotate<0,0.000000,0> translate<32.537397,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,47.853600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,47.853600>}
box{<0,0,-0.152400><0.563603,0.035000,0.152400> rotate<0,0.000000,0> translate<32.537397,-1.535000,47.853600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,48.158400>}
box{<0,0,-0.152400><0.563603,0.035000,0.152400> rotate<0,0.000000,0> translate<32.537397,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,48.463200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,48.463200>}
box{<0,0,-0.152400><0.563603,0.035000,0.152400> rotate<0,0.000000,0> translate<32.537397,-1.535000,48.463200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,48.768000>}
box{<0,0,-0.152400><0.563603,0.035000,0.152400> rotate<0,0.000000,0> translate<32.537397,-1.535000,48.768000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,49.072800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.111038,-1.535000,49.072800>}
box{<0,0,-0.152400><0.573641,0.035000,0.152400> rotate<0,0.000000,0> translate<32.537397,-1.535000,49.072800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.537397,-1.535000,49.278241>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,49.841847>}
box{<0,0,-0.152400><0.797057,0.035000,0.152400> rotate<0,-44.997189,0> translate<32.537397,-1.535000,49.278241> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.636753,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.211934,-1.535000,49.377600>}
box{<0,0,-0.152400><0.575181,0.035000,0.152400> rotate<0,0.000000,0> translate<32.636753,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<32.941553,-1.535000,49.682400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,49.682400>}
box{<0,0,-0.152400><0.159447,0.035000,0.152400> rotate<0,0.000000,0> translate<32.941553,-1.535000,49.682400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,44.445425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.217006,-1.535000,44.165359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<33.101000,-1.535000,44.445425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,49.048572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,44.445425>}
box{<0,0,-0.152400><4.603147,0.035000,0.152400> rotate<0,-90.000000,0> translate<33.101000,-1.535000,44.445425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,49.048572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.217006,-1.535000,49.328637>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<33.101000,-1.535000,49.048572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,49.645425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.217006,-1.535000,49.365359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<33.101000,-1.535000,49.645425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,49.841847>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.101000,-1.535000,49.645425>}
box{<0,0,-0.152400><0.196422,0.035000,0.152400> rotate<0,-90.000000,0> translate<33.101000,-1.535000,49.645425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.159572,-1.535000,39.893997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.439638,-1.535000,39.777991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<33.159572,-1.535000,39.893997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.159572,-1.535000,40.370000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.439638,-1.535000,40.486006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<33.159572,-1.535000,40.370000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.159572,-1.535000,43.393997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.439638,-1.535000,43.277991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<33.159572,-1.535000,43.393997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.172397,-1.535000,35.989550>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.172397,-1.535000,36.875312>}
box{<0,0,-0.152400><0.885762,0.035000,0.152400> rotate<0,90.000000,0> translate<33.172397,-1.535000,36.875312> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.172397,-1.535000,35.989550>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,37.081756>}
box{<0,0,-0.152400><1.544611,0.035000,0.152400> rotate<0,-44.997112,0> translate<33.172397,-1.535000,35.989550> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.172397,-1.535000,36.271200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.454047,-1.535000,36.271200>}
box{<0,0,-0.152400><0.281650,0.035000,0.152400> rotate<0,0.000000,0> translate<33.172397,-1.535000,36.271200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.172397,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.758847,-1.535000,36.576000>}
box{<0,0,-0.152400><0.586450,0.035000,0.152400> rotate<0,0.000000,0> translate<33.172397,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.172397,-1.535000,36.875312>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.439638,-1.535000,36.986006>}
box{<0,0,-0.152400><0.289259,0.035000,0.152400> rotate<0,-22.498343,0> translate<33.172397,-1.535000,36.875312> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.185644,-1.535000,36.880800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.063647,-1.535000,36.880800>}
box{<0,0,-0.152400><0.878003,0.035000,0.152400> rotate<0,0.000000,0> translate<33.185644,-1.535000,36.880800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.217006,-1.535000,44.165359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.431359,-1.535000,43.951006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<33.217006,-1.535000,44.165359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.217006,-1.535000,49.328637>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.235369,-1.535000,49.347000>}
box{<0,0,-0.152400><0.025968,0.035000,0.152400> rotate<0,-44.997030,0> translate<33.217006,-1.535000,49.328637> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.217006,-1.535000,49.365359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.235369,-1.535000,49.347000>}
box{<0,0,-0.152400><0.025966,0.035000,0.152400> rotate<0,44.992155,0> translate<33.217006,-1.535000,49.365359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.430925,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.810000,-1.535000,43.281600>}
box{<0,0,-0.152400><1.379075,0.035000,0.152400> rotate<0,0.000000,0> translate<33.430925,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.431359,-1.535000,43.951006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.711425,-1.535000,43.835000>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<33.431359,-1.535000,43.951006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.439638,-1.535000,36.986006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.653991,-1.535000,37.200359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<33.439638,-1.535000,36.986006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.439638,-1.535000,39.777991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.653991,-1.535000,39.563637>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<33.439638,-1.535000,39.777991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.439638,-1.535000,40.486006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.653991,-1.535000,40.700359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<33.439638,-1.535000,40.486006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.439638,-1.535000,43.277991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.643231,-1.535000,43.074397>}
box{<0,0,-0.152400><0.287925,0.035000,0.152400> rotate<0,44.997030,0> translate<33.439638,-1.535000,43.277991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.492031,-1.535000,40.538400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.810000,-1.535000,40.538400>}
box{<0,0,-0.152400><1.317969,0.035000,0.152400> rotate<0,0.000000,0> translate<33.492031,-1.535000,40.538400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.593628,-1.535000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,39.624000>}
box{<0,0,-0.152400><0.670972,0.035000,0.152400> rotate<0,0.000000,0> translate<33.593628,-1.535000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.639231,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,37.185600>}
box{<0,0,-0.152400><0.625369,0.035000,0.152400> rotate<0,0.000000,0> translate<33.639231,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.643231,-1.535000,43.074397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.810000,-1.535000,43.074397>}
box{<0,0,-0.152400><1.166769,0.035000,0.152400> rotate<0,0.000000,0> translate<33.643231,-1.535000,43.074397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.653991,-1.535000,37.200359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,37.480425>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<33.653991,-1.535000,37.200359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.653991,-1.535000,39.563637>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,39.283572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<33.653991,-1.535000,39.563637> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.653991,-1.535000,40.700359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,40.980425>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<33.653991,-1.535000,40.700359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.711425,-1.535000,43.835000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.810000,-1.535000,43.835000>}
box{<0,0,-0.152400><1.098575,0.035000,0.152400> rotate<0,0.000000,0> translate<33.711425,-1.535000,43.835000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.713156,-1.535000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.877363,-1.535000,40.843200>}
box{<0,0,-0.152400><1.164206,0.035000,0.152400> rotate<0,0.000000,0> translate<33.713156,-1.535000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.755241,-1.535000,39.319200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,39.319200>}
box{<0,0,-0.152400><0.509359,0.035000,0.152400> rotate<0,0.000000,0> translate<33.755241,-1.535000,39.319200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,37.480425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,39.283572>}
box{<0,0,-0.152400><1.803147,0.035000,0.152400> rotate<0,90.000000,0> translate<33.769997,-1.535000,39.283572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,37.490400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,37.490400>}
box{<0,0,-0.152400><0.494603,0.035000,0.152400> rotate<0,0.000000,0> translate<33.769997,-1.535000,37.490400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,37.795200>}
box{<0,0,-0.152400><0.494603,0.035000,0.152400> rotate<0,0.000000,0> translate<33.769997,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,38.100000>}
box{<0,0,-0.152400><0.494603,0.035000,0.152400> rotate<0,0.000000,0> translate<33.769997,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,38.404800>}
box{<0,0,-0.152400><0.494603,0.035000,0.152400> rotate<0,0.000000,0> translate<33.769997,-1.535000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,38.709600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,38.709600>}
box{<0,0,-0.152400><0.494603,0.035000,0.152400> rotate<0,0.000000,0> translate<33.769997,-1.535000,38.709600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,39.014400>}
box{<0,0,-0.152400><0.494603,0.035000,0.152400> rotate<0,0.000000,0> translate<33.769997,-1.535000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,40.980425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,41.245600>}
box{<0,0,-0.152400><0.265175,0.035000,0.152400> rotate<0,90.000000,0> translate<33.769997,-1.535000,41.245600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,41.148000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.113369,-1.535000,41.148000>}
box{<0,0,-0.152400><1.343372,0.035000,0.152400> rotate<0,0.000000,0> translate<33.769997,-1.535000,41.148000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<33.769997,-1.535000,41.245600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.310834,-1.535000,41.245600>}
box{<0,0,-0.152400><1.540837,0.035000,0.152400> rotate<0,0.000000,0> translate<33.769997,-1.535000,41.245600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,39.805884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,37.081756>}
box{<0,0,-0.152400><2.724128,0.035000,0.152400> rotate<0,-90.000000,0> translate<34.264600,-1.535000,37.081756> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.264600,-1.535000,39.805884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.403809,-1.535000,40.141966>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<34.264600,-1.535000,39.805884> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.403809,-1.535000,40.141966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.530809,-1.535000,40.268966>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<34.403809,-1.535000,40.141966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.530809,-1.535000,40.268966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.788031,-1.535000,40.526187>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,-44.997030,0> translate<34.530809,-1.535000,40.268966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.788031,-1.535000,40.526187>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.810000,-1.535000,40.535288>}
box{<0,0,-0.152400><0.023779,0.035000,0.152400> rotate<0,-22.499062,0> translate<34.788031,-1.535000,40.526187> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.810000,-1.535000,40.680572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.810000,-1.535000,40.535288>}
box{<0,0,-0.152400><0.145284,0.035000,0.152400> rotate<0,-90.000000,0> translate<34.810000,-1.535000,40.535288> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.810000,-1.535000,40.680572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.926006,-1.535000,40.960638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<34.810000,-1.535000,40.680572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.810000,-1.535000,43.835000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.810000,-1.535000,43.074397>}
box{<0,0,-0.152400><0.760603,0.035000,0.152400> rotate<0,-90.000000,0> translate<34.810000,-1.535000,43.074397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<34.926006,-1.535000,40.960638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.140359,-1.535000,41.174991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<34.926006,-1.535000,40.960638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.140359,-1.535000,41.174991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<35.310834,-1.535000,41.245600>}
box{<0,0,-0.152400><0.184519,0.035000,0.152400> rotate<0,-22.497459,0> translate<35.140359,-1.535000,41.174991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.551884,-1.535000,54.889397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.887966,-1.535000,54.750188>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,22.498510,0> translate<39.551884,-1.535000,54.889397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.613200,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.233600,-1.535000,54.864000>}
box{<0,0,-0.152400><0.620400,0.035000,0.152400> rotate<0,0.000000,0> translate<39.613200,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<39.887966,-1.535000,54.750188>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.145187,-1.535000,54.492966>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,44.997030,0> translate<39.887966,-1.535000,54.750188> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.078953,-1.535000,54.559200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.233600,-1.535000,54.559200>}
box{<0,0,-0.152400><0.154647,0.035000,0.152400> rotate<0,0.000000,0> translate<40.078953,-1.535000,54.559200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.145187,-1.535000,54.492966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.329934,-1.535000,54.308216>}
box{<0,0,-0.152400><0.261274,0.035000,0.152400> rotate<0,44.997515,0> translate<40.145187,-1.535000,54.492966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.233600,-1.535000,54.540784>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.329934,-1.535000,54.308216>}
box{<0,0,-0.152400><0.251731,0.035000,0.152400> rotate<0,67.495284,0> translate<40.233600,-1.535000,54.540784> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.233600,-1.535000,54.965600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.233600,-1.535000,54.540784>}
box{<0,0,-0.152400><0.424816,0.035000,0.152400> rotate<0,-90.000000,0> translate<40.233600,-1.535000,54.540784> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.233600,-1.535000,57.219213>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.233600,-1.535000,56.794397>}
box{<0,0,-0.152400><0.424816,0.035000,0.152400> rotate<0,-90.000000,0> translate<40.233600,-1.535000,56.794397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.233600,-1.535000,57.219213>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.500416,-1.535000,57.863366>}
box{<0,0,-0.152400><0.697226,0.035000,0.152400> rotate<0,-67.495647,0> translate<40.233600,-1.535000,57.219213> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.307550,-1.535000,35.585397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.653188,-1.535000,35.931031>}
box{<0,0,-0.152400><0.488803,0.035000,0.152400> rotate<0,-44.996771,0> translate<40.307550,-1.535000,35.585397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.307550,-1.535000,35.585397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.325600,-1.535000,35.585397>}
box{<0,0,-0.152400><2.018050,0.035000,0.152400> rotate<0,0.000000,0> translate<40.307550,-1.535000,35.585397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.383753,-1.535000,35.661600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.325600,-1.535000,35.661600>}
box{<0,0,-0.152400><1.941847,0.035000,0.152400> rotate<0,0.000000,0> translate<40.383753,-1.535000,35.661600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.500416,-1.535000,57.863366>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.993431,-1.535000,58.356381>}
box{<0,0,-0.152400><0.697229,0.035000,0.152400> rotate<0,-44.997030,0> translate<40.500416,-1.535000,57.863366> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.653188,-1.535000,35.931031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,36.267113>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<40.653188,-1.535000,35.931031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.667838,-1.535000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.325600,-1.535000,35.966400>}
box{<0,0,-0.152400><1.657762,0.035000,0.152400> rotate<0,0.000000,0> translate<40.667838,-1.535000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,36.267113>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,37.603600>}
box{<0,0,-0.152400><1.336487,0.035000,0.152400> rotate<0,90.000000,0> translate<40.792397,-1.535000,37.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,36.271200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.325600,-1.535000,36.271200>}
box{<0,0,-0.152400><1.533203,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,36.271200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.328000,-1.535000,36.576000>}
box{<0,0,-0.152400><1.535603,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,36.880800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.328000,-1.535000,36.880800>}
box{<0,0,-0.152400><1.535603,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,36.880800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.420797,-1.535000,37.185600>}
box{<0,0,-0.152400><1.628400,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,37.490400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.741434,-1.535000,37.490400>}
box{<0,0,-0.152400><1.949038,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,37.490400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,37.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,37.603600>}
box{<0,0,-0.152400><0.497584,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,37.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,50.698397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,53.604653>}
box{<0,0,-0.152400><2.906256,0.035000,0.152400> rotate<0,90.000000,0> translate<40.792397,-1.535000,53.604653> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,50.698397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.039241,-1.535000,50.698397>}
box{<0,0,-0.152400><1.246844,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,50.698397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,50.901600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.242444,-1.535000,50.901600>}
box{<0,0,-0.152400><1.450047,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,50.901600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.547244,-1.535000,51.206400>}
box{<0,0,-0.152400><1.754847,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,51.511200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.852044,-1.535000,51.511200>}
box{<0,0,-0.152400><2.059647,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,51.511200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.196000,-1.535000,51.816000>}
box{<0,0,-0.152400><3.403603,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,52.120800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.301900,-1.535000,52.120800>}
box{<0,0,-0.152400><3.509503,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,52.120800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.428341,-1.535000,52.425600>}
box{<0,0,-0.152400><3.635944,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,52.730400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.733141,-1.535000,52.730400>}
box{<0,0,-0.152400><3.940744,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,52.730400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.805600,-1.535000,53.035200>}
box{<0,0,-0.152400><4.013203,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.147013,-1.535000,53.340000>}
box{<0,0,-0.152400><0.354616,0.035000,0.152400> rotate<0,0.000000,0> translate<40.792397,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.792397,-1.535000,53.604653>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.993431,-1.535000,53.403616>}
box{<0,0,-0.152400><0.284308,0.035000,0.152400> rotate<0,44.997475,0> translate<40.792397,-1.535000,53.604653> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.993431,-1.535000,53.403616>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.637584,-1.535000,53.136800>}
box{<0,0,-0.152400><0.697226,0.035000,0.152400> rotate<0,22.498414,0> translate<40.993431,-1.535000,53.403616> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<40.993431,-1.535000,58.356381>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.637584,-1.535000,58.623197>}
box{<0,0,-0.152400><0.697226,0.035000,0.152400> rotate<0,-22.498414,0> translate<40.993431,-1.535000,58.356381> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,37.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,38.159966>}
box{<0,0,-0.152400><0.556366,0.035000,0.152400> rotate<0,90.000000,0> translate<41.289981,-1.535000,38.159966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,37.795200>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.100000>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,38.159966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.159966>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,38.159966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,38.160031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,38.659966>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,90.000000,0> translate<41.289981,-1.535000,38.659966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,38.160031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.160031>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,38.160031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.404800>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,38.659966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.659966>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,38.659966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,38.660031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,39.159966>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,90.000000,0> translate<41.289981,-1.535000,39.159966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,38.660031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.660031>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,38.660031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,38.709600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.709600>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,38.709600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,39.014400>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,39.159966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,39.159966>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,39.159966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,44.160031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,44.659966>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,90.000000,0> translate<41.289981,-1.535000,44.659966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,44.160031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,44.160031>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,44.160031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,44.196000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,44.196000>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,44.196000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,44.500800>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.289981,-1.535000,44.659966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,44.659966>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<41.289981,-1.535000,44.659966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,37.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.943503,-1.535000,37.603600>}
box{<0,0,-0.152400><0.653491,0.035000,0.152400> rotate<0,0.000000,0> translate<41.290013,-1.535000,37.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.159966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,37.603600>}
box{<0,0,-0.152400><0.556366,0.035000,0.152400> rotate<0,-90.000000,0> translate<41.290013,-1.535000,37.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.659966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.160031>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,-90.000000,0> translate<41.290013,-1.535000,38.160031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.716397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.660031>}
box{<0,0,-0.152400><0.056366,0.035000,0.152400> rotate<0,-90.000000,0> translate<41.290013,-1.535000,38.660031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,39.103600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,38.716397>}
box{<0,0,-0.152400><0.387203,0.035000,0.152400> rotate<0,-90.000000,0> translate<41.290013,-1.535000,38.716397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,39.159966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,39.103600>}
box{<0,0,-0.152400><0.056366,0.035000,0.152400> rotate<0,-90.000000,0> translate<41.290013,-1.535000,39.103600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,44.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,44.160031>}
box{<0,0,-0.152400><0.056366,0.035000,0.152400> rotate<0,-90.000000,0> translate<41.290013,-1.535000,44.160031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,44.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,44.216397>}
box{<0,0,-0.152400><0.387203,0.035000,0.152400> rotate<0,-90.000000,0> translate<41.290013,-1.535000,44.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,44.659966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.290013,-1.535000,44.603600>}
box{<0,0,-0.152400><0.056366,0.035000,0.152400> rotate<0,-90.000000,0> translate<41.290013,-1.535000,44.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.637584,-1.535000,53.136800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.334813,-1.535000,53.136800>}
box{<0,0,-0.152400><0.697228,0.035000,0.152400> rotate<0,0.000000,0> translate<41.637584,-1.535000,53.136800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.637584,-1.535000,58.623197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.334813,-1.535000,58.623197>}
box{<0,0,-0.152400><0.697228,0.035000,0.152400> rotate<0,0.000000,0> translate<41.637584,-1.535000,58.623197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<41.943503,-1.535000,37.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.046863,-1.535000,37.631294>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-14.998332,0> translate<41.943503,-1.535000,37.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.039241,-1.535000,50.698397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.658809,-1.535000,51.317966>}
box{<0,0,-0.152400><0.876203,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.039241,-1.535000,50.698397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.046863,-1.535000,37.631294>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.139534,-1.535000,37.684800>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-29.999002,0> translate<42.046863,-1.535000,37.631294> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096544,-1.535000,38.159981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096600,-1.535000,38.160013>}
box{<0,0,-0.152400><0.000064,0.035000,0.152400> rotate<0,-29.052687,0> translate<42.096544,-1.535000,38.159981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096544,-1.535000,38.159981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.159981>}
box{<0,0,-0.152400><0.199853,0.035000,0.152400> rotate<0,0.000000,0> translate<42.096544,-1.535000,38.159981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096575,-1.535000,38.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096603,-1.535000,38.660013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-23.960908,0> translate<42.096575,-1.535000,38.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096575,-1.535000,38.660000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096609,-1.535000,38.659981>}
box{<0,0,-0.152400><0.000039,0.035000,0.152400> rotate<0,28.608571,0> translate<42.096575,-1.535000,38.660000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096575,-1.535000,39.159997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096603,-1.535000,39.160013>}
box{<0,0,-0.152400><0.000032,0.035000,0.152400> rotate<0,-29.052687,0> translate<42.096575,-1.535000,39.159997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096575,-1.535000,39.159997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096606,-1.535000,39.159981>}
box{<0,0,-0.152400><0.000035,0.035000,0.152400> rotate<0,26.563298,0> translate<42.096575,-1.535000,39.159997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096575,-1.535000,44.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096603,-1.535000,44.160013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-23.960908,0> translate<42.096575,-1.535000,44.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096575,-1.535000,44.160000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096609,-1.535000,44.159981>}
box{<0,0,-0.152400><0.000039,0.035000,0.152400> rotate<0,28.608571,0> translate<42.096575,-1.535000,44.160000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096575,-1.535000,44.659997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096603,-1.535000,44.660013>}
box{<0,0,-0.152400><0.000032,0.035000,0.152400> rotate<0,-29.052687,0> translate<42.096575,-1.535000,44.659997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096575,-1.535000,44.659997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096606,-1.535000,44.659981>}
box{<0,0,-0.152400><0.000035,0.035000,0.152400> rotate<0,26.563298,0> translate<42.096575,-1.535000,44.659997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096600,-1.535000,38.160013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.160013>}
box{<0,0,-0.152400><0.199797,0.035000,0.152400> rotate<0,0.000000,0> translate<42.096600,-1.535000,38.160013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096603,-1.535000,38.660013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.660013>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,0.000000,0> translate<42.096603,-1.535000,38.660013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096603,-1.535000,39.160013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,39.160013>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,0.000000,0> translate<42.096603,-1.535000,39.160013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096603,-1.535000,44.160013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.160013>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,0.000000,0> translate<42.096603,-1.535000,44.160013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096603,-1.535000,44.660013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.660013>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,0.000000,0> translate<42.096603,-1.535000,44.660013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096606,-1.535000,39.159981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,39.159981>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,0.000000,0> translate<42.096606,-1.535000,39.159981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096606,-1.535000,44.659981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.659981>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,0.000000,0> translate<42.096606,-1.535000,44.659981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096609,-1.535000,38.659981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.659981>}
box{<0,0,-0.152400><0.199787,0.035000,0.152400> rotate<0,0.000000,0> translate<42.096609,-1.535000,38.659981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.096609,-1.535000,44.159981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.159981>}
box{<0,0,-0.152400><0.199787,0.035000,0.152400> rotate<0,0.000000,0> translate<42.096609,-1.535000,44.159981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.139534,-1.535000,37.684800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.215197,-1.535000,37.760463>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.139534,-1.535000,37.684800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.215197,-1.535000,37.760463>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.268703,-1.535000,37.853134>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-59.995058,0> translate<42.215197,-1.535000,37.760463> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.235253,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.354188,-1.535000,37.795200>}
box{<0,0,-0.152400><9.118934,0.035000,0.152400> rotate<0,0.000000,0> translate<42.235253,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.268703,-1.535000,37.853134>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,37.956494>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-74.995728,0> translate<42.268703,-1.535000,37.853134> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.283938,-1.535000,38.410000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.363503>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,74.994389,0> translate<42.283938,-1.535000,38.410000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.283938,-1.535000,38.410000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.456494>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,-74.993427,0> translate<42.283938,-1.535000,38.410000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.283938,-1.535000,38.909997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.863503>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,74.993427,0> translate<42.283938,-1.535000,38.909997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.283938,-1.535000,38.909997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.956494>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,-74.994389,0> translate<42.283938,-1.535000,38.909997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.283938,-1.535000,44.409997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.363503>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,74.993427,0> translate<42.283938,-1.535000,44.409997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.283938,-1.535000,44.409997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.456494>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,-74.994389,0> translate<42.283938,-1.535000,44.409997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.285331,-1.535000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,38.404800>}
box{<0,0,-0.152400><9.042669,0.035000,0.152400> rotate<0,0.000000,0> translate<42.285331,-1.535000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,37.956494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.159981>}
box{<0,0,-0.152400><0.203488,0.035000,0.152400> rotate<0,90.000000,0> translate<42.296397,-1.535000,38.159981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,38.100000>}
box{<0,0,-0.152400><9.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<42.296397,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.160013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.363503>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,90.000000,0> translate<42.296397,-1.535000,38.363503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.456494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.659981>}
box{<0,0,-0.152400><0.203488,0.035000,0.152400> rotate<0,90.000000,0> translate<42.296397,-1.535000,38.659981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.660013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.863503>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,90.000000,0> translate<42.296397,-1.535000,38.863503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.709600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,38.709600>}
box{<0,0,-0.152400><9.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<42.296397,-1.535000,38.709600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,38.956494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,39.159981>}
box{<0,0,-0.152400><0.203488,0.035000,0.152400> rotate<0,90.000000,0> translate<42.296397,-1.535000,39.159981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,39.014400>}
box{<0,0,-0.152400><9.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<42.296397,-1.535000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,39.160013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,39.353553>}
box{<0,0,-0.152400><0.193541,0.035000,0.152400> rotate<0,90.000000,0> translate<42.296397,-1.535000,39.353553> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,39.319200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,39.319200>}
box{<0,0,-0.152400><9.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<42.296397,-1.535000,39.319200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,39.353553>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.321638,-1.535000,39.364006>}
box{<0,0,-0.152400><0.027320,0.035000,0.152400> rotate<0,-22.494865,0> translate<42.296397,-1.535000,39.353553> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,43.966444>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.159981>}
box{<0,0,-0.152400><0.193537,0.035000,0.152400> rotate<0,90.000000,0> translate<42.296397,-1.535000,44.159981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,43.966444>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.321638,-1.535000,43.955991>}
box{<0,0,-0.152400><0.027320,0.035000,0.152400> rotate<0,22.494865,0> translate<42.296397,-1.535000,43.966444> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.160013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.363503>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,90.000000,0> translate<42.296397,-1.535000,44.363503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.196000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,44.196000>}
box{<0,0,-0.152400><9.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<42.296397,-1.535000,44.196000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.456494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.659981>}
box{<0,0,-0.152400><0.203488,0.035000,0.152400> rotate<0,90.000000,0> translate<42.296397,-1.535000,44.659981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,44.500800>}
box{<0,0,-0.152400><9.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<42.296397,-1.535000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.660013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.802559>}
box{<0,0,-0.152400><0.142547,0.035000,0.152400> rotate<0,90.000000,0> translate<42.296397,-1.535000,44.802559> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.296397,-1.535000,44.802559>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.494966,-1.535000,44.884809>}
box{<0,0,-0.152400><0.214929,0.035000,0.152400> rotate<0,-22.498547,0> translate<42.296397,-1.535000,44.802559> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.303738,-1.535000,44.805600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.787259,-1.535000,44.805600>}
box{<0,0,-0.152400><8.483522,0.035000,0.152400> rotate<0,0.000000,0> translate<42.303738,-1.535000,44.805600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.321638,-1.535000,39.364006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.535991,-1.535000,39.578359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.321638,-1.535000,39.364006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.321638,-1.535000,43.955991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.535991,-1.535000,43.741638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<42.321638,-1.535000,43.955991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.325600,-1.535000,36.391884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.325600,-1.535000,35.585397>}
box{<0,0,-0.152400><0.806488,0.035000,0.152400> rotate<0,-90.000000,0> translate<42.325600,-1.535000,35.585397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.325600,-1.535000,36.391884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.328000,-1.535000,36.397675>}
box{<0,0,-0.152400><0.006268,0.035000,0.152400> rotate<0,-67.483347,0> translate<42.325600,-1.535000,36.391884> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.328000,-1.535000,36.961572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.328000,-1.535000,36.397675>}
box{<0,0,-0.152400><0.563897,0.035000,0.152400> rotate<0,-90.000000,0> translate<42.328000,-1.535000,36.397675> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.328000,-1.535000,36.961572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.444006,-1.535000,37.241638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<42.328000,-1.535000,36.961572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.334813,-1.535000,53.136800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.978966,-1.535000,53.403616>}
box{<0,0,-0.152400><0.697226,0.035000,0.152400> rotate<0,-22.498414,0> translate<42.334813,-1.535000,53.136800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.334813,-1.535000,58.623197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.978966,-1.535000,58.356381>}
box{<0,0,-0.152400><0.697226,0.035000,0.152400> rotate<0,22.498414,0> translate<42.334813,-1.535000,58.623197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.367628,-1.535000,41.409997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.535991,-1.535000,41.241638>}
box{<0,0,-0.152400><0.238098,0.035000,0.152400> rotate<0,44.996498,0> translate<42.367628,-1.535000,41.409997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.367628,-1.535000,41.409997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.535991,-1.535000,41.578359>}
box{<0,0,-0.152400><0.238101,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.367628,-1.535000,41.409997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.386428,-1.535000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,43.891200>}
box{<0,0,-0.152400><8.941572,0.035000,0.152400> rotate<0,0.000000,0> translate<42.386428,-1.535000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.410431,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,41.452800>}
box{<0,0,-0.152400><8.917569,0.035000,0.152400> rotate<0,0.000000,0> translate<42.410431,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.444006,-1.535000,37.241638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.658359,-1.535000,37.455991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.444006,-1.535000,37.241638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.494966,-1.535000,44.884809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.935966,-1.535000,45.325809>}
box{<0,0,-0.152400><0.623668,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.494966,-1.535000,44.884809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.535991,-1.535000,39.578359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,39.858425>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<42.535991,-1.535000,39.578359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.535991,-1.535000,41.241638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,40.961572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<42.535991,-1.535000,41.241638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.535991,-1.535000,41.578359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,41.858425>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<42.535991,-1.535000,41.578359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.535991,-1.535000,43.741638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,43.461572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<42.535991,-1.535000,43.741638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.554894,-1.535000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,39.624000>}
box{<0,0,-0.152400><8.773106,0.035000,0.152400> rotate<0,0.000000,0> translate<42.554894,-1.535000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.574778,-1.535000,41.148000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,41.148000>}
box{<0,0,-0.152400><8.753222,0.035000,0.152400> rotate<0,0.000000,0> translate<42.574778,-1.535000,41.148000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.580091,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.396109,-1.535000,58.521600>}
box{<0,0,-0.152400><3.816019,0.035000,0.152400> rotate<0,0.000000,0> translate<42.580091,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.600294,-1.535000,43.586400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,43.586400>}
box{<0,0,-0.152400><8.727706,0.035000,0.152400> rotate<0,0.000000,0> translate<42.600294,-1.535000,43.586400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.610231,-1.535000,41.757600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,41.757600>}
box{<0,0,-0.152400><8.717769,0.035000,0.152400> rotate<0,0.000000,0> translate<42.610231,-1.535000,41.757600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,39.858425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,40.961572>}
box{<0,0,-0.152400><1.103147,0.035000,0.152400> rotate<0,90.000000,0> translate<42.651997,-1.535000,40.961572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,39.928800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,39.928800>}
box{<0,0,-0.152400><8.676003,0.035000,0.152400> rotate<0,0.000000,0> translate<42.651997,-1.535000,39.928800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,40.233600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.379703,-1.535000,40.233600>}
box{<0,0,-0.152400><8.727706,0.035000,0.152400> rotate<0,0.000000,0> translate<42.651997,-1.535000,40.233600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,40.538400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,40.538400>}
box{<0,0,-0.152400><8.676003,0.035000,0.152400> rotate<0,0.000000,0> translate<42.651997,-1.535000,40.538400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,40.843200>}
box{<0,0,-0.152400><8.676003,0.035000,0.152400> rotate<0,0.000000,0> translate<42.651997,-1.535000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,41.858425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,43.461572>}
box{<0,0,-0.152400><1.603147,0.035000,0.152400> rotate<0,90.000000,0> translate<42.651997,-1.535000,43.461572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,42.062400>}
box{<0,0,-0.152400><8.676003,0.035000,0.152400> rotate<0,0.000000,0> translate<42.651997,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,42.367200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,42.367200>}
box{<0,0,-0.152400><8.676003,0.035000,0.152400> rotate<0,0.000000,0> translate<42.651997,-1.535000,42.367200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,42.672000>}
box{<0,0,-0.152400><8.676003,0.035000,0.152400> rotate<0,0.000000,0> translate<42.651997,-1.535000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,42.976800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,42.976800>}
box{<0,0,-0.152400><8.676003,0.035000,0.152400> rotate<0,0.000000,0> translate<42.651997,-1.535000,42.976800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.651997,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,43.281600>}
box{<0,0,-0.152400><8.676003,0.035000,0.152400> rotate<0,0.000000,0> translate<42.651997,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.658359,-1.535000,37.455991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.938425,-1.535000,37.571997>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<42.658359,-1.535000,37.455991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.658809,-1.535000,51.317966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.916031,-1.535000,51.575188>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.658809,-1.535000,51.317966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.720556,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.370441,-1.535000,45.110400>}
box{<0,0,-0.152400><7.649884,0.035000,0.152400> rotate<0,0.000000,0> translate<42.720556,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.825381,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.805600,-1.535000,53.340000>}
box{<0,0,-0.152400><1.980219,0.035000,0.152400> rotate<0,0.000000,0> translate<42.825381,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.916031,-1.535000,51.575188>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.252113,-1.535000,51.714397>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-22.498510,0> translate<42.916031,-1.535000,51.575188> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.935966,-1.535000,45.325809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.193188,-1.535000,45.583031>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.935966,-1.535000,45.325809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.938425,-1.535000,37.571997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.541572,-1.535000,37.571997>}
box{<0,0,-0.152400><0.603147,0.035000,0.152400> rotate<0,0.000000,0> translate<42.938425,-1.535000,37.571997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.978966,-1.535000,53.403616>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.471981,-1.535000,53.896631>}
box{<0,0,-0.152400><0.697229,0.035000,0.152400> rotate<0,-44.997030,0> translate<42.978966,-1.535000,53.403616> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<42.978966,-1.535000,58.356381>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.471981,-1.535000,57.863366>}
box{<0,0,-0.152400><0.697229,0.035000,0.152400> rotate<0,44.997030,0> translate<42.978966,-1.535000,58.356381> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.025356,-1.535000,45.415200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.065641,-1.535000,45.415200>}
box{<0,0,-0.152400><7.040284,0.035000,0.152400> rotate<0,0.000000,0> translate<43.025356,-1.535000,45.415200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.118547,-1.535000,58.216800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.857650,-1.535000,58.216800>}
box{<0,0,-0.152400><2.739103,0.035000,0.152400> rotate<0,0.000000,0> translate<43.118547,-1.535000,58.216800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.193188,-1.535000,45.583031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.332397,-1.535000,45.919113>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<43.193188,-1.535000,45.583031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.220150,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.805600,-1.535000,53.644800>}
box{<0,0,-0.152400><1.585450,0.035000,0.152400> rotate<0,0.000000,0> translate<43.220150,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.249919,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.915469,-1.535000,45.720000>}
box{<0,0,-0.152400><6.665550,0.035000,0.152400> rotate<0,0.000000,0> translate<43.249919,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.252113,-1.535000,51.714397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.196000,-1.535000,51.714397>}
box{<0,0,-0.152400><0.943888,0.035000,0.152400> rotate<0,0.000000,0> translate<43.252113,-1.535000,51.714397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.332397,-1.535000,45.919113>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.332397,-1.535000,46.603600>}
box{<0,0,-0.152400><0.684487,0.035000,0.152400> rotate<0,90.000000,0> translate<43.332397,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.332397,-1.535000,46.024800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.885600,-1.535000,46.024800>}
box{<0,0,-0.152400><6.553203,0.035000,0.152400> rotate<0,0.000000,0> translate<43.332397,-1.535000,46.024800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.332397,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.241422,-1.535000,46.329600>}
box{<0,0,-0.152400><4.909025,0.035000,0.152400> rotate<0,0.000000,0> translate<43.332397,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.332397,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.443503,-1.535000,46.603600>}
box{<0,0,-0.152400><0.111106,0.035000,0.152400> rotate<0,0.000000,0> translate<43.332397,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.332397,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.332397,-1.535000,47.610013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<43.332397,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.332397,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.739966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.407569,0.035000,0.152400> rotate<0,0.000000,0> translate<43.332397,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.332397,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.683597,-1.535000,47.610013>}
box{<0,0,-0.152400><0.351200,0.035000,0.152400> rotate<0,0.000000,0> translate<43.332397,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.423347,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.552850,-1.535000,57.912000>}
box{<0,0,-0.152400><2.129503,0.035000,0.152400> rotate<0,0.000000,0> translate<43.423347,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.443503,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.489997,-1.535000,46.616059>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,-15.000634,0> translate<43.443503,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.471981,-1.535000,53.896631>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,54.540784>}
box{<0,0,-0.152400><0.697226,0.035000,0.152400> rotate<0,-67.495647,0> translate<43.471981,-1.535000,53.896631> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.471981,-1.535000,57.863366>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,57.219213>}
box{<0,0,-0.152400><0.697226,0.035000,0.152400> rotate<0,67.495647,0> translate<43.471981,-1.535000,57.863366> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.489997,-1.535000,46.616059>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.536494,-1.535000,46.603600>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,14.999671,0> translate<43.489997,-1.535000,46.616059> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.493919,-1.535000,53.949600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.805600,-1.535000,53.949600>}
box{<0,0,-0.152400><1.311681,0.035000,0.152400> rotate<0,0.000000,0> translate<43.493919,-1.535000,53.949600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.536494,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.739981,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<43.536494,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.541572,-1.535000,37.571997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.821638,-1.535000,37.455991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<43.541572,-1.535000,37.571997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.578091,-1.535000,57.607200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.398109,-1.535000,57.607200>}
box{<0,0,-0.152400><1.820019,0.035000,0.152400> rotate<0,0.000000,0> translate<43.578091,-1.535000,57.607200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.620172,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.805600,-1.535000,54.254400>}
box{<0,0,-0.152400><1.185428,0.035000,0.152400> rotate<0,0.000000,0> translate<43.620172,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.683597,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.739966,-1.535000,47.610013>}
box{<0,0,-0.152400><0.056369,0.035000,0.152400> rotate<0,0.000000,0> translate<43.683597,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.704341,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.271859,-1.535000,57.302400>}
box{<0,0,-0.152400><1.567519,0.035000,0.152400> rotate<0,0.000000,0> translate<43.704341,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738566,-1.535000,37.490400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.241434,-1.535000,37.490400>}
box{<0,0,-0.152400><2.502869,0.035000,0.152400> rotate<0,0.000000,0> translate<43.738566,-1.535000,37.490400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,54.540784>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,57.219213>}
box{<0,0,-0.152400><2.678428,0.035000,0.152400> rotate<0,90.000000,0> translate<43.738797,-1.535000,57.219213> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,54.559200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.805600,-1.535000,54.559200>}
box{<0,0,-0.152400><1.066803,0.035000,0.152400> rotate<0,0.000000,0> translate<43.738797,-1.535000,54.559200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.835472,-1.535000,54.864000>}
box{<0,0,-0.152400><1.096675,0.035000,0.152400> rotate<0,0.000000,0> translate<43.738797,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,55.168800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.985644,-1.535000,55.168800>}
box{<0,0,-0.152400><1.246847,0.035000,0.152400> rotate<0,0.000000,0> translate<43.738797,-1.535000,55.168800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.237400,-1.535000,55.473600>}
box{<0,0,-0.152400><1.498603,0.035000,0.152400> rotate<0,0.000000,0> translate<43.738797,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,55.778400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.237400,-1.535000,55.778400>}
box{<0,0,-0.152400><1.498603,0.035000,0.152400> rotate<0,0.000000,0> translate<43.738797,-1.535000,55.778400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.237400,-1.535000,56.083200>}
box{<0,0,-0.152400><1.498603,0.035000,0.152400> rotate<0,0.000000,0> translate<43.738797,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,56.388000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.237400,-1.535000,56.388000>}
box{<0,0,-0.152400><1.498603,0.035000,0.152400> rotate<0,0.000000,0> translate<43.738797,-1.535000,56.388000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.237400,-1.535000,56.692800>}
box{<0,0,-0.152400><1.498603,0.035000,0.152400> rotate<0,0.000000,0> translate<43.738797,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.738797,-1.535000,56.997600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.237400,-1.535000,56.997600>}
box{<0,0,-0.152400><1.498603,0.035000,0.152400> rotate<0,0.000000,0> translate<43.738797,-1.535000,56.997600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.739966,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.739966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<43.739966,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.739981,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.739981,-1.535000,46.803391>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<43.739981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.739981,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740012,-1.535000,46.634400>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<43.739981,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.739981,-1.535000,46.803391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.739997,-1.535000,46.803422>}
box{<0,0,-0.152400><0.000035,0.035000,0.152400> rotate<0,-63.430762,0> translate<43.739981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.739997,-1.535000,46.803422>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740012,-1.535000,46.803394>}
box{<0,0,-0.152400><0.000032,0.035000,0.152400> rotate<0,60.941374,0> translate<43.739997,-1.535000,46.803422> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740012,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.943503,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,0.000000,0> translate<43.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740012,-1.535000,46.803394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740012,-1.535000,46.603600>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,-90.000000,0> translate<43.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740031,-1.535000,47.610013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<43.740031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<43.740031,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.740031,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239966,-1.535000,47.610013>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<43.740031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.821638,-1.535000,37.455991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.035991,-1.535000,37.241638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<43.821638,-1.535000,37.455991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.943503,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.989997,-1.535000,46.616059>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,-15.000634,0> translate<43.943503,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<43.989997,-1.535000,46.616059>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.036494,-1.535000,46.603600>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,14.999671,0> translate<43.989997,-1.535000,46.616059> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.035991,-1.535000,37.241638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.046444,-1.535000,37.216397>}
box{<0,0,-0.152400><0.027320,0.035000,0.152400> rotate<0,67.499196,0> translate<44.035991,-1.535000,37.241638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.036494,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239981,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<44.036494,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.046444,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239981,-1.535000,37.216397>}
box{<0,0,-0.152400><0.193537,0.035000,0.152400> rotate<0,0.000000,0> translate<44.046444,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.196000,-1.535000,51.865141>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.196000,-1.535000,51.714397>}
box{<0,0,-0.152400><0.150744,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.196000,-1.535000,51.714397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.196000,-1.535000,51.865141>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.428016,-1.535000,52.425275>}
box{<0,0,-0.152400><0.606285,0.035000,0.152400> rotate<0,-67.495513,0> translate<44.196000,-1.535000,51.865141> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239966,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.239966,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239981,-1.535000,37.016606>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239981,-1.535000,37.216397>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<44.239981,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239981,-1.535000,37.016606>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240000,-1.535000,37.016575>}
box{<0,0,-0.152400><0.000036,0.035000,0.152400> rotate<0,59.032347,0> translate<44.239981,-1.535000,37.016606> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239981,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240012,-1.535000,37.185600>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<44.239981,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239981,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239981,-1.535000,46.803391>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<44.239981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239981,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240012,-1.535000,46.634400>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<44.239981,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.239981,-1.535000,46.803391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240000,-1.535000,46.803422>}
box{<0,0,-0.152400><0.000036,0.035000,0.152400> rotate<0,-59.032347,0> translate<44.239981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240000,-1.535000,37.016575>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240012,-1.535000,37.016603>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-66.033153,0> translate<44.240000,-1.535000,37.016575> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240000,-1.535000,46.803422>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240012,-1.535000,46.803397>}
box{<0,0,-0.152400><0.000028,0.035000,0.152400> rotate<0,63.430762,0> translate<44.240000,-1.535000,46.803422> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240012,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240012,-1.535000,37.016603>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.240012,-1.535000,37.016603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240012,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.443503,-1.535000,37.216397>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,0.000000,0> translate<44.240012,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240012,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.443503,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,0.000000,0> translate<44.240012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240012,-1.535000,46.803397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240012,-1.535000,46.603600>}
box{<0,0,-0.152400><0.199797,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.240012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240031,-1.535000,36.209981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240031,-1.535000,36.210013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<44.240031,-1.535000,36.210013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240031,-1.535000,36.209981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739966,-1.535000,36.209981>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<44.240031,-1.535000,36.209981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240031,-1.535000,36.210013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.296394,-1.535000,36.210013>}
box{<0,0,-0.152400><0.056362,0.035000,0.152400> rotate<0,0.000000,0> translate<44.240031,-1.535000,36.210013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240031,-1.535000,47.610013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<44.240031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<44.240031,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.240031,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739966,-1.535000,47.610013>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<44.240031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.296394,-1.535000,36.210013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739966,-1.535000,36.210013>}
box{<0,0,-0.152400><0.443572,0.035000,0.152400> rotate<0,0.000000,0> translate<44.296394,-1.535000,36.210013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.428016,-1.535000,52.425275>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.805600,-1.535000,52.802859>}
box{<0,0,-0.152400><0.533985,0.035000,0.152400> rotate<0,-44.997030,0> translate<44.428016,-1.535000,52.425275> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.443503,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.490000,-1.535000,37.203938>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,14.999671,0> translate<44.443503,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.443503,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.490000,-1.535000,46.616059>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,-14.999671,0> translate<44.443503,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.490000,-1.535000,37.203938>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.536494,-1.535000,37.216397>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,-15.000634,0> translate<44.490000,-1.535000,37.203938> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.490000,-1.535000,46.616059>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.536494,-1.535000,46.603600>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,15.000634,0> translate<44.490000,-1.535000,46.616059> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.536494,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739981,-1.535000,37.216397>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<44.536494,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.536494,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739981,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<44.536494,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739966,-1.535000,36.210013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739966,-1.535000,36.209981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.739966,-1.535000,36.209981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739966,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.739966,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739981,-1.535000,37.016606>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739981,-1.535000,37.216397>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<44.739981,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739981,-1.535000,37.016606>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740000,-1.535000,37.016575>}
box{<0,0,-0.152400><0.000036,0.035000,0.152400> rotate<0,59.032347,0> translate<44.739981,-1.535000,37.016606> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739981,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740012,-1.535000,37.185600>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<44.739981,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739981,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739981,-1.535000,46.803387>}
box{<0,0,-0.152400><0.199787,0.035000,0.152400> rotate<0,90.000000,0> translate<44.739981,-1.535000,46.803387> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739981,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740012,-1.535000,46.634400>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<44.739981,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.739981,-1.535000,46.803387>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740000,-1.535000,46.803422>}
box{<0,0,-0.152400><0.000039,0.035000,0.152400> rotate<0,-61.385489,0> translate<44.739981,-1.535000,46.803387> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740000,-1.535000,37.016575>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740012,-1.535000,37.016603>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-66.033153,0> translate<44.740000,-1.535000,37.016575> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740000,-1.535000,46.803422>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740012,-1.535000,46.803397>}
box{<0,0,-0.152400><0.000028,0.035000,0.152400> rotate<0,63.430762,0> translate<44.740000,-1.535000,46.803422> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740012,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740012,-1.535000,37.016603>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.740012,-1.535000,37.016603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740012,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.943503,-1.535000,37.216397>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,0.000000,0> translate<44.740012,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740012,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.943503,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,0.000000,0> translate<44.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740012,-1.535000,46.803397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740012,-1.535000,46.603600>}
box{<0,0,-0.152400><0.199797,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740031,-1.535000,36.209981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740031,-1.535000,36.210013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<44.740031,-1.535000,36.210013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740031,-1.535000,36.209981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239966,-1.535000,36.209981>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<44.740031,-1.535000,36.209981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740031,-1.535000,36.210013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.796394,-1.535000,36.210013>}
box{<0,0,-0.152400><0.056362,0.035000,0.152400> rotate<0,0.000000,0> translate<44.740031,-1.535000,36.210013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740031,-1.535000,47.610013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<44.740031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<44.740031,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.740031,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239966,-1.535000,47.610013>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<44.740031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.796394,-1.535000,36.210013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239966,-1.535000,36.210013>}
box{<0,0,-0.152400><0.443572,0.035000,0.152400> rotate<0,0.000000,0> translate<44.796394,-1.535000,36.210013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.805600,-1.535000,54.791884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.805600,-1.535000,52.802859>}
box{<0,0,-0.152400><1.989025,0.035000,0.152400> rotate<0,-90.000000,0> translate<44.805600,-1.535000,52.802859> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.805600,-1.535000,54.791884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.944809,-1.535000,55.127966>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<44.805600,-1.535000,54.791884> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.943503,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.990000,-1.535000,37.203938>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,14.999671,0> translate<44.943503,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.943503,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.990000,-1.535000,46.616059>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,-14.999671,0> translate<44.943503,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.944809,-1.535000,55.127966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.237400,-1.535000,55.420556>}
box{<0,0,-0.152400><0.413786,0.035000,0.152400> rotate<0,-44.997030,0> translate<44.944809,-1.535000,55.127966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.990000,-1.535000,37.203938>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.036494,-1.535000,37.216397>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,-15.000634,0> translate<44.990000,-1.535000,37.203938> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<44.990000,-1.535000,46.616059>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.036494,-1.535000,46.603600>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,15.000634,0> translate<44.990000,-1.535000,46.616059> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.036494,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239981,-1.535000,37.216397>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<45.036494,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.036494,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239981,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<45.036494,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.237400,-1.535000,57.219213>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.237400,-1.535000,55.420556>}
box{<0,0,-0.152400><1.798656,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.237400,-1.535000,55.420556> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.237400,-1.535000,57.219213>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.504216,-1.535000,57.863366>}
box{<0,0,-0.152400><0.697226,0.035000,0.152400> rotate<0,-67.495647,0> translate<45.237400,-1.535000,57.219213> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239966,-1.535000,36.210013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239966,-1.535000,36.209981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.239966,-1.535000,36.209981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239966,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.239966,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239981,-1.535000,37.016606>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239981,-1.535000,37.216397>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<45.239981,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239981,-1.535000,37.016606>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240000,-1.535000,37.016575>}
box{<0,0,-0.152400><0.000036,0.035000,0.152400> rotate<0,59.032347,0> translate<45.239981,-1.535000,37.016606> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239981,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240012,-1.535000,37.185600>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<45.239981,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239981,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239981,-1.535000,46.803387>}
box{<0,0,-0.152400><0.199787,0.035000,0.152400> rotate<0,90.000000,0> translate<45.239981,-1.535000,46.803387> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239981,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240012,-1.535000,46.634400>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<45.239981,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.239981,-1.535000,46.803387>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240000,-1.535000,46.803422>}
box{<0,0,-0.152400><0.000039,0.035000,0.152400> rotate<0,-61.385489,0> translate<45.239981,-1.535000,46.803387> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240000,-1.535000,37.016575>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240012,-1.535000,37.016600>}
box{<0,0,-0.152400><0.000028,0.035000,0.152400> rotate<0,-63.430762,0> translate<45.240000,-1.535000,37.016575> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240000,-1.535000,46.803422>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240012,-1.535000,46.803394>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,66.033153,0> translate<45.240000,-1.535000,46.803422> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240012,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240012,-1.535000,37.016600>}
box{<0,0,-0.152400><0.199797,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.240012,-1.535000,37.016600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240012,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.443503,-1.535000,37.216397>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,0.000000,0> translate<45.240012,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240012,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.443503,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,0.000000,0> translate<45.240012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240012,-1.535000,46.803394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240012,-1.535000,46.603600>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.240012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240031,-1.535000,36.209981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240031,-1.535000,36.210013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<45.240031,-1.535000,36.210013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240031,-1.535000,36.209981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739966,-1.535000,36.209981>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<45.240031,-1.535000,36.209981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240031,-1.535000,36.210013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.296394,-1.535000,36.210013>}
box{<0,0,-0.152400><0.056362,0.035000,0.152400> rotate<0,0.000000,0> translate<45.240031,-1.535000,36.210013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240031,-1.535000,47.610013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<45.240031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.296397,-1.535000,47.609981>}
box{<0,0,-0.152400><0.056366,0.035000,0.152400> rotate<0,0.000000,0> translate<45.240031,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.240031,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739966,-1.535000,47.610013>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<45.240031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.296394,-1.535000,36.210013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739966,-1.535000,36.210013>}
box{<0,0,-0.152400><0.443572,0.035000,0.152400> rotate<0,0.000000,0> translate<45.296394,-1.535000,36.210013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.296397,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.683600,-1.535000,47.609981>}
box{<0,0,-0.152400><0.387203,0.035000,0.152400> rotate<0,0.000000,0> translate<45.296397,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.443503,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.490000,-1.535000,37.203938>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,14.999671,0> translate<45.443503,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.443503,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.489997,-1.535000,46.616059>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,-15.000634,0> translate<45.443503,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.489997,-1.535000,46.616059>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.536494,-1.535000,46.603600>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,14.999671,0> translate<45.489997,-1.535000,46.616059> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.490000,-1.535000,37.203938>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.536494,-1.535000,37.216397>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,-15.000634,0> translate<45.490000,-1.535000,37.203938> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.504216,-1.535000,57.863366>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.997231,-1.535000,58.356381>}
box{<0,0,-0.152400><0.697229,0.035000,0.152400> rotate<0,-44.997030,0> translate<45.504216,-1.535000,57.863366> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.536494,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739981,-1.535000,37.216397>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<45.536494,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.536494,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739981,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<45.536494,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.683600,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.056366,0.035000,0.152400> rotate<0,0.000000,0> translate<45.683600,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739966,-1.535000,36.210013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739966,-1.535000,36.209981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.739966,-1.535000,36.209981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739966,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.739966,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739981,-1.535000,37.016606>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739981,-1.535000,37.216397>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<45.739981,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739981,-1.535000,37.016606>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740000,-1.535000,37.016575>}
box{<0,0,-0.152400><0.000036,0.035000,0.152400> rotate<0,59.032347,0> translate<45.739981,-1.535000,37.016606> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739981,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740012,-1.535000,37.185600>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<45.739981,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739981,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739981,-1.535000,46.803391>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<45.739981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739981,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740012,-1.535000,46.634400>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<45.739981,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739981,-1.535000,46.803391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739997,-1.535000,46.803422>}
box{<0,0,-0.152400><0.000035,0.035000,0.152400> rotate<0,-63.430762,0> translate<45.739981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.739997,-1.535000,46.803422>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740012,-1.535000,46.803394>}
box{<0,0,-0.152400><0.000032,0.035000,0.152400> rotate<0,60.941374,0> translate<45.739997,-1.535000,46.803422> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740000,-1.535000,37.016575>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740012,-1.535000,37.016600>}
box{<0,0,-0.152400><0.000028,0.035000,0.152400> rotate<0,-63.430762,0> translate<45.740000,-1.535000,37.016575> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740012,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740012,-1.535000,37.016600>}
box{<0,0,-0.152400><0.199797,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.740012,-1.535000,37.016600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740012,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.933553,-1.535000,37.216397>}
box{<0,0,-0.152400><0.193541,0.035000,0.152400> rotate<0,0.000000,0> translate<45.740012,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740012,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.943503,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,0.000000,0> translate<45.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740012,-1.535000,46.803394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740012,-1.535000,46.603600>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,-90.000000,0> translate<45.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740031,-1.535000,47.610013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<45.740031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.183600,-1.535000,47.609981>}
box{<0,0,-0.152400><0.443569,0.035000,0.152400> rotate<0,0.000000,0> translate<45.740031,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.740031,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.239966,-1.535000,47.610013>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<45.740031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.933553,-1.535000,37.216397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.944006,-1.535000,37.241638>}
box{<0,0,-0.152400><0.027320,0.035000,0.152400> rotate<0,-67.499196,0> translate<45.933553,-1.535000,37.216397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.943503,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.989997,-1.535000,46.616059>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,-15.000634,0> translate<45.943503,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.944006,-1.535000,37.241638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.158359,-1.535000,37.455991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<45.944006,-1.535000,37.241638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.989997,-1.535000,46.616059>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.036494,-1.535000,46.603600>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,14.999671,0> translate<45.989997,-1.535000,46.616059> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<45.997231,-1.535000,58.356381>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.641384,-1.535000,58.623197>}
box{<0,0,-0.152400><0.697226,0.035000,0.152400> rotate<0,-22.498414,0> translate<45.997231,-1.535000,58.356381> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.036494,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.239981,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<46.036494,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.158359,-1.535000,37.455991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.438425,-1.535000,37.571997>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<46.158359,-1.535000,37.455991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.183600,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.239966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.056366,0.035000,0.152400> rotate<0,0.000000,0> translate<46.183600,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.239966,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.239966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<46.239966,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.239981,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.239981,-1.535000,46.803391>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<46.239981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.239981,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240012,-1.535000,46.634400>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<46.239981,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.239981,-1.535000,46.803391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.239997,-1.535000,46.803422>}
box{<0,0,-0.152400><0.000035,0.035000,0.152400> rotate<0,-63.430762,0> translate<46.239981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.239997,-1.535000,46.803422>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240012,-1.535000,46.803394>}
box{<0,0,-0.152400><0.000032,0.035000,0.152400> rotate<0,60.941374,0> translate<46.239997,-1.535000,46.803422> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240012,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.443503,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,0.000000,0> translate<46.240012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240012,-1.535000,46.803394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240012,-1.535000,46.603600>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,-90.000000,0> translate<46.240012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240031,-1.535000,47.610013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<46.240031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.683600,-1.535000,47.609981>}
box{<0,0,-0.152400><0.443569,0.035000,0.152400> rotate<0,0.000000,0> translate<46.240031,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.240031,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.739966,-1.535000,47.610013>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<46.240031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.438425,-1.535000,37.571997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.041572,-1.535000,37.571997>}
box{<0,0,-0.152400><3.603147,0.035000,0.152400> rotate<0,0.000000,0> translate<46.438425,-1.535000,37.571997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.443503,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.489997,-1.535000,46.616059>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,-15.000634,0> translate<46.443503,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.489997,-1.535000,46.616059>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.536494,-1.535000,46.603600>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,14.999671,0> translate<46.489997,-1.535000,46.616059> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.536494,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.739981,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<46.536494,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.641384,-1.535000,58.623197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.338613,-1.535000,58.623197>}
box{<0,0,-0.152400><0.697228,0.035000,0.152400> rotate<0,0.000000,0> translate<46.641384,-1.535000,58.623197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.683600,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.739966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.056366,0.035000,0.152400> rotate<0,0.000000,0> translate<46.683600,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.739966,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.739966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<46.739966,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.739981,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.739981,-1.535000,46.803391>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<46.739981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.739981,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740012,-1.535000,46.634400>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<46.739981,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.739981,-1.535000,46.803391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.739997,-1.535000,46.803422>}
box{<0,0,-0.152400><0.000035,0.035000,0.152400> rotate<0,-63.430762,0> translate<46.739981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.739997,-1.535000,46.803422>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740012,-1.535000,46.803394>}
box{<0,0,-0.152400><0.000032,0.035000,0.152400> rotate<0,60.941374,0> translate<46.739997,-1.535000,46.803422> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740012,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.943503,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,0.000000,0> translate<46.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740012,-1.535000,46.803394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740012,-1.535000,46.603600>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,-90.000000,0> translate<46.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740031,-1.535000,47.610013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<46.740031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.183600,-1.535000,47.609981>}
box{<0,0,-0.152400><0.443569,0.035000,0.152400> rotate<0,0.000000,0> translate<46.740031,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.740031,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.239966,-1.535000,47.610013>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<46.740031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.943503,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.989997,-1.535000,46.616059>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,-15.000634,0> translate<46.943503,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<46.989997,-1.535000,46.616059>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.036494,-1.535000,46.603600>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,14.999671,0> translate<46.989997,-1.535000,46.616059> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.036494,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.239981,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<47.036494,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.183600,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.239966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.056366,0.035000,0.152400> rotate<0,0.000000,0> translate<47.183600,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.239966,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.239966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<47.239966,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.239981,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.239981,-1.535000,46.803391>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<47.239981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.239981,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240012,-1.535000,46.634400>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<47.239981,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.239981,-1.535000,46.803391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.239997,-1.535000,46.803422>}
box{<0,0,-0.152400><0.000035,0.035000,0.152400> rotate<0,-63.430762,0> translate<47.239981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.239997,-1.535000,46.803422>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240012,-1.535000,46.803394>}
box{<0,0,-0.152400><0.000032,0.035000,0.152400> rotate<0,60.941374,0> translate<47.239997,-1.535000,46.803422> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240012,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.443503,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203491,0.035000,0.152400> rotate<0,0.000000,0> translate<47.240012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240012,-1.535000,46.803394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240012,-1.535000,46.603600>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,-90.000000,0> translate<47.240012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240031,-1.535000,47.610013>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,90.000000,0> translate<47.240031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240031,-1.535000,47.609981>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.739966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<47.240031,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.240031,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.739966,-1.535000,47.610013>}
box{<0,0,-0.152400><0.499934,0.035000,0.152400> rotate<0,0.000000,0> translate<47.240031,-1.535000,47.610013> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.338613,-1.535000,58.623197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.982766,-1.535000,58.356381>}
box{<0,0,-0.152400><0.697226,0.035000,0.152400> rotate<0,22.498414,0> translate<47.338613,-1.535000,58.623197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.443503,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.489997,-1.535000,46.616059>}
box{<0,0,-0.152400><0.048134,0.035000,0.152400> rotate<0,-15.000634,0> translate<47.443503,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.489997,-1.535000,46.616059>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.536494,-1.535000,46.603600>}
box{<0,0,-0.152400><0.048137,0.035000,0.152400> rotate<0,14.999671,0> translate<47.489997,-1.535000,46.616059> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.536494,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.739981,-1.535000,46.603600>}
box{<0,0,-0.152400><0.203487,0.035000,0.152400> rotate<0,0.000000,0> translate<47.536494,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.583891,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.100444,-1.535000,58.521600>}
box{<0,0,-0.152400><1.516553,0.035000,0.152400> rotate<0,0.000000,0> translate<47.583891,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.739966,-1.535000,47.610013>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.739966,-1.535000,47.609981>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,-90.000000,0> translate<47.739966,-1.535000,47.609981> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.739981,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.739981,-1.535000,46.803391>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<47.739981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.739981,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740012,-1.535000,46.634400>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<47.739981,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.739981,-1.535000,46.803391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740000,-1.535000,46.803422>}
box{<0,0,-0.152400><0.000036,0.035000,0.152400> rotate<0,-59.032347,0> translate<47.739981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740000,-1.535000,46.803422>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740012,-1.535000,46.803397>}
box{<0,0,-0.152400><0.000028,0.035000,0.152400> rotate<0,63.430762,0> translate<47.740000,-1.535000,46.803422> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740012,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.933553,-1.535000,46.603600>}
box{<0,0,-0.152400><0.193541,0.035000,0.152400> rotate<0,0.000000,0> translate<47.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740012,-1.535000,46.803397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.740012,-1.535000,46.603600>}
box{<0,0,-0.152400><0.199797,0.035000,0.152400> rotate<0,-90.000000,0> translate<47.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.933553,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.944006,-1.535000,46.578359>}
box{<0,0,-0.152400><0.027320,0.035000,0.152400> rotate<0,67.499196,0> translate<47.933553,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.944006,-1.535000,46.578359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.158359,-1.535000,46.364006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<47.944006,-1.535000,46.578359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<47.982766,-1.535000,58.356381>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.475781,-1.535000,57.863366>}
box{<0,0,-0.152400><0.697229,0.035000,0.152400> rotate<0,44.997030,0> translate<47.982766,-1.535000,58.356381> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.122347,-1.535000,58.216800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.795644,-1.535000,58.216800>}
box{<0,0,-0.152400><0.673297,0.035000,0.152400> rotate<0,0.000000,0> translate<48.122347,-1.535000,58.216800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.158359,-1.535000,46.364006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.438425,-1.535000,46.248000>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<48.158359,-1.535000,46.364006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.427147,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.571078,-1.535000,57.912000>}
box{<0,0,-0.152400><0.143931,0.035000,0.152400> rotate<0,0.000000,0> translate<48.427147,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.438425,-1.535000,46.248000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.041572,-1.535000,46.248000>}
box{<0,0,-0.152400><0.603147,0.035000,0.152400> rotate<0,0.000000,0> translate<48.438425,-1.535000,46.248000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.475781,-1.535000,57.863366>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.513356,-1.535000,57.772647>}
box{<0,0,-0.152400><0.098193,0.035000,0.152400> rotate<0,67.496589,0> translate<48.475781,-1.535000,57.863366> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.513356,-1.535000,57.772647>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.627809,-1.535000,58.048966>}
box{<0,0,-0.152400><0.299085,0.035000,0.152400> rotate<0,-67.495872,0> translate<48.513356,-1.535000,57.772647> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.627809,-1.535000,58.048966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.643809,-1.535000,59.064966>}
box{<0,0,-0.152400><1.436841,0.035000,0.152400> rotate<0,-44.997030,0> translate<48.627809,-1.535000,58.048966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.729178,-1.535000,54.508397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.742597,-1.535000,54.540784>}
box{<0,0,-0.152400><0.035057,0.035000,0.152400> rotate<0,-67.490399,0> translate<48.729178,-1.535000,54.508397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.729178,-1.535000,54.508397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.648706,-1.535000,54.508397>}
box{<0,0,-0.152400><1.919528,0.035000,0.152400> rotate<0,0.000000,0> translate<48.729178,-1.535000,54.508397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.742597,-1.535000,54.540784>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.742597,-1.535000,54.965600>}
box{<0,0,-0.152400><0.424816,0.035000,0.152400> rotate<0,90.000000,0> translate<48.742597,-1.535000,54.965600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.742597,-1.535000,54.559200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.632194,-1.535000,54.559200>}
box{<0,0,-0.152400><1.889597,0.035000,0.152400> rotate<0,0.000000,0> translate<48.742597,-1.535000,54.559200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.742597,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,54.864000>}
box{<0,0,-0.152400><1.854203,0.035000,0.152400> rotate<0,0.000000,0> translate<48.742597,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<48.742597,-1.535000,54.965600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.457884,-1.535000,54.965600>}
box{<0,0,-0.152400><0.715287,0.035000,0.152400> rotate<0,0.000000,0> translate<48.742597,-1.535000,54.965600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.041572,-1.535000,46.248000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.321638,-1.535000,46.364006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<49.041572,-1.535000,46.248000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.238572,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.885600,-1.535000,46.329600>}
box{<0,0,-0.152400><0.647028,0.035000,0.152400> rotate<0,0.000000,0> translate<49.238572,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.321638,-1.535000,46.364006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.535991,-1.535000,46.578359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.321638,-1.535000,46.364006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.457884,-1.535000,54.965600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.793966,-1.535000,55.104809>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-22.498510,0> translate<49.457884,-1.535000,54.965600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.535991,-1.535000,46.578359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.546444,-1.535000,46.603600>}
box{<0,0,-0.152400><0.027320,0.035000,0.152400> rotate<0,-67.499196,0> translate<49.535991,-1.535000,46.578359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.546444,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.739981,-1.535000,46.603600>}
box{<0,0,-0.152400><0.193537,0.035000,0.152400> rotate<0,0.000000,0> translate<49.546444,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.643809,-1.535000,59.064966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.901031,-1.535000,59.322188>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.643809,-1.535000,59.064966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.739981,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.739981,-1.535000,46.803391>}
box{<0,0,-0.152400><0.199791,0.035000,0.152400> rotate<0,90.000000,0> translate<49.739981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.739981,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.740012,-1.535000,46.634400>}
box{<0,0,-0.152400><0.000031,0.035000,0.152400> rotate<0,0.000000,0> translate<49.739981,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.739981,-1.535000,46.803391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.739997,-1.535000,46.803422>}
box{<0,0,-0.152400><0.000035,0.035000,0.152400> rotate<0,-63.430762,0> translate<49.739981,-1.535000,46.803391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.739997,-1.535000,46.803422>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.740012,-1.535000,46.803394>}
box{<0,0,-0.152400><0.000032,0.035000,0.152400> rotate<0,60.941374,0> translate<49.739997,-1.535000,46.803422> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.740012,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.885600,-1.535000,46.603600>}
box{<0,0,-0.152400><0.145588,0.035000,0.152400> rotate<0,0.000000,0> translate<49.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.740012,-1.535000,46.803394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.740012,-1.535000,46.603600>}
box{<0,0,-0.152400><0.199794,0.035000,0.152400> rotate<0,-90.000000,0> translate<49.740012,-1.535000,46.603600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.793966,-1.535000,55.104809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.920966,-1.535000,55.231809>}
box{<0,0,-0.152400><0.179605,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.793966,-1.535000,55.104809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.857956,-1.535000,55.168800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,55.168800>}
box{<0,0,-0.152400><0.738844,0.035000,0.152400> rotate<0,0.000000,0> translate<49.857956,-1.535000,55.168800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.885600,-1.535000,45.792113>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.024809,-1.535000,45.456031>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,67.495551,0> translate<49.885600,-1.535000,45.792113> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.885600,-1.535000,46.603600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.885600,-1.535000,45.792113>}
box{<0,0,-0.152400><0.811487,0.035000,0.152400> rotate<0,-90.000000,0> translate<49.885600,-1.535000,45.792113> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.901031,-1.535000,59.322188>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.237113,-1.535000,59.461397>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-22.498510,0> translate<49.901031,-1.535000,59.322188> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<49.920966,-1.535000,55.231809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.178187,-1.535000,55.489031>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,-44.997030,0> translate<49.920966,-1.535000,55.231809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.024809,-1.535000,45.456031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.282031,-1.535000,45.198809>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,44.997030,0> translate<50.024809,-1.535000,45.456031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.041572,-1.535000,37.571997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.240000,-1.535000,37.489806>}
box{<0,0,-0.152400><0.214777,0.035000,0.152400> rotate<0,22.498270,0> translate<50.041572,-1.535000,37.571997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.162756,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,55.473600>}
box{<0,0,-0.152400><0.434044,0.035000,0.152400> rotate<0,0.000000,0> translate<50.162756,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.178187,-1.535000,55.489031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.317397,-1.535000,55.825113>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<50.178187,-1.535000,55.489031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.237113,-1.535000,59.461397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.951884,-1.535000,59.461397>}
box{<0,0,-0.152400><14.714772,0.035000,0.152400> rotate<0,0.000000,0> translate<50.237113,-1.535000,59.461397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.238569,-1.535000,37.490400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.241434,-1.535000,37.490400>}
box{<0,0,-0.152400><0.002866,0.035000,0.152400> rotate<0,0.000000,0> translate<50.238569,-1.535000,37.490400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.240000,-1.535000,37.489806>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.438425,-1.535000,37.571997>}
box{<0,0,-0.152400><0.214774,0.035000,0.152400> rotate<0,-22.498589,0> translate<50.240000,-1.535000,37.489806> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.282031,-1.535000,45.198809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.282034,-1.535000,45.198809>}
box{<0,0,-0.152400><0.000003,0.035000,0.152400> rotate<0,0.000000,0> translate<50.282031,-1.535000,45.198809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.282034,-1.535000,45.198809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596031,-1.535000,44.884809>}
box{<0,0,-0.152400><0.444061,0.035000,0.152400> rotate<0,44.997315,0> translate<50.282034,-1.535000,45.198809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.298047,-1.535000,55.778400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.841384,-1.535000,55.778400>}
box{<0,0,-0.152400><1.543337,0.035000,0.152400> rotate<0,0.000000,0> translate<50.298047,-1.535000,55.778400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.317397,-1.535000,55.825113>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.317397,-1.535000,57.152241>}
box{<0,0,-0.152400><1.327128,0.035000,0.152400> rotate<0,90.000000,0> translate<50.317397,-1.535000,57.152241> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.317397,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,56.083200>}
box{<0,0,-0.152400><0.279403,0.035000,0.152400> rotate<0,0.000000,0> translate<50.317397,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.317397,-1.535000,56.388000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,56.388000>}
box{<0,0,-0.152400><0.279403,0.035000,0.152400> rotate<0,0.000000,0> translate<50.317397,-1.535000,56.388000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.317397,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,56.692800>}
box{<0,0,-0.152400><0.279403,0.035000,0.152400> rotate<0,0.000000,0> translate<50.317397,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.317397,-1.535000,56.997600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.599503,-1.535000,56.997600>}
box{<0,0,-0.152400><0.282106,0.035000,0.152400> rotate<0,0.000000,0> translate<50.317397,-1.535000,56.997600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.317397,-1.535000,57.152241>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.797756,-1.535000,57.632600>}
box{<0,0,-0.152400><0.679331,0.035000,0.152400> rotate<0,-44.997030,0> translate<50.317397,-1.535000,57.152241> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.438425,-1.535000,37.571997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.041572,-1.535000,37.571997>}
box{<0,0,-0.152400><0.603147,0.035000,0.152400> rotate<0,0.000000,0> translate<50.438425,-1.535000,37.571997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.467556,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.665209,-1.535000,57.302400>}
box{<0,0,-0.152400><0.197653,0.035000,0.152400> rotate<0,0.000000,0> translate<50.467556,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596031,-1.535000,44.884809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.932113,-1.535000,44.745600>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,22.498510,0> translate<50.596031,-1.535000,44.884809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,54.779450>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.631200,-1.535000,54.562266>}
box{<0,0,-0.152400><0.219892,0.035000,0.152400> rotate<0,80.994301,0> translate<50.596800,-1.535000,54.779450> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,55.727600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,54.779450>}
box{<0,0,-0.152400><0.948150,0.035000,0.152400> rotate<0,-90.000000,0> translate<50.596800,-1.535000,54.779450> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,55.727600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.841384,-1.535000,55.727600>}
box{<0,0,-0.152400><1.244584,0.035000,0.152400> rotate<0,0.000000,0> translate<50.596800,-1.535000,55.727600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,56.032394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.841384,-1.535000,56.032394>}
box{<0,0,-0.152400><1.244584,0.035000,0.152400> rotate<0,0.000000,0> translate<50.596800,-1.535000,56.032394> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,56.980547>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,56.032394>}
box{<0,0,-0.152400><0.948153,0.035000,0.152400> rotate<0,-90.000000,0> translate<50.596800,-1.535000,56.032394> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.596800,-1.535000,56.980547>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.631200,-1.535000,57.197731>}
box{<0,0,-0.152400><0.219892,0.035000,0.152400> rotate<0,-80.994301,0> translate<50.596800,-1.535000,56.980547> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.631200,-1.535000,54.562266>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.648706,-1.535000,54.508397>}
box{<0,0,-0.152400><0.056642,0.035000,0.152400> rotate<0,71.992139,0> translate<50.631200,-1.535000,54.562266> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.631200,-1.535000,57.197731>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.699150,-1.535000,57.406859>}
box{<0,0,-0.152400><0.219890,0.035000,0.152400> rotate<0,-71.995210,0> translate<50.631200,-1.535000,57.197731> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.699150,-1.535000,57.406859>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.798978,-1.535000,57.602788>}
box{<0,0,-0.152400><0.219894,0.035000,0.152400> rotate<0,-62.996362,0> translate<50.699150,-1.535000,57.406859> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.772356,-1.535000,57.607200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.802184,-1.535000,57.607200>}
box{<0,0,-0.152400><0.029828,0.035000,0.152400> rotate<0,0.000000,0> translate<50.772356,-1.535000,57.607200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.797756,-1.535000,57.632600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.820641,-1.535000,57.632600>}
box{<0,0,-0.152400><0.022884,0.035000,0.152400> rotate<0,0.000000,0> translate<50.797756,-1.535000,57.632600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.798978,-1.535000,57.602788>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.820641,-1.535000,57.632600>}
box{<0,0,-0.152400><0.036852,0.035000,0.152400> rotate<0,-53.993354,0> translate<50.798978,-1.535000,57.602788> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<50.932113,-1.535000,44.745600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,44.745600>}
box{<0,0,-0.152400><0.395888,0.035000,0.152400> rotate<0,0.000000,0> translate<50.932113,-1.535000,44.745600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.041572,-1.535000,37.571997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.321638,-1.535000,37.455991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<51.041572,-1.535000,37.571997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.238566,-1.535000,37.490400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.531966,-1.535000,37.490400>}
box{<0,0,-0.152400><0.293400,0.035000,0.152400> rotate<0,0.000000,0> translate<51.238566,-1.535000,37.490400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.321638,-1.535000,37.455991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.535991,-1.535000,37.241638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<51.321638,-1.535000,37.455991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,37.858425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.444006,-1.535000,37.578359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<51.328000,-1.535000,37.858425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,39.961572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,37.858425>}
box{<0,0,-0.152400><2.103147,0.035000,0.152400> rotate<0,-90.000000,0> translate<51.328000,-1.535000,37.858425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,39.961572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.410191,-1.535000,40.160000>}
box{<0,0,-0.152400><0.214777,0.035000,0.152400> rotate<0,-67.495791,0> translate<51.328000,-1.535000,39.961572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,40.358425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.410191,-1.535000,40.160000>}
box{<0,0,-0.152400><0.214774,0.035000,0.152400> rotate<0,67.495472,0> translate<51.328000,-1.535000,40.358425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,44.745600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.328000,-1.535000,40.358425>}
box{<0,0,-0.152400><4.387175,0.035000,0.152400> rotate<0,-90.000000,0> translate<51.328000,-1.535000,40.358425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.444006,-1.535000,37.578359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.658359,-1.535000,37.364006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<51.444006,-1.535000,37.578359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.535991,-1.535000,37.241638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.651997,-1.535000,36.961572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<51.535991,-1.535000,37.241638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.559203,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.933600,-1.535000,37.185600>}
box{<0,0,-0.152400><1.374397,0.035000,0.152400> rotate<0,0.000000,0> translate<51.559203,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.651997,-1.535000,36.397675>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.651997,-1.535000,36.961572>}
box{<0,0,-0.152400><0.563897,0.035000,0.152400> rotate<0,90.000000,0> translate<51.651997,-1.535000,36.961572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.651997,-1.535000,36.397675>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.654397,-1.535000,36.391884>}
box{<0,0,-0.152400><0.006268,0.035000,0.152400> rotate<0,67.483347,0> translate<51.651997,-1.535000,36.397675> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.651997,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.933600,-1.535000,36.576000>}
box{<0,0,-0.152400><1.281603,0.035000,0.152400> rotate<0,0.000000,0> translate<51.651997,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.651997,-1.535000,36.880800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.933600,-1.535000,36.880800>}
box{<0,0,-0.152400><1.281603,0.035000,0.152400> rotate<0,0.000000,0> translate<51.651997,-1.535000,36.880800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.654397,-1.535000,34.659550>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.654397,-1.535000,36.391884>}
box{<0,0,-0.152400><1.732334,0.035000,0.152400> rotate<0,90.000000,0> translate<51.654397,-1.535000,36.391884> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.654397,-1.535000,34.659550>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.933600,-1.535000,35.938756>}
box{<0,0,-0.152400><1.809069,0.035000,0.152400> rotate<0,-44.997100,0> translate<51.654397,-1.535000,34.659550> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.654397,-1.535000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.742047,-1.535000,34.747200>}
box{<0,0,-0.152400><0.087650,0.035000,0.152400> rotate<0,0.000000,0> translate<51.654397,-1.535000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.654397,-1.535000,35.052000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.046847,-1.535000,35.052000>}
box{<0,0,-0.152400><0.392450,0.035000,0.152400> rotate<0,0.000000,0> translate<51.654397,-1.535000,35.052000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.654397,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.351647,-1.535000,35.356800>}
box{<0,0,-0.152400><0.697250,0.035000,0.152400> rotate<0,0.000000,0> translate<51.654397,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.654397,-1.535000,35.661600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.656447,-1.535000,35.661600>}
box{<0,0,-0.152400><1.002050,0.035000,0.152400> rotate<0,0.000000,0> translate<51.654397,-1.535000,35.661600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.654397,-1.535000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.933600,-1.535000,35.966400>}
box{<0,0,-0.152400><1.279203,0.035000,0.152400> rotate<0,0.000000,0> translate<51.654397,-1.535000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.654397,-1.535000,36.271200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.933600,-1.535000,36.271200>}
box{<0,0,-0.152400><1.279203,0.035000,0.152400> rotate<0,0.000000,0> translate<51.654397,-1.535000,36.271200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.658359,-1.535000,37.364006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.938425,-1.535000,37.248000>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<51.658359,-1.535000,37.364006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.714397,-1.535000,46.574397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.714397,-1.535000,47.980600>}
box{<0,0,-0.152400><1.406203,0.035000,0.152400> rotate<0,90.000000,0> translate<51.714397,-1.535000,47.980600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.714397,-1.535000,46.574397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.871884,-1.535000,46.574397>}
box{<0,0,-0.152400><1.157487,0.035000,0.152400> rotate<0,0.000000,0> translate<51.714397,-1.535000,46.574397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.714397,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.628244,-1.535000,46.634400>}
box{<0,0,-0.152400><3.913847,0.035000,0.152400> rotate<0,0.000000,0> translate<51.714397,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.714397,-1.535000,46.939200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.933044,-1.535000,46.939200>}
box{<0,0,-0.152400><4.218647,0.035000,0.152400> rotate<0,0.000000,0> translate<51.714397,-1.535000,46.939200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.714397,-1.535000,47.244000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.237844,-1.535000,47.244000>}
box{<0,0,-0.152400><4.523447,0.035000,0.152400> rotate<0,0.000000,0> translate<51.714397,-1.535000,47.244000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.714397,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,47.548800>}
box{<0,0,-0.152400><4.775203,0.035000,0.152400> rotate<0,0.000000,0> translate<51.714397,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.714397,-1.535000,47.853600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,47.853600>}
box{<0,0,-0.152400><4.775203,0.035000,0.152400> rotate<0,0.000000,0> translate<51.714397,-1.535000,47.853600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.714397,-1.535000,47.980600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.251884,-1.535000,47.980600>}
box{<0,0,-0.152400><0.537487,0.035000,0.152400> rotate<0,0.000000,0> translate<51.714397,-1.535000,47.980600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.841384,-1.535000,56.032394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.841384,-1.535000,55.727600>}
box{<0,0,-0.152400><0.304794,0.035000,0.152400> rotate<0,-90.000000,0> translate<51.841384,-1.535000,55.727600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<51.938425,-1.535000,37.248000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.502322,-1.535000,37.248000>}
box{<0,0,-0.152400><0.563897,0.035000,0.152400> rotate<0,0.000000,0> translate<51.938425,-1.535000,37.248000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.146213,-1.535000,55.727600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.146213,-1.535000,56.032394>}
box{<0,0,-0.152400><0.304794,0.035000,0.152400> rotate<0,90.000000,0> translate<52.146213,-1.535000,56.032394> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.146213,-1.535000,55.727600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,55.727600>}
box{<0,0,-0.152400><1.244584,0.035000,0.152400> rotate<0,0.000000,0> translate<52.146213,-1.535000,55.727600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.146213,-1.535000,55.778400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.846825,-1.535000,55.778400>}
box{<0,0,-0.152400><6.700612,0.035000,0.152400> rotate<0,0.000000,0> translate<52.146213,-1.535000,55.778400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.146213,-1.535000,56.032394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,56.032394>}
box{<0,0,-0.152400><1.244584,0.035000,0.152400> rotate<0,0.000000,0> translate<52.146213,-1.535000,56.032394> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.251884,-1.535000,47.980600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.587966,-1.535000,48.119809>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-22.498510,0> translate<52.251884,-1.535000,47.980600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.502322,-1.535000,37.248000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.508113,-1.535000,37.245600>}
box{<0,0,-0.152400><0.006268,0.035000,0.152400> rotate<0,22.510714,0> translate<52.502322,-1.535000,37.248000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.508113,-1.535000,37.245600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.933600,-1.535000,37.245600>}
box{<0,0,-0.152400><0.425488,0.035000,0.152400> rotate<0,0.000000,0> translate<52.508113,-1.535000,37.245600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.576656,-1.535000,53.618494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.725988,-1.535000,53.694578>}
box{<0,0,-0.152400><0.167597,0.035000,0.152400> rotate<0,-26.997092,0> translate<52.576656,-1.535000,53.618494> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.576656,-1.535000,53.618494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.607188,-1.535000,52.587966>}
box{<0,0,-0.152400><1.457389,0.035000,0.152400> rotate<0,44.996943,0> translate<52.576656,-1.535000,53.618494> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.587966,-1.535000,48.119809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.349966,-1.535000,48.881809>}
box{<0,0,-0.152400><1.077631,0.035000,0.152400> rotate<0,-44.997030,0> translate<52.587966,-1.535000,48.119809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.626556,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,48.158400>}
box{<0,0,-0.152400><3.863044,0.035000,0.152400> rotate<0,0.000000,0> translate<52.626556,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.628287,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.431644,-1.535000,53.644800>}
box{<0,0,-0.152400><4.803356,0.035000,0.152400> rotate<0,0.000000,0> translate<52.628287,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.725988,-1.535000,53.694578>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.903881,-1.535000,53.823828>}
box{<0,0,-0.152400><0.219890,0.035000,0.152400> rotate<0,-35.998177,0> translate<52.725988,-1.535000,53.694578> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.855153,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.126844,-1.535000,53.340000>}
box{<0,0,-0.152400><4.271691,0.035000,0.152400> rotate<0,0.000000,0> translate<52.855153,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.871884,-1.535000,46.574397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.877678,-1.535000,46.571997>}
box{<0,0,-0.152400><0.006271,0.035000,0.152400> rotate<0,22.499783,0> translate<52.871884,-1.535000,46.574397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.877678,-1.535000,46.571997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.441572,-1.535000,46.571997>}
box{<0,0,-0.152400><0.563894,0.035000,0.152400> rotate<0,0.000000,0> translate<52.877678,-1.535000,46.571997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.903881,-1.535000,53.823828>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.059369,-1.535000,53.979316>}
box{<0,0,-0.152400><0.219893,0.035000,0.152400> rotate<0,-44.997030,0> translate<52.903881,-1.535000,53.823828> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.931356,-1.535000,48.463200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,48.463200>}
box{<0,0,-0.152400><3.558244,0.035000,0.152400> rotate<0,0.000000,0> translate<52.931356,-1.535000,48.463200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.933600,-1.535000,37.245600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<52.933600,-1.535000,35.938756>}
box{<0,0,-0.152400><1.306844,0.035000,0.152400> rotate<0,-90.000000,0> translate<52.933600,-1.535000,35.938756> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.029653,-1.535000,53.949600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.736444,-1.535000,53.949600>}
box{<0,0,-0.152400><4.706791,0.035000,0.152400> rotate<0,0.000000,0> translate<53.029653,-1.535000,53.949600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.059369,-1.535000,53.979316>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.188619,-1.535000,54.157209>}
box{<0,0,-0.152400><0.219890,0.035000,0.152400> rotate<0,-53.995883,0> translate<53.059369,-1.535000,53.979316> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.159953,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.822044,-1.535000,53.035200>}
box{<0,0,-0.152400><3.662091,0.035000,0.152400> rotate<0,0.000000,0> translate<53.159953,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.166956,-1.535000,57.632600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.188619,-1.535000,57.602788>}
box{<0,0,-0.152400><0.036852,0.035000,0.152400> rotate<0,53.993354,0> translate<53.166956,-1.535000,57.632600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.166956,-1.535000,57.632600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.391241,-1.535000,57.632600>}
box{<0,0,-0.152400><11.224284,0.035000,0.152400> rotate<0,0.000000,0> translate<53.166956,-1.535000,57.632600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.185416,-1.535000,57.607200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.416641,-1.535000,57.607200>}
box{<0,0,-0.152400><11.231225,0.035000,0.152400> rotate<0,0.000000,0> translate<53.185416,-1.535000,57.607200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.188619,-1.535000,54.157209>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.288447,-1.535000,54.353138>}
box{<0,0,-0.152400><0.219894,0.035000,0.152400> rotate<0,-62.996362,0> translate<53.188619,-1.535000,54.157209> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.188619,-1.535000,57.602788>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.288447,-1.535000,57.406859>}
box{<0,0,-0.152400><0.219894,0.035000,0.152400> rotate<0,62.996362,0> translate<53.188619,-1.535000,57.602788> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.236156,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,48.768000>}
box{<0,0,-0.152400><3.253444,0.035000,0.152400> rotate<0,0.000000,0> translate<53.236156,-1.535000,48.768000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.238138,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.041244,-1.535000,54.254400>}
box{<0,0,-0.152400><4.803106,0.035000,0.152400> rotate<0,0.000000,0> translate<53.238138,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.288447,-1.535000,54.353138>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.356397,-1.535000,54.562266>}
box{<0,0,-0.152400><0.219890,0.035000,0.152400> rotate<0,-71.995210,0> translate<53.288447,-1.535000,54.353138> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.288447,-1.535000,57.406859>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.356397,-1.535000,57.197731>}
box{<0,0,-0.152400><0.219890,0.035000,0.152400> rotate<0,71.995210,0> translate<53.288447,-1.535000,57.406859> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.322391,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.721441,-1.535000,57.302400>}
box{<0,0,-0.152400><11.399050,0.035000,0.152400> rotate<0,0.000000,0> translate<53.322391,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.349966,-1.535000,48.881809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.607188,-1.535000,49.139031>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,-44.997030,0> translate<53.349966,-1.535000,48.881809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.355400,-1.535000,54.559200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.267600,-1.535000,54.559200>}
box{<0,0,-0.152400><4.912200,0.035000,0.152400> rotate<0,0.000000,0> translate<53.355400,-1.535000,54.559200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.356397,-1.535000,54.562266>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,54.779450>}
box{<0,0,-0.152400><0.219892,0.035000,0.152400> rotate<0,-80.994301,0> translate<53.356397,-1.535000,54.562266> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.356397,-1.535000,57.197731>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,56.980547>}
box{<0,0,-0.152400><0.219892,0.035000,0.152400> rotate<0,80.994301,0> translate<53.356397,-1.535000,57.197731> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.388097,-1.535000,56.997600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.026241,-1.535000,56.997600>}
box{<0,0,-0.152400><11.638144,0.035000,0.152400> rotate<0,0.000000,0> translate<53.388097,-1.535000,56.997600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,54.779450>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,55.727600>}
box{<0,0,-0.152400><0.948150,0.035000,0.152400> rotate<0,90.000000,0> translate<53.390797,-1.535000,55.727600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.267600,-1.535000,54.864000>}
box{<0,0,-0.152400><4.876803,0.035000,0.152400> rotate<0,0.000000,0> translate<53.390797,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,55.168800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.381869,-1.535000,55.168800>}
box{<0,0,-0.152400><4.991072,0.035000,0.152400> rotate<0,0.000000,0> translate<53.390797,-1.535000,55.168800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.542025,-1.535000,55.473600>}
box{<0,0,-0.152400><5.151228,0.035000,0.152400> rotate<0,0.000000,0> translate<53.390797,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,56.032394>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,56.980547>}
box{<0,0,-0.152400><0.948153,0.035000,0.152400> rotate<0,90.000000,0> translate<53.390797,-1.535000,56.980547> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.795569,-1.535000,56.083200>}
box{<0,0,-0.152400><7.404772,0.035000,0.152400> rotate<0,0.000000,0> translate<53.390797,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,56.388000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.635841,-1.535000,56.388000>}
box{<0,0,-0.152400><12.245044,0.035000,0.152400> rotate<0,0.000000,0> translate<53.390797,-1.535000,56.388000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.390797,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.331041,-1.535000,56.692800>}
box{<0,0,-0.152400><11.940244,0.035000,0.152400> rotate<0,0.000000,0> translate<53.390797,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.441572,-1.535000,46.571997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.721637,-1.535000,46.455991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<53.441572,-1.535000,46.571997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.464753,-1.535000,52.730400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.582600,-1.535000,52.730400>}
box{<0,0,-0.152400><3.117847,0.035000,0.152400> rotate<0,0.000000,0> translate<53.464753,-1.535000,52.730400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.540956,-1.535000,49.072800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,49.072800>}
box{<0,0,-0.152400><2.948644,0.035000,0.152400> rotate<0,0.000000,0> translate<53.540956,-1.535000,49.072800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.607188,-1.535000,49.139031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,49.475113>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<53.607188,-1.535000,49.139031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.607188,-1.535000,52.587966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,52.251884>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,67.495551,0> translate<53.607188,-1.535000,52.587966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.674444,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,52.425600>}
box{<0,0,-0.152400><2.815156,0.035000,0.152400> rotate<0,0.000000,0> translate<53.674444,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.706003,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,49.377600>}
box{<0,0,-0.152400><2.783597,0.035000,0.152400> rotate<0,0.000000,0> translate<53.706003,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.721637,-1.535000,46.455991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.935991,-1.535000,46.241638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<53.721637,-1.535000,46.455991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,49.475113>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,52.251884>}
box{<0,0,-0.152400><2.776772,0.035000,0.152400> rotate<0,90.000000,0> translate<53.746397,-1.535000,52.251884> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,49.682400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,49.682400>}
box{<0,0,-0.152400><2.743203,0.035000,0.152400> rotate<0,0.000000,0> translate<53.746397,-1.535000,49.682400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,49.987200>}
box{<0,0,-0.152400><2.743203,0.035000,0.152400> rotate<0,0.000000,0> translate<53.746397,-1.535000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,50.292000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,50.292000>}
box{<0,0,-0.152400><2.743203,0.035000,0.152400> rotate<0,0.000000,0> translate<53.746397,-1.535000,50.292000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,50.596800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,50.596800>}
box{<0,0,-0.152400><2.743203,0.035000,0.152400> rotate<0,0.000000,0> translate<53.746397,-1.535000,50.596800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,50.901600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,50.901600>}
box{<0,0,-0.152400><2.743203,0.035000,0.152400> rotate<0,0.000000,0> translate<53.746397,-1.535000,50.901600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,51.206400>}
box{<0,0,-0.152400><2.743203,0.035000,0.152400> rotate<0,0.000000,0> translate<53.746397,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,51.511200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,51.511200>}
box{<0,0,-0.152400><2.743203,0.035000,0.152400> rotate<0,0.000000,0> translate<53.746397,-1.535000,51.511200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,51.816000>}
box{<0,0,-0.152400><2.743203,0.035000,0.152400> rotate<0,0.000000,0> translate<53.746397,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.746397,-1.535000,52.120800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,52.120800>}
box{<0,0,-0.152400><2.743203,0.035000,0.152400> rotate<0,0.000000,0> translate<53.746397,-1.535000,52.120800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.848028,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.323444,-1.535000,46.329600>}
box{<0,0,-0.152400><1.475416,0.035000,0.152400> rotate<0,0.000000,0> translate<53.848028,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<53.935991,-1.535000,46.241638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.051997,-1.535000,45.961572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<53.935991,-1.535000,46.241638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.025809,-1.535000,46.024800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.018644,-1.535000,46.024800>}
box{<0,0,-0.152400><0.992834,0.035000,0.152400> rotate<0,0.000000,0> translate<54.025809,-1.535000,46.024800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.051997,-1.535000,45.574397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.051997,-1.535000,45.961572>}
box{<0,0,-0.152400><0.387175,0.035000,0.152400> rotate<0,90.000000,0> translate<54.051997,-1.535000,45.961572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.051997,-1.535000,45.574397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.568241,-1.535000,45.574397>}
box{<0,0,-0.152400><0.516244,0.035000,0.152400> rotate<0,0.000000,0> translate<54.051997,-1.535000,45.574397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.051997,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.713844,-1.535000,45.720000>}
box{<0,0,-0.152400><0.661847,0.035000,0.152400> rotate<0,0.000000,0> translate<54.051997,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.568241,-1.535000,45.574397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,47.495756>}
box{<0,0,-0.152400><2.717212,0.035000,0.152400> rotate<0,-44.997030,0> translate<54.568241,-1.535000,45.574397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.785550,-1.535000,10.947397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.004188,-1.535000,11.166031>}
box{<0,0,-0.152400><0.309198,0.035000,0.152400> rotate<0,-44.996621,0> translate<54.785550,-1.535000,10.947397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.785550,-1.535000,10.947397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,10.947397>}
box{<0,0,-0.152400><13.439050,0.035000,0.152400> rotate<0,0.000000,0> translate<54.785550,-1.535000,10.947397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<54.810953,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,10.972800>}
box{<0,0,-0.152400><13.413647,0.035000,0.152400> rotate<0,0.000000,0> translate<54.810953,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.004188,-1.535000,11.166031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.576188,-1.535000,15.738031>}
box{<0,0,-0.152400><6.465784,0.035000,0.152400> rotate<0,-44.997030,0> translate<55.004188,-1.535000,11.166031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.115756,-1.535000,11.277600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,11.277600>}
box{<0,0,-0.152400><13.108844,0.035000,0.152400> rotate<0,0.000000,0> translate<55.115756,-1.535000,11.277600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.420556,-1.535000,11.582400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,11.582400>}
box{<0,0,-0.152400><12.804044,0.035000,0.152400> rotate<0,0.000000,0> translate<55.420556,-1.535000,11.582400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<55.725356,-1.535000,11.887200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,11.887200>}
box{<0,0,-0.152400><12.499244,0.035000,0.152400> rotate<0,0.000000,0> translate<55.725356,-1.535000,11.887200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.030156,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,12.192000>}
box{<0,0,-0.152400><12.194444,0.035000,0.152400> rotate<0,0.000000,0> translate<56.030156,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.334956,-1.535000,12.496800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,12.496800>}
box{<0,0,-0.152400><11.889644,0.035000,0.152400> rotate<0,0.000000,0> translate<56.334956,-1.535000,12.496800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,52.505884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,47.495756>}
box{<0,0,-0.152400><5.010128,0.035000,0.152400> rotate<0,-90.000000,0> translate<56.489600,-1.535000,47.495756> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.489600,-1.535000,52.505884>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.628809,-1.535000,52.841966>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<56.489600,-1.535000,52.505884> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.628809,-1.535000,52.841966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.267600,-1.535000,54.480756>}
box{<0,0,-0.152400><2.317600,0.035000,0.152400> rotate<0,-44.997030,0> translate<56.628809,-1.535000,52.841966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.639756,-1.535000,12.801600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,12.801600>}
box{<0,0,-0.152400><11.584844,0.035000,0.152400> rotate<0,0.000000,0> translate<56.639756,-1.535000,12.801600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<56.944556,-1.535000,13.106400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,13.106400>}
box{<0,0,-0.152400><11.280044,0.035000,0.152400> rotate<0,0.000000,0> translate<56.944556,-1.535000,13.106400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.249356,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,13.411200>}
box{<0,0,-0.152400><10.975244,0.035000,0.152400> rotate<0,0.000000,0> translate<57.249356,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.554156,-1.535000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,13.716000>}
box{<0,0,-0.152400><10.670444,0.035000,0.152400> rotate<0,0.000000,0> translate<57.554156,-1.535000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<57.858956,-1.535000,14.020800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,14.020800>}
box{<0,0,-0.152400><10.365644,0.035000,0.152400> rotate<0,0.000000,0> translate<57.858956,-1.535000,14.020800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.163756,-1.535000,14.325600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,14.325600>}
box{<0,0,-0.152400><10.060844,0.035000,0.152400> rotate<0,0.000000,0> translate<58.163756,-1.535000,14.325600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.267600,-1.535000,54.892931>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.267600,-1.535000,54.480756>}
box{<0,0,-0.152400><0.412175,0.035000,0.152400> rotate<0,-90.000000,0> translate<58.267600,-1.535000,54.480756> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.267600,-1.535000,54.892931>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.484147,-1.535000,55.415722>}
box{<0,0,-0.152400><0.565864,0.035000,0.152400> rotate<0,-67.495554,0> translate<58.267600,-1.535000,54.892931> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.468556,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,14.630400>}
box{<0,0,-0.152400><9.756044,0.035000,0.152400> rotate<0,0.000000,0> translate<58.468556,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.484147,-1.535000,55.415722>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.884275,-1.535000,55.815850>}
box{<0,0,-0.152400><0.565867,0.035000,0.152400> rotate<0,-44.997030,0> translate<58.484147,-1.535000,55.415722> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.773356,-1.535000,14.935200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,14.935200>}
box{<0,0,-0.152400><9.451244,0.035000,0.152400> rotate<0,0.000000,0> translate<58.773356,-1.535000,14.935200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.884275,-1.535000,55.815850>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.407066,-1.535000,56.032397>}
box{<0,0,-0.152400><0.565864,0.035000,0.152400> rotate<0,-22.498506,0> translate<58.884275,-1.535000,55.815850> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.888931,-1.535000,44.514778>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.407066,-1.535000,44.729397>}
box{<0,0,-0.152400><0.560825,0.035000,0.152400> rotate<0,-22.498559,0> translate<58.888931,-1.535000,44.514778> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<58.888931,-1.535000,44.514778>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.207966,-1.535000,45.833809>}
box{<0,0,-0.152400><1.865394,0.035000,0.152400> rotate<0,-44.996962,0> translate<58.888931,-1.535000,44.514778> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.078156,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,15.240000>}
box{<0,0,-0.152400><9.146444,0.035000,0.152400> rotate<0,0.000000,0> translate<59.078156,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.179753,-1.535000,44.805600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,44.805600>}
box{<0,0,-0.152400><3.013847,0.035000,0.152400> rotate<0,0.000000,0> translate<59.179753,-1.535000,44.805600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.382956,-1.535000,15.544800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,15.544800>}
box{<0,0,-0.152400><8.841644,0.035000,0.152400> rotate<0,0.000000,0> translate<59.382956,-1.535000,15.544800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.407066,-1.535000,44.729397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.972931,-1.535000,44.729397>}
box{<0,0,-0.152400><0.565866,0.035000,0.152400> rotate<0,0.000000,0> translate<59.407066,-1.535000,44.729397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.407066,-1.535000,56.032397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.972931,-1.535000,56.032397>}
box{<0,0,-0.152400><0.565866,0.035000,0.152400> rotate<0,0.000000,0> translate<59.407066,-1.535000,56.032397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.484553,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,45.110400>}
box{<0,0,-0.152400><2.709047,0.035000,0.152400> rotate<0,0.000000,0> translate<59.484553,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.576188,-1.535000,15.738031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,16.074113>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<59.576188,-1.535000,15.738031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.622400,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,15.849600>}
box{<0,0,-0.152400><8.602200,0.035000,0.152400> rotate<0,0.000000,0> translate<59.622400,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,16.074113>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,37.693600>}
box{<0,0,-0.152400><21.619488,0.035000,0.152400> rotate<0,90.000000,0> translate<59.715397,-1.535000,37.693600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,16.154400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,16.154400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,16.154400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,16.459200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,16.459200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,16.459200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,16.764000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,17.068800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,17.373600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,17.373600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,17.373600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,17.678400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,17.678400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,17.678400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,17.983200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,18.288000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,18.592800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,18.592800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,18.592800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,18.897600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,18.897600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,18.897600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,19.202400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,19.202400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,19.202400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,19.507200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,19.812000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,20.116800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,20.116800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,20.116800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,20.421600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,20.421600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,20.421600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,20.726400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,21.031200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,21.031200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,21.031200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,21.336000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,21.640800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,21.640800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,21.640800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,21.945600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,22.250400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,22.250400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,22.250400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,22.555200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,22.555200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,22.555200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,22.860000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,23.164800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,23.469600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,23.469600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,23.469600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,23.774400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,23.774400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,23.774400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,24.079200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,24.079200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,24.079200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,24.384000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,24.688800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,24.688800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,24.688800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,24.993600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,24.993600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,24.993600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,25.298400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,25.298400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,25.298400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,25.603200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,25.908000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,26.212800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,26.517600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,26.517600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,26.517600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,26.822400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,27.127200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,27.127200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,27.127200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,27.432000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,27.736800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,27.736800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,27.736800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,28.041600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,28.346400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,28.346400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,28.346400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,28.651200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,28.651200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,28.651200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,28.956000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,28.956000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,28.956000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,29.260800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,29.565600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,29.565600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,29.565600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,29.870400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,29.870400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,30.175200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,30.175200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,30.175200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,30.480000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,30.784800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,30.784800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,30.784800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,31.089600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,31.089600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,31.394400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,31.394400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,31.394400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,31.699200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,32.004000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,32.004000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,32.004000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,32.308800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,32.613600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,32.613600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,32.613600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,32.918400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,33.223200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,33.223200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,33.223200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,33.528000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,33.832800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,33.832800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,33.832800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,34.137600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,34.442400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,34.442400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,34.442400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,34.747200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,35.052000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,35.052000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,35.052000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,35.356800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,35.661600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,35.661600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,35.661600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,35.966400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,36.271200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,36.271200>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,36.271200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,36.576000>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,36.880800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,36.880800>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,36.880800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,37.185600>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,37.490400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,37.490400>}
box{<0,0,-0.152400><8.509203,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,37.490400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.715397,-1.535000,37.693600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.316884,-1.535000,37.693600>}
box{<0,0,-0.152400><4.601487,0.035000,0.152400> rotate<0,0.000000,0> translate<59.715397,-1.535000,37.693600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.789353,-1.535000,45.415200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,45.415200>}
box{<0,0,-0.152400><2.404247,0.035000,0.152400> rotate<0,0.000000,0> translate<59.789353,-1.535000,45.415200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.972931,-1.535000,44.729397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.495722,-1.535000,44.512850>}
box{<0,0,-0.152400><0.565864,0.035000,0.152400> rotate<0,22.498506,0> translate<59.972931,-1.535000,44.729397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<59.972931,-1.535000,56.032397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.495722,-1.535000,55.815850>}
box{<0,0,-0.152400><0.565864,0.035000,0.152400> rotate<0,22.498506,0> translate<59.972931,-1.535000,56.032397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.094153,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.376100,-1.535000,45.720000>}
box{<0,0,-0.152400><2.281947,0.035000,0.152400> rotate<0,0.000000,0> translate<60.094153,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.207966,-1.535000,45.833809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.465188,-1.535000,46.091031>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,-44.997030,0> translate<60.207966,-1.535000,45.833809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.398956,-1.535000,46.024800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,46.024800>}
box{<0,0,-0.152400><1.794644,0.035000,0.152400> rotate<0,0.000000,0> translate<60.398956,-1.535000,46.024800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.465188,-1.535000,46.091031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.604397,-1.535000,46.427112>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<60.465188,-1.535000,46.091031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.495722,-1.535000,44.512850>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.895850,-1.535000,44.112722>}
box{<0,0,-0.152400><0.565867,0.035000,0.152400> rotate<0,44.997030,0> translate<60.495722,-1.535000,44.512850> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.495722,-1.535000,55.815850>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.570803,-1.535000,55.740766>}
box{<0,0,-0.152400><0.106183,0.035000,0.152400> rotate<0,44.998222,0> translate<60.495722,-1.535000,55.815850> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.507772,-1.535000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347588,-1.535000,44.500800>}
box{<0,0,-0.152400><2.839816,0.035000,0.152400> rotate<0,0.000000,0> translate<60.507772,-1.535000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.533172,-1.535000,55.778400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.586394,-1.535000,55.778400>}
box{<0,0,-0.152400><0.053222,0.035000,0.152400> rotate<0,0.000000,0> translate<60.533172,-1.535000,55.778400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.564003,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,46.329600>}
box{<0,0,-0.152400><1.629597,0.035000,0.152400> rotate<0,0.000000,0> translate<60.564003,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.570803,-1.535000,55.740766>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.654006,-1.535000,55.941638>}
box{<0,0,-0.152400><0.217422,0.035000,0.152400> rotate<0,-67.495723,0> translate<60.570803,-1.535000,55.740766> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.604397,-1.535000,46.427112>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.604397,-1.535000,47.035825>}
box{<0,0,-0.152400><0.608713,0.035000,0.152400> rotate<0,90.000000,0> translate<60.604397,-1.535000,47.035825> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.604397,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,46.634400>}
box{<0,0,-0.152400><1.589203,0.035000,0.152400> rotate<0,0.000000,0> translate<60.604397,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.604397,-1.535000,46.939200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347588,-1.535000,46.939200>}
box{<0,0,-0.152400><2.743191,0.035000,0.152400> rotate<0,0.000000,0> translate<60.604397,-1.535000,46.939200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.604397,-1.535000,47.035825>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.895850,-1.535000,47.327275>}
box{<0,0,-0.152400><0.412175,0.035000,0.152400> rotate<0,-44.996723,0> translate<60.604397,-1.535000,47.035825> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.654006,-1.535000,55.941638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.868359,-1.535000,56.155991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<60.654006,-1.535000,55.941638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.812572,-1.535000,44.196000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,44.196000>}
box{<0,0,-0.152400><1.381028,0.035000,0.152400> rotate<0,0.000000,0> translate<60.812572,-1.535000,44.196000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.812572,-1.535000,47.244000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,47.244000>}
box{<0,0,-0.152400><1.381028,0.035000,0.152400> rotate<0,0.000000,0> translate<60.812572,-1.535000,47.244000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.868359,-1.535000,56.155991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.148425,-1.535000,56.271997>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<60.868359,-1.535000,56.155991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.895850,-1.535000,44.112722>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,43.589931>}
box{<0,0,-0.152400><0.565864,0.035000,0.152400> rotate<0,67.495554,0> translate<60.895850,-1.535000,44.112722> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.895850,-1.535000,47.327275>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,47.850066>}
box{<0,0,-0.152400><0.565864,0.035000,0.152400> rotate<0,-67.495554,0> translate<60.895850,-1.535000,47.327275> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.977084,-1.535000,42.697397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,43.024066>}
box{<0,0,-0.152400><0.353584,0.035000,0.152400> rotate<0,-67.495265,0> translate<60.977084,-1.535000,42.697397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.977084,-1.535000,42.697397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.838000,-1.535000,42.697397>}
box{<0,0,-0.152400><0.860916,0.035000,0.152400> rotate<0,0.000000,0> translate<60.977084,-1.535000,42.697397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.987606,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,47.548800>}
box{<0,0,-0.152400><1.205994,0.035000,0.152400> rotate<0,0.000000,0> translate<60.987606,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<60.987609,-1.535000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,43.891200>}
box{<0,0,-0.152400><1.205991,0.035000,0.152400> rotate<0,0.000000,0> translate<60.987609,-1.535000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.008619,-1.535000,48.666466>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.084753,-1.535000,48.742600>}
box{<0,0,-0.152400><0.107670,0.035000,0.152400> rotate<0,-44.997030,0> translate<61.008619,-1.535000,48.666466> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.008619,-1.535000,48.666466>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,48.415931>}
box{<0,0,-0.152400><0.271178,0.035000,0.152400> rotate<0,67.494884,0> translate<61.008619,-1.535000,48.666466> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.084753,-1.535000,48.742600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.838000,-1.535000,48.742600>}
box{<0,0,-0.152400><0.753247,0.035000,0.152400> rotate<0,0.000000,0> translate<61.084753,-1.535000,48.742600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.092816,-1.535000,42.976800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.939578,-1.535000,42.976800>}
box{<0,0,-0.152400><0.846763,0.035000,0.152400> rotate<0,0.000000,0> translate<61.092816,-1.535000,42.976800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.092819,-1.535000,48.463200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.939572,-1.535000,48.463200>}
box{<0,0,-0.152400><0.846753,0.035000,0.152400> rotate<0,0.000000,0> translate<61.092819,-1.535000,48.463200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,43.024066>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,43.589931>}
box{<0,0,-0.152400><0.565866,0.035000,0.152400> rotate<0,90.000000,0> translate<61.112397,-1.535000,43.589931> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.302616,-1.535000,43.281600>}
box{<0,0,-0.152400><1.190219,0.035000,0.152400> rotate<0,0.000000,0> translate<61.112397,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,43.586400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.242503,-1.535000,43.586400>}
box{<0,0,-0.152400><1.130106,0.035000,0.152400> rotate<0,0.000000,0> translate<61.112397,-1.535000,43.586400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,47.850066>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,48.415931>}
box{<0,0,-0.152400><0.565866,0.035000,0.152400> rotate<0,90.000000,0> translate<61.112397,-1.535000,48.415931> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,47.853600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.242506,-1.535000,47.853600>}
box{<0,0,-0.152400><1.130109,0.035000,0.152400> rotate<0,0.000000,0> translate<61.112397,-1.535000,47.853600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.112397,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.302603,-1.535000,48.158400>}
box{<0,0,-0.152400><1.190206,0.035000,0.152400> rotate<0,0.000000,0> translate<61.112397,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.148425,-1.535000,56.271997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.051572,-1.535000,56.271997>}
box{<0,0,-0.152400><1.903147,0.035000,0.152400> rotate<0,0.000000,0> translate<61.148425,-1.535000,56.271997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.838000,-1.535000,42.731572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.838000,-1.535000,42.697397>}
box{<0,0,-0.152400><0.034175,0.035000,0.152400> rotate<0,-90.000000,0> translate<61.838000,-1.535000,42.697397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.838000,-1.535000,42.731572>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.954006,-1.535000,43.011637>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<61.838000,-1.535000,42.731572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.838000,-1.535000,48.708425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.954006,-1.535000,48.428359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<61.838000,-1.535000,48.708425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.838000,-1.535000,48.742600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.838000,-1.535000,48.708425>}
box{<0,0,-0.152400><0.034175,0.035000,0.152400> rotate<0,-90.000000,0> translate<61.838000,-1.535000,48.708425> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.954006,-1.535000,43.011637>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.168359,-1.535000,43.225991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<61.954006,-1.535000,43.011637> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<61.954006,-1.535000,48.428359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.168359,-1.535000,48.214006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<61.954006,-1.535000,48.428359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.168359,-1.535000,43.225991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.448425,-1.535000,43.341997>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<62.168359,-1.535000,43.225991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.168359,-1.535000,48.214006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.448425,-1.535000,48.098000>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<62.168359,-1.535000,48.214006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,43.726494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.221294,-1.535000,43.623134>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,74.995728,0> translate<62.193600,-1.535000,43.726494> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,44.427603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,43.726494>}
box{<0,0,-0.152400><0.701109,0.035000,0.152400> rotate<0,-90.000000,0> translate<62.193600,-1.535000,43.726494> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,44.427603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347588,-1.535000,44.427603>}
box{<0,0,-0.152400><1.153987,0.035000,0.152400> rotate<0,0.000000,0> translate<62.193600,-1.535000,44.427603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,44.732391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347588,-1.535000,44.732391>}
box{<0,0,-0.152400><1.153987,0.035000,0.152400> rotate<0,0.000000,0> translate<62.193600,-1.535000,44.732391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,45.433503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,44.732391>}
box{<0,0,-0.152400><0.701113,0.035000,0.152400> rotate<0,-90.000000,0> translate<62.193600,-1.535000,44.732391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,45.433503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.221294,-1.535000,45.536863>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-74.995728,0> translate<62.193600,-1.535000,45.433503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,46.006494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.221294,-1.535000,45.903134>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,74.995728,0> translate<62.193600,-1.535000,46.006494> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,46.707603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,46.006494>}
box{<0,0,-0.152400><0.701109,0.035000,0.152400> rotate<0,-90.000000,0> translate<62.193600,-1.535000,46.006494> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,46.707603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347588,-1.535000,46.707603>}
box{<0,0,-0.152400><1.153987,0.035000,0.152400> rotate<0,0.000000,0> translate<62.193600,-1.535000,46.707603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,47.012391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347588,-1.535000,47.012391>}
box{<0,0,-0.152400><1.153987,0.035000,0.152400> rotate<0,0.000000,0> translate<62.193600,-1.535000,47.012391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,47.713503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,47.012391>}
box{<0,0,-0.152400><0.701113,0.035000,0.152400> rotate<0,-90.000000,0> translate<62.193600,-1.535000,47.012391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.193600,-1.535000,47.713503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.221294,-1.535000,47.816862>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-74.995728,0> translate<62.193600,-1.535000,47.713503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.221294,-1.535000,43.623134>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.274800,-1.535000,43.530462>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,59.995058,0> translate<62.221294,-1.535000,43.623134> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.221294,-1.535000,45.536863>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.274800,-1.535000,45.629534>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-59.995058,0> translate<62.221294,-1.535000,45.536863> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.221294,-1.535000,45.903134>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.274800,-1.535000,45.810462>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,59.995058,0> translate<62.221294,-1.535000,45.903134> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.221294,-1.535000,47.816862>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.274800,-1.535000,47.909534>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-59.995058,0> translate<62.221294,-1.535000,47.816862> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.274800,-1.535000,43.530462>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.350463,-1.535000,43.454800>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,44.997030,0> translate<62.274800,-1.535000,43.530462> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.274800,-1.535000,45.629534>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.350463,-1.535000,45.705197>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,-44.997030,0> translate<62.274800,-1.535000,45.629534> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.274800,-1.535000,45.810462>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.350463,-1.535000,45.734800>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,44.997030,0> translate<62.274800,-1.535000,45.810462> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.274800,-1.535000,47.909534>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.350463,-1.535000,47.985197>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,-44.997030,0> translate<62.274800,-1.535000,47.909534> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.350463,-1.535000,43.454800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.443134,-1.535000,43.401294>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,29.999002,0> translate<62.350463,-1.535000,43.454800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.350463,-1.535000,45.705197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.376100,-1.535000,45.720000>}
box{<0,0,-0.152400><0.029604,0.035000,0.152400> rotate<0,-30.000211,0> translate<62.350463,-1.535000,45.705197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.350463,-1.535000,45.734800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.376100,-1.535000,45.720000>}
box{<0,0,-0.152400><0.029603,0.035000,0.152400> rotate<0,29.994974,0> translate<62.350463,-1.535000,45.734800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.350463,-1.535000,47.985197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.443134,-1.535000,48.038703>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-29.999002,0> translate<62.350463,-1.535000,47.985197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.443134,-1.535000,43.401294>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.546494,-1.535000,43.373600>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,14.998332,0> translate<62.443134,-1.535000,43.401294> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.443134,-1.535000,48.038703>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.546494,-1.535000,48.066397>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-14.998332,0> translate<62.443134,-1.535000,48.038703> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.448425,-1.535000,43.341997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.551572,-1.535000,43.341997>}
box{<0,0,-0.152400><2.103147,0.035000,0.152400> rotate<0,0.000000,0> translate<62.448425,-1.535000,43.341997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.448425,-1.535000,48.098000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.551572,-1.535000,48.098000>}
box{<0,0,-0.152400><2.103147,0.035000,0.152400> rotate<0,0.000000,0> translate<62.448425,-1.535000,48.098000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.546494,-1.535000,43.373600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,43.373600>}
box{<0,0,-0.152400><0.801109,0.035000,0.152400> rotate<0,0.000000,0> translate<62.546494,-1.535000,43.373600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<62.546494,-1.535000,48.066397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,48.066397>}
box{<0,0,-0.152400><0.801109,0.035000,0.152400> rotate<0,0.000000,0> translate<62.546494,-1.535000,48.066397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.051572,-1.535000,56.271997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.331638,-1.535000,56.155991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<63.051572,-1.535000,56.271997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.331638,-1.535000,56.155991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.545991,-1.535000,55.941638>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<63.331638,-1.535000,56.155991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347588,-1.535000,44.732391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347588,-1.535000,44.427603>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,-90.000000,0> translate<63.347588,-1.535000,44.427603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347588,-1.535000,47.012391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347588,-1.535000,46.707603>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,-90.000000,0> translate<63.347588,-1.535000,46.707603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,43.373600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,44.427588>}
box{<0,0,-0.152400><1.053987,0.035000,0.152400> rotate<0,90.000000,0> translate<63.347603,-1.535000,44.427588> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,43.586400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,43.586400>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,43.586400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,43.891200>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,44.196000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,44.196000>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,44.196000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,44.427588>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,44.427588>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,44.427588> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,44.732409>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,45.786397>}
box{<0,0,-0.152400><1.053987,0.035000,0.152400> rotate<0,90.000000,0> translate<63.347603,-1.535000,45.786397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,44.732409>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,44.732409>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,44.732409> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,44.805600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,44.805600>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,44.805600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,45.110400>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,45.415200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,45.415200>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,45.415200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,45.720000>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,45.786397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,46.707588>}
box{<0,0,-0.152400><0.921191,0.035000,0.152400> rotate<0,90.000000,0> translate<63.347603,-1.535000,46.707588> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,46.024800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,46.024800>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,46.024800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,46.329600>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,46.634400>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,46.707588>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,46.707588>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,46.707588> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,47.012409>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,48.066397>}
box{<0,0,-0.152400><1.053987,0.035000,0.152400> rotate<0,90.000000,0> translate<63.347603,-1.535000,48.066397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,47.012409>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,47.012409>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,47.012409> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,47.244000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,47.244000>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,47.244000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,47.548800>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.347603,-1.535000,47.853600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,47.853600>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,0.000000,0> translate<63.347603,-1.535000,47.853600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.404428,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.940641,-1.535000,56.083200>}
box{<0,0,-0.152400><2.536212,0.035000,0.152400> rotate<0,0.000000,0> translate<63.404428,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.545991,-1.535000,55.941638>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,55.661572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<63.545991,-1.535000,55.941638> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.571522,-1.535000,53.339997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,53.121572>}
box{<0,0,-0.152400><0.236422,0.035000,0.152400> rotate<0,67.495455,0> translate<63.571522,-1.535000,53.339997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.571522,-1.535000,53.339997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,53.558425>}
box{<0,0,-0.152400><0.236425,0.035000,0.152400> rotate<0,-67.495745,0> translate<63.571522,-1.535000,53.339997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.571522,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.928056,-1.535000,53.340000>}
box{<0,0,-0.152400><0.356534,0.035000,0.152400> rotate<0,0.000000,0> translate<63.571522,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.613606,-1.535000,55.778400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.793666,-1.535000,55.778400>}
box{<0,0,-0.152400><0.180059,0.035000,0.152400> rotate<0,0.000000,0> translate<63.613606,-1.535000,55.778400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,43.373600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.453503,-1.535000,43.373600>}
box{<0,0,-0.152400><0.801112,0.035000,0.152400> rotate<0,0.000000,0> translate<63.652391,-1.535000,43.373600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,44.427588>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,43.373600>}
box{<0,0,-0.152400><1.053987,0.035000,0.152400> rotate<0,-90.000000,0> translate<63.652391,-1.535000,43.373600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,46.707588>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,44.732409>}
box{<0,0,-0.152400><1.975178,0.035000,0.152400> rotate<0,-90.000000,0> translate<63.652391,-1.535000,44.732409> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,48.066397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,47.012409>}
box{<0,0,-0.152400><1.053987,0.035000,0.152400> rotate<0,-90.000000,0> translate<63.652391,-1.535000,47.012409> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652391,-1.535000,48.066397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.453503,-1.535000,48.066397>}
box{<0,0,-0.152400><0.801112,0.035000,0.152400> rotate<0,0.000000,0> translate<63.652391,-1.535000,48.066397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652409,-1.535000,44.427603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652409,-1.535000,44.732391>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,90.000000,0> translate<63.652409,-1.535000,44.732391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652409,-1.535000,44.427603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,44.427603>}
box{<0,0,-0.152400><1.153987,0.035000,0.152400> rotate<0,0.000000,0> translate<63.652409,-1.535000,44.427603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652409,-1.535000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,44.500800>}
box{<0,0,-0.152400><2.743191,0.035000,0.152400> rotate<0,0.000000,0> translate<63.652409,-1.535000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652409,-1.535000,44.732391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,44.732391>}
box{<0,0,-0.152400><1.153987,0.035000,0.152400> rotate<0,0.000000,0> translate<63.652409,-1.535000,44.732391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652409,-1.535000,46.707603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652409,-1.535000,47.012391>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,90.000000,0> translate<63.652409,-1.535000,47.012391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652409,-1.535000,46.707603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,46.707603>}
box{<0,0,-0.152400><1.153987,0.035000,0.152400> rotate<0,0.000000,0> translate<63.652409,-1.535000,46.707603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652409,-1.535000,46.939200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,46.939200>}
box{<0,0,-0.152400><2.743191,0.035000,0.152400> rotate<0,0.000000,0> translate<63.652409,-1.535000,46.939200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.652409,-1.535000,47.012391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,47.012391>}
box{<0,0,-0.152400><1.153987,0.035000,0.152400> rotate<0,0.000000,0> translate<63.652409,-1.535000,47.012391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,51.221997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,53.121572>}
box{<0,0,-0.152400><1.899575,0.035000,0.152400> rotate<0,90.000000,0> translate<63.661997,-1.535000,53.121572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,51.221997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,51.221997>}
box{<0,0,-0.152400><0.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,51.221997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,51.511200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,51.511200>}
box{<0,0,-0.152400><0.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,51.511200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,51.816000>}
box{<0,0,-0.152400><0.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,52.120800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747588,-1.535000,52.120800>}
box{<0,0,-0.152400><1.085591,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,52.120800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,52.425600>}
box{<0,0,-0.152400><0.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,52.730400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,52.730400>}
box{<0,0,-0.152400><0.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,52.730400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.696734,-1.535000,53.035200>}
box{<0,0,-0.152400><0.034738,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,53.558425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,55.661572>}
box{<0,0,-0.152400><2.103147,0.035000,0.152400> rotate<0,90.000000,0> translate<63.661997,-1.535000,55.661572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.696731,-1.535000,53.644800>}
box{<0,0,-0.152400><0.034734,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,53.949600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,53.949600>}
box{<0,0,-0.152400><0.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,53.949600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,54.254400>}
box{<0,0,-0.152400><0.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,54.559200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747588,-1.535000,54.559200>}
box{<0,0,-0.152400><1.085591,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,54.559200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,54.864000>}
box{<0,0,-0.152400><0.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,55.168800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,55.168800>}
box{<0,0,-0.152400><0.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,55.168800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.661997,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,55.473600>}
box{<0,0,-0.152400><0.031603,0.035000,0.152400> rotate<0,0.000000,0> translate<63.661997,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,51.917603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,51.221997>}
box{<0,0,-0.152400><0.695606,0.035000,0.152400> rotate<0,-90.000000,0> translate<63.693600,-1.535000,51.221997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,51.917603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747588,-1.535000,51.917603>}
box{<0,0,-0.152400><1.053988,0.035000,0.152400> rotate<0,0.000000,0> translate<63.693600,-1.535000,51.917603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,52.222391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747588,-1.535000,52.222391>}
box{<0,0,-0.152400><1.053988,0.035000,0.152400> rotate<0,0.000000,0> translate<63.693600,-1.535000,52.222391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,53.023503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,52.222391>}
box{<0,0,-0.152400><0.801113,0.035000,0.152400> rotate<0,-90.000000,0> translate<63.693600,-1.535000,52.222391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,53.023503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.721294,-1.535000,53.126863>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-74.995728,0> translate<63.693600,-1.535000,53.023503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,53.656494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.721294,-1.535000,53.553134>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,74.995728,0> translate<63.693600,-1.535000,53.656494> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,54.457603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,53.656494>}
box{<0,0,-0.152400><0.801109,0.035000,0.152400> rotate<0,-90.000000,0> translate<63.693600,-1.535000,53.656494> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,54.457603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747588,-1.535000,54.457603>}
box{<0,0,-0.152400><1.053988,0.035000,0.152400> rotate<0,0.000000,0> translate<63.693600,-1.535000,54.457603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,54.762391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747588,-1.535000,54.762391>}
box{<0,0,-0.152400><1.053988,0.035000,0.152400> rotate<0,0.000000,0> translate<63.693600,-1.535000,54.762391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,55.563503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,54.762391>}
box{<0,0,-0.152400><0.801113,0.035000,0.152400> rotate<0,-90.000000,0> translate<63.693600,-1.535000,54.762391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.693600,-1.535000,55.563503>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.721294,-1.535000,55.666863>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-74.995728,0> translate<63.693600,-1.535000,55.563503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.721294,-1.535000,53.126863>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.774800,-1.535000,53.219534>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-59.995058,0> translate<63.721294,-1.535000,53.126863> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.721294,-1.535000,53.553134>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.774800,-1.535000,53.460463>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,59.995058,0> translate<63.721294,-1.535000,53.553134> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.721294,-1.535000,55.666863>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.774800,-1.535000,55.759534>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-59.995058,0> translate<63.721294,-1.535000,55.666863> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.774800,-1.535000,53.219534>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.850463,-1.535000,53.295197>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,-44.997030,0> translate<63.774800,-1.535000,53.219534> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.774800,-1.535000,53.460463>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.850463,-1.535000,53.384800>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,44.997030,0> translate<63.774800,-1.535000,53.460463> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.774800,-1.535000,55.759534>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.850463,-1.535000,55.835197>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,-44.997030,0> translate<63.774800,-1.535000,55.759534> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.850463,-1.535000,53.295197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.928063,-1.535000,53.339997>}
box{<0,0,-0.152400><0.089604,0.035000,0.152400> rotate<0,-29.996702,0> translate<63.850463,-1.535000,53.295197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.850463,-1.535000,53.384800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.928063,-1.535000,53.339997>}
box{<0,0,-0.152400><0.089605,0.035000,0.152400> rotate<0,29.998432,0> translate<63.850463,-1.535000,53.384800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.850463,-1.535000,55.835197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.943134,-1.535000,55.888703>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-29.999002,0> translate<63.850463,-1.535000,55.835197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<63.943134,-1.535000,55.888703>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.046494,-1.535000,55.916397>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-14.998332,0> translate<63.943134,-1.535000,55.888703> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.046494,-1.535000,55.916397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,55.916397>}
box{<0,0,-0.152400><0.701109,0.035000,0.152400> rotate<0,0.000000,0> translate<64.046494,-1.535000,55.916397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.316884,-1.535000,37.693600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.652966,-1.535000,37.832809>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-22.498510,0> translate<64.316884,-1.535000,37.693600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.391241,-1.535000,57.632600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,55.628241>}
box{<0,0,-0.152400><2.834592,0.035000,0.152400> rotate<0,44.997030,0> translate<64.391241,-1.535000,57.632600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.453503,-1.535000,43.373600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.556863,-1.535000,43.401294>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-14.998332,0> translate<64.453503,-1.535000,43.373600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.453503,-1.535000,48.066397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.556863,-1.535000,48.038703>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,14.998332,0> translate<64.453503,-1.535000,48.066397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.551572,-1.535000,43.341997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.831637,-1.535000,43.225991>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,22.498388,0> translate<64.551572,-1.535000,43.341997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.551572,-1.535000,48.098000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.831637,-1.535000,48.214006>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-22.498388,0> translate<64.551572,-1.535000,48.098000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.556863,-1.535000,43.401294>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.649534,-1.535000,43.454800>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-29.999002,0> translate<64.556863,-1.535000,43.401294> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.556863,-1.535000,48.038703>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.649534,-1.535000,47.985197>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,29.999002,0> translate<64.556863,-1.535000,48.038703> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.562166,-1.535000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,37.795200>}
box{<0,0,-0.152400><3.662434,0.035000,0.152400> rotate<0,0.000000,0> translate<64.562166,-1.535000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.623897,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.649534,-1.535000,45.705197>}
box{<0,0,-0.152400><0.029604,0.035000,0.152400> rotate<0,30.000211,0> translate<64.623897,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.623897,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.649534,-1.535000,45.734800>}
box{<0,0,-0.152400><0.029603,0.035000,0.152400> rotate<0,-29.994974,0> translate<64.623897,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.623897,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,45.720000>}
box{<0,0,-0.152400><1.771703,0.035000,0.152400> rotate<0,0.000000,0> translate<64.623897,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.649534,-1.535000,43.454800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.725197,-1.535000,43.530462>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,-44.997030,0> translate<64.649534,-1.535000,43.454800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.649534,-1.535000,45.705197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.725197,-1.535000,45.629534>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,44.997030,0> translate<64.649534,-1.535000,45.705197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.649534,-1.535000,45.734800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.725197,-1.535000,45.810462>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,-44.997030,0> translate<64.649534,-1.535000,45.734800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.649534,-1.535000,47.985197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.725197,-1.535000,47.909534>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,44.997030,0> translate<64.649534,-1.535000,47.985197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.652966,-1.535000,37.832809>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.910188,-1.535000,38.090031>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,-44.997030,0> translate<64.652966,-1.535000,37.832809> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.697384,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,43.281600>}
box{<0,0,-0.152400><1.698216,0.035000,0.152400> rotate<0,0.000000,0> translate<64.697384,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.697391,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,48.158400>}
box{<0,0,-0.152400><1.698209,0.035000,0.152400> rotate<0,0.000000,0> translate<64.697391,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.725197,-1.535000,43.530462>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.778703,-1.535000,43.623134>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-59.995058,0> translate<64.725197,-1.535000,43.530462> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.725197,-1.535000,45.629534>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.778703,-1.535000,45.536863>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,59.995058,0> translate<64.725197,-1.535000,45.629534> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.725197,-1.535000,45.810462>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.778703,-1.535000,45.903134>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-59.995058,0> translate<64.725197,-1.535000,45.810462> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.725197,-1.535000,47.909534>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.778703,-1.535000,47.816862>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,59.995058,0> translate<64.725197,-1.535000,47.909534> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747588,-1.535000,52.222391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747588,-1.535000,51.917603>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,-90.000000,0> translate<64.747588,-1.535000,51.917603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747588,-1.535000,54.762391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747588,-1.535000,54.457603>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,-90.000000,0> translate<64.747588,-1.535000,54.457603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,52.222409>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,54.457588>}
box{<0,0,-0.152400><2.235178,0.035000,0.152400> rotate<0,90.000000,0> translate<64.747603,-1.535000,54.457588> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,52.222409>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,52.222409>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,52.222409> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,52.425600>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,52.730400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,52.730400>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,52.730400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,53.035200>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,53.340000>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,53.644800>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,53.949600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,53.949600>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,53.949600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,54.254400>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,54.457588>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,54.457588>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,54.457588> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,54.762409>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,55.916397>}
box{<0,0,-0.152400><1.153987,0.035000,0.152400> rotate<0,90.000000,0> translate<64.747603,-1.535000,55.916397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,54.762409>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,54.762409>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,54.762409> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,54.864000>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,55.168800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,55.168800>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,55.168800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,55.473600>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.747603,-1.535000,55.778400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,55.778400>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,0.000000,0> translate<64.747603,-1.535000,55.778400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.757491,-1.535000,43.586400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,43.586400>}
box{<0,0,-0.152400><1.638109,0.035000,0.152400> rotate<0,0.000000,0> translate<64.757491,-1.535000,43.586400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.757494,-1.535000,47.853600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,47.853600>}
box{<0,0,-0.152400><1.638106,0.035000,0.152400> rotate<0,0.000000,0> translate<64.757494,-1.535000,47.853600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.778703,-1.535000,43.623134>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,43.726494>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-74.995728,0> translate<64.778703,-1.535000,43.623134> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.778703,-1.535000,45.536863>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,45.433503>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,74.995728,0> translate<64.778703,-1.535000,45.536863> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.778703,-1.535000,45.903134>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,46.006494>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-74.995728,0> translate<64.778703,-1.535000,45.903134> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.778703,-1.535000,47.816862>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,47.713503>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,74.995728,0> translate<64.778703,-1.535000,47.816862> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,43.726494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,44.427603>}
box{<0,0,-0.152400><0.701109,0.035000,0.152400> rotate<0,90.000000,0> translate<64.806397,-1.535000,44.427603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,43.891200>}
box{<0,0,-0.152400><1.589203,0.035000,0.152400> rotate<0,0.000000,0> translate<64.806397,-1.535000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,44.196000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,44.196000>}
box{<0,0,-0.152400><1.589203,0.035000,0.152400> rotate<0,0.000000,0> translate<64.806397,-1.535000,44.196000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,44.732391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,45.433503>}
box{<0,0,-0.152400><0.701113,0.035000,0.152400> rotate<0,90.000000,0> translate<64.806397,-1.535000,45.433503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,44.805600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,44.805600>}
box{<0,0,-0.152400><1.589203,0.035000,0.152400> rotate<0,0.000000,0> translate<64.806397,-1.535000,44.805600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,45.110400>}
box{<0,0,-0.152400><1.589203,0.035000,0.152400> rotate<0,0.000000,0> translate<64.806397,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,45.415200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,45.415200>}
box{<0,0,-0.152400><1.589203,0.035000,0.152400> rotate<0,0.000000,0> translate<64.806397,-1.535000,45.415200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,46.006494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,46.707603>}
box{<0,0,-0.152400><0.701109,0.035000,0.152400> rotate<0,90.000000,0> translate<64.806397,-1.535000,46.707603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,46.024800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,46.024800>}
box{<0,0,-0.152400><1.589203,0.035000,0.152400> rotate<0,0.000000,0> translate<64.806397,-1.535000,46.024800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,46.329600>}
box{<0,0,-0.152400><1.589203,0.035000,0.152400> rotate<0,0.000000,0> translate<64.806397,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,46.634400>}
box{<0,0,-0.152400><1.589203,0.035000,0.152400> rotate<0,0.000000,0> translate<64.806397,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,47.012391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,47.713503>}
box{<0,0,-0.152400><0.701113,0.035000,0.152400> rotate<0,90.000000,0> translate<64.806397,-1.535000,47.713503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,47.244000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,47.244000>}
box{<0,0,-0.152400><1.589203,0.035000,0.152400> rotate<0,0.000000,0> translate<64.806397,-1.535000,47.244000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.806397,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,47.548800>}
box{<0,0,-0.152400><1.589203,0.035000,0.152400> rotate<0,0.000000,0> translate<64.806397,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.831637,-1.535000,43.225991>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.045991,-1.535000,43.011637>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,44.997030,0> translate<64.831637,-1.535000,43.225991> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.831637,-1.535000,48.214006>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.045991,-1.535000,48.428359>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-44.997030,0> translate<64.831637,-1.535000,48.214006> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.910188,-1.535000,38.090031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.085188,-1.535000,41.265031>}
box{<0,0,-0.152400><4.490128,0.035000,0.152400> rotate<0,-44.997030,0> translate<64.910188,-1.535000,38.090031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.920156,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,38.100000>}
box{<0,0,-0.152400><3.304444,0.035000,0.152400> rotate<0,0.000000,0> translate<64.920156,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<64.951884,-1.535000,59.461397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.287966,-1.535000,59.322188>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,22.498510,0> translate<64.951884,-1.535000,59.461397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.013200,-1.535000,59.436000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,59.436000>}
box{<0,0,-0.152400><3.211400,0.035000,0.152400> rotate<0,0.000000,0> translate<65.013200,-1.535000,59.436000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.045991,-1.535000,43.011637>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,42.731572>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,67.495673,0> translate<65.045991,-1.535000,43.011637> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.045991,-1.535000,48.428359>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,48.708425>}
box{<0,0,-0.152400><0.303141,0.035000,0.152400> rotate<0,-67.495673,0> translate<65.045991,-1.535000,48.428359> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,53.303600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,52.222409>}
box{<0,0,-0.152400><1.081191,0.035000,0.152400> rotate<0,-90.000000,0> translate<65.052391,-1.535000,52.222409> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,54.457588>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,53.303600>}
box{<0,0,-0.152400><1.153987,0.035000,0.152400> rotate<0,-90.000000,0> translate<65.052391,-1.535000,53.303600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,55.916397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,54.762409>}
box{<0,0,-0.152400><1.153987,0.035000,0.152400> rotate<0,-90.000000,0> translate<65.052391,-1.535000,54.762409> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052391,-1.535000,55.916397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.753503,-1.535000,55.916397>}
box{<0,0,-0.152400><0.701113,0.035000,0.152400> rotate<0,0.000000,0> translate<65.052391,-1.535000,55.916397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052409,-1.535000,51.917603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052409,-1.535000,52.222391>}
box{<0,0,-0.152400><0.304788,0.035000,0.152400> rotate<0,90.000000,0> translate<65.052409,-1.535000,52.222391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052409,-1.535000,51.917603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,51.917603>}
box{<0,0,-0.152400><1.053988,0.035000,0.152400> rotate<0,0.000000,0> translate<65.052409,-1.535000,51.917603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052409,-1.535000,52.120800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,52.120800>}
box{<0,0,-0.152400><1.343191,0.035000,0.152400> rotate<0,0.000000,0> translate<65.052409,-1.535000,52.120800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052409,-1.535000,52.222391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,52.222391>}
box{<0,0,-0.152400><1.053988,0.035000,0.152400> rotate<0,0.000000,0> translate<65.052409,-1.535000,52.222391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052409,-1.535000,54.457603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052409,-1.535000,54.762391>}
box{<0,0,-0.152400><0.304787,0.035000,0.152400> rotate<0,90.000000,0> translate<65.052409,-1.535000,54.762391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052409,-1.535000,54.457603>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,54.457603>}
box{<0,0,-0.152400><1.053988,0.035000,0.152400> rotate<0,0.000000,0> translate<65.052409,-1.535000,54.457603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052409,-1.535000,54.559200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,54.559200>}
box{<0,0,-0.152400><1.343191,0.035000,0.152400> rotate<0,0.000000,0> translate<65.052409,-1.535000,54.559200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.052409,-1.535000,54.762391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,54.762391>}
box{<0,0,-0.152400><1.053988,0.035000,0.152400> rotate<0,0.000000,0> translate<65.052409,-1.535000,54.762391> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.060422,-1.535000,42.976800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,42.976800>}
box{<0,0,-0.152400><1.335178,0.035000,0.152400> rotate<0,0.000000,0> translate<65.060422,-1.535000,42.976800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.060422,-1.535000,48.463200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,48.463200>}
box{<0,0,-0.152400><1.335178,0.035000,0.152400> rotate<0,0.000000,0> translate<65.060422,-1.535000,48.463200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.099022,-1.535000,50.763600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,50.611572>}
box{<0,0,-0.152400><0.164555,0.035000,0.152400> rotate<0,67.494616,0> translate<65.099022,-1.535000,50.763600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.099022,-1.535000,50.763600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.753503,-1.535000,50.763600>}
box{<0,0,-0.152400><0.654481,0.035000,0.152400> rotate<0,0.000000,0> translate<65.099022,-1.535000,50.763600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,40.928150>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,42.731572>}
box{<0,0,-0.152400><1.803422,0.035000,0.152400> rotate<0,90.000000,0> translate<65.161997,-1.535000,42.731572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,40.928150>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,42.161756>}
box{<0,0,-0.152400><1.744580,0.035000,0.152400> rotate<0,-44.997103,0> translate<65.161997,-1.535000,40.928150> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,41.148000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.381847,-1.535000,41.148000>}
box{<0,0,-0.152400><0.219850,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,41.148000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.686647,-1.535000,41.452800>}
box{<0,0,-0.152400><0.524650,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,41.757600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.991447,-1.535000,41.757600>}
box{<0,0,-0.152400><0.829450,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,41.757600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.296247,-1.535000,42.062400>}
box{<0,0,-0.152400><1.134250,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,42.367200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,42.367200>}
box{<0,0,-0.152400><1.233603,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,42.367200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,42.672000>}
box{<0,0,-0.152400><1.233603,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,48.708425>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,50.611572>}
box{<0,0,-0.152400><1.903147,0.035000,0.152400> rotate<0,90.000000,0> translate<65.161997,-1.535000,50.611572> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,48.768000>}
box{<0,0,-0.152400><1.233603,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,48.768000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,49.072800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,49.072800>}
box{<0,0,-0.152400><1.233603,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,49.072800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,49.377600>}
box{<0,0,-0.152400><1.233603,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,49.682400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,49.682400>}
box{<0,0,-0.152400><1.233603,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,49.682400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,49.987200>}
box{<0,0,-0.152400><1.233603,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,50.292000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,50.292000>}
box{<0,0,-0.152400><1.233603,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,50.292000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.161997,-1.535000,50.596800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,50.596800>}
box{<0,0,-0.152400><1.233603,0.035000,0.152400> rotate<0,0.000000,0> translate<65.161997,-1.535000,50.596800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.224956,-1.535000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,38.404800>}
box{<0,0,-0.152400><2.999644,0.035000,0.152400> rotate<0,0.000000,0> translate<65.224956,-1.535000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.287966,-1.535000,59.322188>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.827966,-1.535000,56.782188>}
box{<0,0,-0.152400><3.592102,0.035000,0.152400> rotate<0,44.997030,0> translate<65.287966,-1.535000,59.322188> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.478953,-1.535000,59.131200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,59.131200>}
box{<0,0,-0.152400><2.745647,0.035000,0.152400> rotate<0,0.000000,0> translate<65.478953,-1.535000,59.131200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.529756,-1.535000,38.709600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,38.709600>}
box{<0,0,-0.152400><2.694844,0.035000,0.152400> rotate<0,0.000000,0> translate<65.529756,-1.535000,38.709600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.753503,-1.535000,50.763600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.856863,-1.535000,50.791294>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-14.998332,0> translate<65.753503,-1.535000,50.763600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.753503,-1.535000,55.916397>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.856863,-1.535000,55.888703>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,14.998332,0> translate<65.753503,-1.535000,55.916397> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.783753,-1.535000,58.826400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,58.826400>}
box{<0,0,-0.152400><2.440847,0.035000,0.152400> rotate<0,0.000000,0> translate<65.783753,-1.535000,58.826400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.834556,-1.535000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,39.014400>}
box{<0,0,-0.152400><2.390044,0.035000,0.152400> rotate<0,0.000000,0> translate<65.834556,-1.535000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.856863,-1.535000,50.791294>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.949534,-1.535000,50.844800>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-29.999002,0> translate<65.856863,-1.535000,50.791294> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.856863,-1.535000,55.888703>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.949534,-1.535000,55.835197>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,29.999002,0> translate<65.856863,-1.535000,55.888703> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.871934,-1.535000,53.339997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.949534,-1.535000,53.295197>}
box{<0,0,-0.152400><0.089604,0.035000,0.152400> rotate<0,29.996702,0> translate<65.871934,-1.535000,53.339997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.871934,-1.535000,53.339997>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.949534,-1.535000,53.384800>}
box{<0,0,-0.152400><0.089605,0.035000,0.152400> rotate<0,-29.998432,0> translate<65.871934,-1.535000,53.339997> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.871938,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,53.340000>}
box{<0,0,-0.152400><0.523663,0.035000,0.152400> rotate<0,0.000000,0> translate<65.871938,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.949534,-1.535000,50.844800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.025197,-1.535000,50.920462>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,-44.997030,0> translate<65.949534,-1.535000,50.844800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.949534,-1.535000,53.295197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.025197,-1.535000,53.219534>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,44.997030,0> translate<65.949534,-1.535000,53.295197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.949534,-1.535000,53.384800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.025197,-1.535000,53.460463>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,-44.997030,0> translate<65.949534,-1.535000,53.384800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<65.949534,-1.535000,55.835197>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.025197,-1.535000,55.759534>}
box{<0,0,-0.152400><0.107003,0.035000,0.152400> rotate<0,44.997030,0> translate<65.949534,-1.535000,55.835197> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.006331,-1.535000,55.778400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.245441,-1.535000,55.778400>}
box{<0,0,-0.152400><0.239109,0.035000,0.152400> rotate<0,0.000000,0> translate<66.006331,-1.535000,55.778400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.006334,-1.535000,50.901600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,50.901600>}
box{<0,0,-0.152400><0.389266,0.035000,0.152400> rotate<0,0.000000,0> translate<66.006334,-1.535000,50.901600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.025197,-1.535000,50.920462>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.078703,-1.535000,51.013134>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-59.995058,0> translate<66.025197,-1.535000,50.920462> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.025197,-1.535000,53.219534>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.078703,-1.535000,53.126863>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,59.995058,0> translate<66.025197,-1.535000,53.219534> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.025197,-1.535000,53.460463>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.078703,-1.535000,53.553134>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,-59.995058,0> translate<66.025197,-1.535000,53.460463> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.025197,-1.535000,55.759534>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.078703,-1.535000,55.666863>}
box{<0,0,-0.152400><0.107009,0.035000,0.152400> rotate<0,59.995058,0> translate<66.025197,-1.535000,55.759534> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.078703,-1.535000,51.013134>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,51.116494>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-74.995728,0> translate<66.078703,-1.535000,51.013134> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.078703,-1.535000,53.126863>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,53.023503>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,74.995728,0> translate<66.078703,-1.535000,53.126863> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.078703,-1.535000,53.553134>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,53.656494>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,-74.995728,0> translate<66.078703,-1.535000,53.553134> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.078703,-1.535000,55.666863>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,55.563503>}
box{<0,0,-0.152400><0.107005,0.035000,0.152400> rotate<0,74.995728,0> translate<66.078703,-1.535000,55.666863> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.088553,-1.535000,58.521600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,58.521600>}
box{<0,0,-0.152400><2.136047,0.035000,0.152400> rotate<0,0.000000,0> translate<66.088553,-1.535000,58.521600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.103262,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,53.644800>}
box{<0,0,-0.152400><0.292338,0.035000,0.152400> rotate<0,0.000000,0> translate<66.103262,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.103266,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,53.035200>}
box{<0,0,-0.152400><0.292334,0.035000,0.152400> rotate<0,0.000000,0> translate<66.103266,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,51.116494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,51.917603>}
box{<0,0,-0.152400><0.801109,0.035000,0.152400> rotate<0,90.000000,0> translate<66.106397,-1.535000,51.917603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,51.206400>}
box{<0,0,-0.152400><0.289203,0.035000,0.152400> rotate<0,0.000000,0> translate<66.106397,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,51.511200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,51.511200>}
box{<0,0,-0.152400><0.289203,0.035000,0.152400> rotate<0,0.000000,0> translate<66.106397,-1.535000,51.511200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,51.816000>}
box{<0,0,-0.152400><0.289203,0.035000,0.152400> rotate<0,0.000000,0> translate<66.106397,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,52.222391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,53.023503>}
box{<0,0,-0.152400><0.801113,0.035000,0.152400> rotate<0,90.000000,0> translate<66.106397,-1.535000,53.023503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,52.425600>}
box{<0,0,-0.152400><0.289203,0.035000,0.152400> rotate<0,0.000000,0> translate<66.106397,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,52.730400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,52.730400>}
box{<0,0,-0.152400><0.289203,0.035000,0.152400> rotate<0,0.000000,0> translate<66.106397,-1.535000,52.730400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,53.656494>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,54.457603>}
box{<0,0,-0.152400><0.801109,0.035000,0.152400> rotate<0,90.000000,0> translate<66.106397,-1.535000,54.457603> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,53.949600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,53.949600>}
box{<0,0,-0.152400><0.289203,0.035000,0.152400> rotate<0,0.000000,0> translate<66.106397,-1.535000,53.949600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,54.254400>}
box{<0,0,-0.152400><0.289203,0.035000,0.152400> rotate<0,0.000000,0> translate<66.106397,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,54.762391>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,55.563503>}
box{<0,0,-0.152400><0.801113,0.035000,0.152400> rotate<0,90.000000,0> translate<66.106397,-1.535000,55.563503> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,54.864000>}
box{<0,0,-0.152400><0.289203,0.035000,0.152400> rotate<0,0.000000,0> translate<66.106397,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,55.168800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,55.168800>}
box{<0,0,-0.152400><0.289203,0.035000,0.152400> rotate<0,0.000000,0> translate<66.106397,-1.535000,55.168800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.106397,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,55.473600>}
box{<0,0,-0.152400><0.289203,0.035000,0.152400> rotate<0,0.000000,0> translate<66.106397,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.139356,-1.535000,39.319200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,39.319200>}
box{<0,0,-0.152400><2.085244,0.035000,0.152400> rotate<0,0.000000,0> translate<66.139356,-1.535000,39.319200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.393353,-1.535000,58.216800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,58.216800>}
box{<0,0,-0.152400><1.831247,0.035000,0.152400> rotate<0,0.000000,0> translate<66.393353,-1.535000,58.216800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,55.628241>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.395600,-1.535000,42.161756>}
box{<0,0,-0.152400><13.466484,0.035000,0.152400> rotate<0,-90.000000,0> translate<66.395600,-1.535000,42.161756> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.444156,-1.535000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,39.624000>}
box{<0,0,-0.152400><1.780444,0.035000,0.152400> rotate<0,0.000000,0> translate<66.444156,-1.535000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.698153,-1.535000,57.912000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,57.912000>}
box{<0,0,-0.152400><1.526447,0.035000,0.152400> rotate<0,0.000000,0> translate<66.698153,-1.535000,57.912000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<66.748956,-1.535000,39.928800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,39.928800>}
box{<0,0,-0.152400><1.475644,0.035000,0.152400> rotate<0,0.000000,0> translate<66.748956,-1.535000,39.928800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.002953,-1.535000,57.607200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,57.607200>}
box{<0,0,-0.152400><1.221647,0.035000,0.152400> rotate<0,0.000000,0> translate<67.002953,-1.535000,57.607200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.053756,-1.535000,40.233600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,40.233600>}
box{<0,0,-0.152400><1.170844,0.035000,0.152400> rotate<0,0.000000,0> translate<67.053756,-1.535000,40.233600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.307753,-1.535000,57.302400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,57.302400>}
box{<0,0,-0.152400><0.916847,0.035000,0.152400> rotate<0,0.000000,0> translate<67.307753,-1.535000,57.302400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.358556,-1.535000,40.538400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,40.538400>}
box{<0,0,-0.152400><0.866044,0.035000,0.152400> rotate<0,0.000000,0> translate<67.358556,-1.535000,40.538400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.612553,-1.535000,56.997600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,56.997600>}
box{<0,0,-0.152400><0.612047,0.035000,0.152400> rotate<0,0.000000,0> translate<67.612553,-1.535000,56.997600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.663356,-1.535000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,40.843200>}
box{<0,0,-0.152400><0.561244,0.035000,0.152400> rotate<0,0.000000,0> translate<67.663356,-1.535000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.827966,-1.535000,56.782188>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.085188,-1.535000,56.524966>}
box{<0,0,-0.152400><0.363767,0.035000,0.152400> rotate<0,44.997030,0> translate<67.827966,-1.535000,56.782188> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.917353,-1.535000,56.692800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,56.692800>}
box{<0,0,-0.152400><0.307247,0.035000,0.152400> rotate<0,0.000000,0> translate<67.917353,-1.535000,56.692800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<67.968156,-1.535000,41.148000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,41.148000>}
box{<0,0,-0.152400><0.256444,0.035000,0.152400> rotate<0,0.000000,0> translate<67.968156,-1.535000,41.148000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.085188,-1.535000,41.265031>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,41.601112>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,-67.495551,0> translate<68.085188,-1.535000,41.265031> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.085188,-1.535000,56.524966>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,56.188884>}
box{<0,0,-0.152400><0.363772,0.035000,0.152400> rotate<0,67.495551,0> translate<68.085188,-1.535000,56.524966> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.141922,-1.535000,56.388000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,56.388000>}
box{<0,0,-0.152400><0.082678,0.035000,0.152400> rotate<0,0.000000,0> translate<68.141922,-1.535000,56.388000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.162963,-1.535000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,41.452800>}
box{<0,0,-0.152400><0.061638,0.035000,0.152400> rotate<0,0.000000,0> translate<68.162963,-1.535000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,41.601112>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,56.188884>}
box{<0,0,-0.152400><14.587772,0.035000,0.152400> rotate<0,90.000000,0> translate<68.224397,-1.535000,56.188884> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,41.757600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,41.757600>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,41.757600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,42.062400>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,42.367200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,42.367200>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,42.367200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,42.672000>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,42.976800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,42.976800>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,42.976800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,43.281600>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,43.586400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,43.586400>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,43.586400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,43.891200>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,44.196000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,44.196000>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,44.196000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,44.500800>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,44.805600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,44.805600>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,44.805600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,45.110400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,45.110400>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,45.110400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,45.415200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,45.415200>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,45.415200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,45.720000>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,46.024800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,46.024800>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,46.024800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,46.329600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,46.329600>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,46.329600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,46.634400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,46.634400>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,46.634400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,46.939200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,46.939200>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,46.939200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,47.244000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,47.244000>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,47.244000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,47.548800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,47.548800>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,47.548800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,47.853600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,47.853600>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,47.853600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,48.158400>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,48.463200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,48.463200>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,48.463200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,48.768000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,48.768000>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,48.768000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,49.072800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,49.072800>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,49.072800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,49.377600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,49.377600>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,49.377600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,49.682400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,49.682400>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,49.682400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,49.987200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,49.987200>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,49.987200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,50.292000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,50.292000>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,50.292000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,50.596800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,50.596800>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,50.596800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,50.901600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,50.901600>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,50.901600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,51.206400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,51.206400>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,51.206400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,51.511200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,51.511200>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,51.511200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,51.816000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,51.816000>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,51.816000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,52.120800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,52.120800>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,52.120800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,52.425600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,52.425600>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,52.425600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,52.730400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,52.730400>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,52.730400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,53.035200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,53.035200>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,53.035200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,53.340000>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,53.644800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,53.644800>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,53.644800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,53.949600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,53.949600>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,53.949600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,54.254400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,54.254400>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,54.254400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,54.559200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,54.559200>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,54.559200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,54.864000>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,54.864000>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,54.864000> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,55.168800>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,55.168800>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,55.168800> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,55.473600>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,55.473600>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,55.473600> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,55.778400>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,55.778400>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,55.778400> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224397,-1.535000,56.083200>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,56.083200>}
box{<0,0,-0.152400><0.000203,0.035000,0.152400> rotate<0,0.000000,0> translate<68.224397,-1.535000,56.083200> }
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,60.541016>}
cylinder{<0,0,0><0,0.035000,0>0.152400 translate<68.224600,-1.535000,10.947397>}
box{<0,0,-0.152400><49.593619,0.035000,0.152400> rotate<0,-90.000000,0> translate<68.224600,-1.535000,10.947397> }
texture{col_pol}
}
#end
union{
cylinder{<53.340000,0.038000,13.970000><53.340000,-1.538000,13.970000>0.508000}
cylinder{<50.800000,0.038000,13.970000><50.800000,-1.538000,13.970000>0.508000}
cylinder{<48.260000,0.038000,13.970000><48.260000,-1.538000,13.970000>0.508000}
cylinder{<45.720000,0.038000,13.970000><45.720000,-1.538000,13.970000>0.508000}
cylinder{<43.180000,0.038000,13.970000><43.180000,-1.538000,13.970000>0.508000}
cylinder{<40.640000,0.038000,13.970000><40.640000,-1.538000,13.970000>0.508000}
cylinder{<38.100000,0.038000,13.970000><38.100000,-1.538000,13.970000>0.508000}
cylinder{<35.560000,0.038000,13.970000><35.560000,-1.538000,13.970000>0.508000}
cylinder{<45.720000,0.038000,50.800000><45.720000,-1.538000,50.800000>0.508000}
cylinder{<48.260000,0.038000,50.800000><48.260000,-1.538000,50.800000>0.508000}
cylinder{<50.800000,0.038000,50.800000><50.800000,-1.538000,50.800000>0.508000}
cylinder{<51.993800,0.038000,55.880000><51.993800,-1.538000,55.880000>0.660400}
cylinder{<46.990000,0.038000,55.880000><46.990000,-1.538000,55.880000>0.660400}
cylinder{<41.986200,0.038000,55.880000><41.986200,-1.538000,55.880000>0.660400}
cylinder{<17.272000,0.038000,43.647000><17.272000,-1.538000,43.647000>0.450000 }
cylinder{<17.272000,0.038000,48.047000><17.272000,-1.538000,48.047000>0.450000 }
cylinder{<17.272000,0.038000,43.647000><17.272000,-1.538000,43.647000>0.450000 }
cylinder{<17.272000,0.038000,48.047000><17.272000,-1.538000,48.047000>0.450000 }
cylinder{<17.272000,0.038000,43.647000><17.272000,-1.538000,43.647000>0.450000 }
cylinder{<17.272000,0.038000,48.047000><17.272000,-1.538000,48.047000>0.450000 }
cylinder{<17.272000,0.038000,43.647000><17.272000,-1.538000,43.647000>0.450000 }
cylinder{<17.272000,0.038000,48.047000><17.272000,-1.538000,48.047000>0.450000 }
cylinder{<17.272000,0.038000,43.647000><17.272000,-1.538000,43.647000>0.450000 }
cylinder{<17.272000,0.038000,48.047000><17.272000,-1.538000,48.047000>0.450000 }
cylinder{<17.272000,0.038000,43.647000><17.272000,-1.538000,43.647000>0.450000 }
cylinder{<17.272000,0.038000,48.047000><17.272000,-1.538000,48.047000>0.450000 }
cylinder{<17.272000,0.038000,43.647000><17.272000,-1.538000,43.647000>0.450000 }
cylinder{<17.272000,0.038000,48.047000><17.272000,-1.538000,48.047000>0.450000 }
cylinder{<17.272000,0.038000,43.647000><17.272000,-1.538000,43.647000>0.450000 }
cylinder{<17.272000,0.038000,48.047000><17.272000,-1.538000,48.047000>0.450000 }
cylinder{<17.272000,0.038000,43.647000><17.272000,-1.538000,43.647000>0.450000 }
cylinder{<17.272000,0.038000,48.047000><17.272000,-1.538000,48.047000>0.450000 }
cylinder{<59.690000,0.038000,52.070000><59.690000,-1.538000,52.070000>0.406400}
cylinder{<59.690000,0.038000,54.610000><59.690000,-1.538000,54.610000>0.406400}
cylinder{<59.690000,0.038000,43.307000><59.690000,-1.538000,43.307000>0.406400}
cylinder{<59.690000,0.038000,48.133000><59.690000,-1.538000,48.133000>0.406400}
//Holes(fast)/Vias
cylinder{<23.876000,0.038000,41.275000><23.876000,-1.538000,41.275000>0.300000 }
cylinder{<23.876000,0.038000,51.689000><23.876000,-1.538000,51.689000>0.300000 }
cylinder{<54.864000,0.038000,60.325000><54.864000,-1.538000,60.325000>0.300000 }
cylinder{<54.864000,0.038000,54.483000><54.864000,-1.538000,54.483000>0.300000 }
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
//C-XA-1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.713000,-1.536000,49.225000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.713000,-1.536000,47.295000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,-90.000000,0> translate<62.713000,-1.536000,47.295000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.287000,-1.536000,49.225000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.287000,-1.536000,47.295000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,-90.000000,0> translate<64.287000,-1.536000,47.295000> }
box{<-0.375050,0,-0.850000><0.375050,0.036000,0.850000> rotate<0,-270.000000,0> translate<63.500900,-1.536000,49.586750>}
box{<-0.375050,0,-0.850000><0.375050,0.036000,0.850000> rotate<0,-270.000000,0> translate<63.499100,-1.536000,46.933250>}
//C-XA-2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.287000,-1.536000,42.215000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.287000,-1.536000,44.145000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,90.000000,0> translate<64.287000,-1.536000,44.145000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.713000,-1.536000,42.215000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.713000,-1.536000,44.145000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,90.000000,0> translate<62.713000,-1.536000,44.145000> }
box{<-0.375050,0,-0.850000><0.375050,0.036000,0.850000> rotate<0,-90.000000,0> translate<63.499100,-1.536000,41.853250>}
box{<-0.375050,0,-0.850000><0.375050,0.036000,0.850000> rotate<0,-90.000000,0> translate<63.500900,-1.536000,44.506750>}
//C-XB-1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.465000,-1.536000,52.857000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.535000,-1.536000,52.857000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,0.000000,0> translate<62.535000,-1.536000,52.857000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.465000,-1.536000,51.283000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.535000,-1.536000,51.283000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,0.000000,0> translate<62.535000,-1.536000,51.283000> }
box{<-0.375050,0,-0.850000><0.375050,0.036000,0.850000> rotate<0,-180.000000,0> translate<64.826750,-1.536000,52.069100>}
box{<-0.375050,0,-0.850000><0.375050,0.036000,0.850000> rotate<0,-180.000000,0> translate<62.173250,-1.536000,52.070900>}
//C-XB-2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.465000,-1.536000,55.397000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.535000,-1.536000,55.397000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,0.000000,0> translate<62.535000,-1.536000,55.397000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<64.465000,-1.536000,53.823000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<62.535000,-1.536000,53.823000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,0.000000,0> translate<62.535000,-1.536000,53.823000> }
box{<-0.375050,0,-0.850000><0.375050,0.036000,0.850000> rotate<0,-180.000000,0> translate<64.826750,-1.536000,54.609100>}
box{<-0.375050,0,-0.850000><0.375050,0.036000,0.850000> rotate<0,-180.000000,0> translate<62.173250,-1.536000,54.610900>}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.588000,-1.536000,54.122000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.588000,-1.536000,43.922000>}
box{<0,0,-0.101600><10.200000,0.036000,0.101600> rotate<0,-90.000000,0> translate<33.588000,-1.536000,43.922000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.588000,-1.536000,43.922000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.388000,-1.536000,43.922000>}
box{<0,0,-0.101600><5.200000,0.036000,0.101600> rotate<0,0.000000,0> translate<28.388000,-1.536000,43.922000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.388000,-1.536000,43.922000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.388000,-1.536000,54.122000>}
box{<0,0,-0.101600><10.200000,0.036000,0.101600> rotate<0,90.000000,0> translate<28.388000,-1.536000,54.122000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.388000,-1.536000,54.122000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.588000,-1.536000,54.122000>}
box{<0,0,-0.101600><5.200000,0.036000,0.101600> rotate<0,0.000000,0> translate<28.388000,-1.536000,54.122000> }
difference{
cylinder{<32.613000,0,53.222000><32.613000,0.036000,53.222000>0.442200 translate<0,-1.536000,0>}
cylinder{<32.613000,-0.1,53.222000><32.613000,0.135000,53.222000>0.442200 translate<0,-1.536000,0>}}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,53.247000>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,52.597100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,51.947100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,51.297100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,50.647100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,49.997100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,49.347100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,48.696900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,48.046900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,47.396900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,46.746900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,46.096900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,45.446900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<34.277300,-1.536000,44.797000>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,44.797000>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,45.446900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,46.096900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,46.746900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,47.396900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,48.046900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,48.696900>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,49.347100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,49.997100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,50.647100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,51.297100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,51.947100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,52.597100>}
box{<-0.177800,0,-0.647700><0.177800,0.036000,0.647700> rotate<0,-270.000000,0> translate<27.698700,-1.536000,53.247000>}
//L-PWR silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<29.718000,-1.536000,41.632000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<29.718000,-1.536000,38.632000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.968000,-1.536000,41.682000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.968000,-1.536000,38.582000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<28.968000,-1.536000,38.582000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.468000,-1.536000,38.582000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.468000,-1.536000,41.682000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<30.468000,-1.536000,41.682000> }
difference{
cylinder{<29.193000,0,40.857000><29.193000,0.036000,40.857000>0.125000 translate<0,-1.536000,0>}
cylinder{<29.193000,-0.1,40.857000><29.193000,0.135000,40.857000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<29.118000,-1.536000,41.507000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<30.318000,-1.536000,41.507000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<30.155500,-1.536000,41.219500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<30.318000,-1.536000,38.757000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<29.118000,-1.536000,38.757000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<29.280500,-1.536000,39.044500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<29.718000,-1.536000,40.132000>}
//L-RUN silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<32.258000,-1.536000,41.632000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<32.258000,-1.536000,38.632000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.508000,-1.536000,41.682000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.508000,-1.536000,38.582000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<31.508000,-1.536000,38.582000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.008000,-1.536000,38.582000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.008000,-1.536000,41.682000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<33.008000,-1.536000,41.682000> }
difference{
cylinder{<31.733000,0,40.857000><31.733000,0.036000,40.857000>0.125000 translate<0,-1.536000,0>}
cylinder{<31.733000,-0.1,40.857000><31.733000,0.135000,40.857000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<31.658000,-1.536000,41.507000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<32.858000,-1.536000,41.507000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<32.695500,-1.536000,41.219500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<32.858000,-1.536000,38.757000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<31.658000,-1.536000,38.757000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<31.820500,-1.536000,39.044500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<32.258000,-1.536000,40.132000>}
//L-RX silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<38.227000,-1.536000,44.045000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<38.227000,-1.536000,41.045000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.477000,-1.536000,44.095000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.477000,-1.536000,40.995000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<37.477000,-1.536000,40.995000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<38.977000,-1.536000,40.995000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<38.977000,-1.536000,44.095000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<38.977000,-1.536000,44.095000> }
difference{
cylinder{<37.702000,0,43.270000><37.702000,0.036000,43.270000>0.125000 translate<0,-1.536000,0>}
cylinder{<37.702000,-0.1,43.270000><37.702000,0.135000,43.270000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<37.627000,-1.536000,43.920000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<38.827000,-1.536000,43.920000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<38.664500,-1.536000,43.632500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<38.827000,-1.536000,41.170000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<37.627000,-1.536000,41.170000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<37.789500,-1.536000,41.457500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<38.227000,-1.536000,42.545000>}
//L-TX silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<36.322000,-1.536000,43.029000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<36.322000,-1.536000,40.029000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.572000,-1.536000,43.079000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.572000,-1.536000,39.979000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<35.572000,-1.536000,39.979000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.072000,-1.536000,39.979000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.072000,-1.536000,43.079000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<37.072000,-1.536000,43.079000> }
difference{
cylinder{<35.797000,0,42.254000><35.797000,0.036000,42.254000>0.125000 translate<0,-1.536000,0>}
cylinder{<35.797000,-0.1,42.254000><35.797000,0.135000,42.254000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<35.722000,-1.536000,42.904000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<36.922000,-1.536000,42.904000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<36.759500,-1.536000,42.616500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<36.922000,-1.536000,40.154000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<35.722000,-1.536000,40.154000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<35.884500,-1.536000,40.441500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<36.322000,-1.536000,41.529000>}
//LED1 silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<53.340000,-1.536000,28.170000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<53.340000,-1.536000,25.170000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<52.590000,-1.536000,28.220000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<52.590000,-1.536000,25.120000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<52.590000,-1.536000,25.120000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<54.090000,-1.536000,25.120000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<54.090000,-1.536000,28.220000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<54.090000,-1.536000,28.220000> }
difference{
cylinder{<52.815000,0,27.395000><52.815000,0.036000,27.395000>0.125000 translate<0,-1.536000,0>}
cylinder{<52.815000,-0.1,27.395000><52.815000,0.135000,27.395000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<52.740000,-1.536000,28.045000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<53.940000,-1.536000,28.045000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<53.777500,-1.536000,27.757500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<53.940000,-1.536000,25.295000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<52.740000,-1.536000,25.295000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<52.902500,-1.536000,25.582500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<53.340000,-1.536000,26.670000>}
//LED2 silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<50.800000,-1.536000,28.170000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<50.800000,-1.536000,25.170000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.050000,-1.536000,28.220000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<50.050000,-1.536000,25.120000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<50.050000,-1.536000,25.120000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<51.550000,-1.536000,25.120000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<51.550000,-1.536000,28.220000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<51.550000,-1.536000,28.220000> }
difference{
cylinder{<50.275000,0,27.395000><50.275000,0.036000,27.395000>0.125000 translate<0,-1.536000,0>}
cylinder{<50.275000,-0.1,27.395000><50.275000,0.135000,27.395000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<50.200000,-1.536000,28.045000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<51.400000,-1.536000,28.045000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<51.237500,-1.536000,27.757500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<51.400000,-1.536000,25.295000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<50.200000,-1.536000,25.295000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<50.362500,-1.536000,25.582500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<50.800000,-1.536000,26.670000>}
//LED3 silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<48.260000,-1.536000,28.170000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<48.260000,-1.536000,25.170000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<47.510000,-1.536000,28.220000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<47.510000,-1.536000,25.120000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<47.510000,-1.536000,25.120000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.010000,-1.536000,25.120000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<49.010000,-1.536000,28.220000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<49.010000,-1.536000,28.220000> }
difference{
cylinder{<47.735000,0,27.395000><47.735000,0.036000,27.395000>0.125000 translate<0,-1.536000,0>}
cylinder{<47.735000,-0.1,27.395000><47.735000,0.135000,27.395000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<47.660000,-1.536000,28.045000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<48.860000,-1.536000,28.045000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<48.697500,-1.536000,27.757500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<48.860000,-1.536000,25.295000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<47.660000,-1.536000,25.295000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<47.822500,-1.536000,25.582500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<48.260000,-1.536000,26.670000>}
//LED4 silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<45.720000,-1.536000,28.170000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<45.720000,-1.536000,25.170000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<44.970000,-1.536000,28.220000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<44.970000,-1.536000,25.120000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<44.970000,-1.536000,25.120000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<46.470000,-1.536000,25.120000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<46.470000,-1.536000,28.220000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<46.470000,-1.536000,28.220000> }
difference{
cylinder{<45.195000,0,27.395000><45.195000,0.036000,27.395000>0.125000 translate<0,-1.536000,0>}
cylinder{<45.195000,-0.1,27.395000><45.195000,0.135000,27.395000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<45.120000,-1.536000,28.045000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<46.320000,-1.536000,28.045000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<46.157500,-1.536000,27.757500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<46.320000,-1.536000,25.295000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<45.120000,-1.536000,25.295000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<45.282500,-1.536000,25.582500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<45.720000,-1.536000,26.670000>}
//LED5 silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<43.180000,-1.536000,28.170000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<43.180000,-1.536000,25.170000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.430000,-1.536000,28.220000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.430000,-1.536000,25.120000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<42.430000,-1.536000,25.120000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.930000,-1.536000,25.120000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.930000,-1.536000,28.220000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<43.930000,-1.536000,28.220000> }
difference{
cylinder{<42.655000,0,27.395000><42.655000,0.036000,27.395000>0.125000 translate<0,-1.536000,0>}
cylinder{<42.655000,-0.1,27.395000><42.655000,0.135000,27.395000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<42.580000,-1.536000,28.045000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<43.780000,-1.536000,28.045000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<43.617500,-1.536000,27.757500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<43.780000,-1.536000,25.295000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<42.580000,-1.536000,25.295000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<42.742500,-1.536000,25.582500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<43.180000,-1.536000,26.670000>}
//LED6 silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<40.640000,-1.536000,28.170000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<40.640000,-1.536000,25.170000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.890000,-1.536000,28.220000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.890000,-1.536000,25.120000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<39.890000,-1.536000,25.120000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<41.390000,-1.536000,25.120000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<41.390000,-1.536000,28.220000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<41.390000,-1.536000,28.220000> }
difference{
cylinder{<40.115000,0,27.395000><40.115000,0.036000,27.395000>0.125000 translate<0,-1.536000,0>}
cylinder{<40.115000,-0.1,27.395000><40.115000,0.135000,27.395000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<40.040000,-1.536000,28.045000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<41.240000,-1.536000,28.045000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<41.077500,-1.536000,27.757500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<41.240000,-1.536000,25.295000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<40.040000,-1.536000,25.295000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<40.202500,-1.536000,25.582500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<40.640000,-1.536000,26.670000>}
//LED7 silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<38.100000,-1.536000,28.170000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<38.100000,-1.536000,25.170000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.350000,-1.536000,28.220000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.350000,-1.536000,25.120000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<37.350000,-1.536000,25.120000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<38.850000,-1.536000,25.120000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<38.850000,-1.536000,28.220000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<38.850000,-1.536000,28.220000> }
difference{
cylinder{<37.575000,0,27.395000><37.575000,0.036000,27.395000>0.125000 translate<0,-1.536000,0>}
cylinder{<37.575000,-0.1,27.395000><37.575000,0.135000,27.395000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<37.500000,-1.536000,28.045000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<38.700000,-1.536000,28.045000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<38.537500,-1.536000,27.757500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<38.700000,-1.536000,25.295000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<37.500000,-1.536000,25.295000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<37.662500,-1.536000,25.582500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<38.100000,-1.536000,26.670000>}
//LED8 silk screen
object{ARC(0.500000,0.203200,180.000000,360.000000,0.036000) translate<35.560000,-1.536000,28.170000>}
object{ARC(0.500000,0.203200,0.000000,180.000000,0.036000) translate<35.560000,-1.536000,25.170000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.810000,-1.536000,28.220000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.810000,-1.536000,25.120000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,-90.000000,0> translate<34.810000,-1.536000,25.120000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.310000,-1.536000,25.120000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.310000,-1.536000,28.220000>}
box{<0,0,-0.050800><3.100000,0.036000,0.050800> rotate<0,90.000000,0> translate<36.310000,-1.536000,28.220000> }
difference{
cylinder{<35.035000,0,27.395000><35.035000,0.036000,27.395000>0.125000 translate<0,-1.536000,0>}
cylinder{<35.035000,-0.1,27.395000><35.035000,0.135000,27.395000>0.125000 translate<0,-1.536000,0>}}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<34.960000,-1.536000,28.045000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-270.000000,0> translate<36.160000,-1.536000,28.045000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-270.000000,0> translate<35.997500,-1.536000,27.757500>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<36.160000,-1.536000,25.295000>}
box{<-0.225000,0,-0.200000><0.225000,0.036000,0.200000> rotate<0,-90.000000,0> translate<34.960000,-1.536000,25.295000>}
box{<-0.087500,0,-0.162500><0.087500,0.036000,0.162500> rotate<0,-90.000000,0> translate<35.122500,-1.536000,25.582500>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<35.560000,-1.536000,26.670000>}
//OUTPUT silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,12.700000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.465000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<36.830000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.830000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.830000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,12.700000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.275000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,12.700000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.005000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<39.370000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.370000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.370000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.005000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,14.605000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<41.275000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.735000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.370000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<38.735000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.465000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,12.700000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.085000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<44.450000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.450000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<44.450000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,12.700000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.815000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,12.700000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<41.910000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.910000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.910000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,14.605000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.815000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,12.700000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<48.895000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,12.700000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.625000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<46.990000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.990000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<46.990000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.625000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,14.605000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<48.895000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<46.355000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<46.355000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.085000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,12.700000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.705000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<52.070000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.070000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<52.070000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,12.700000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<51.435000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,12.700000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<49.530000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<49.530000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<49.530000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,14.605000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<51.435000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.610000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.975000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.610000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<53.975000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.705000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,12.700000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<34.290000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.290000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<34.290000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.195000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.830000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<36.195000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,15.240000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,15.240000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<38.100000,0.000000,13.970000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<40.640000,0.000000,13.970000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<43.180000,0.000000,13.970000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<45.720000,0.000000,13.970000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<48.260000,0.000000,13.970000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<50.800000,0.000000,13.970000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<53.340000,0.000000,13.970000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<35.560000,0.000000,13.970000>}
//PROG silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,52.070000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.085000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,51.435000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<46.355000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,50.165000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<46.990000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,49.530000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<46.355000,0.000000,49.530000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,52.070000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<46.990000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,52.070000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.625000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,51.435000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<48.895000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,50.165000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.530000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,49.530000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<48.895000,0.000000,49.530000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,49.530000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.625000,0.000000,49.530000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,50.165000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<46.990000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,50.165000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,51.435000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<44.450000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,49.530000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<44.450000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,49.530000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.085000,0.000000,49.530000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,52.070000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<49.530000,0.000000,51.435000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,52.070000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,52.070000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,51.435000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<51.435000,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,50.165000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.070000,0.000000,50.165000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,50.165000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,49.530000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<51.435000,0.000000,49.530000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,49.530000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,49.530000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.530000,0.000000,50.165000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<49.530000,0.000000,50.165000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<48.260000,0.000000,50.800000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<45.720000,0.000000,50.800000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<50.800000,0.000000,50.800000>}
//PWR silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,49.657000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,52.705000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.446200,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,49.657000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.533800,0.000000,49.657000>}
box{<0,0,-0.076200><15.087600,0.036000,0.076200> rotate<0,0.000000,0> translate<39.446200,0.000000,49.657000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,49.657000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.938200,0.000000,49.657000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.938200,0.000000,49.657000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.938200,0.000000,49.657000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.938200,0.000000,54.483000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.938200,0.000000,54.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.938200,0.000000,54.483000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,54.229000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,26.563298,0> translate<38.938200,0.000000,54.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.938200,0.000000,61.341000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,61.087000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,26.563298,0> translate<38.938200,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.938200,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,59.944000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-26.563298,0> translate<38.938200,0.000000,59.690000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,59.944000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,61.087000>}
box{<0,0,-0.076200><1.143000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.446200,0.000000,61.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.938200,0.000000,59.690000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.938200,0.000000,61.341000>}
box{<0,0,-0.076200><1.651000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.938200,0.000000,61.341000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,60.198000>}
box{<0,0,-0.076200><4.572000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.958000,0.000000,60.198000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.025800,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.025800,0.000000,60.198000>}
box{<0,0,-0.076200><4.572000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.025800,0.000000,60.198000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,60.198000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,60.198000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,60.198000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,60.198000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,55.626000>}
box{<0,0,-0.076200><4.572000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.022000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.961800,0.000000,60.198000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.025800,0.000000,60.198000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.961800,0.000000,60.198000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.961800,0.000000,60.198000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.961800,0.000000,55.626000>}
box{<0,0,-0.076200><4.572000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.961800,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,59.563000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,56.388000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.339000,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,59.563000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,59.563000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.339000,0.000000,59.563000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,59.563000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,56.388000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.641000,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.342800,0.000000,59.563000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.342800,0.000000,56.388000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.342800,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.342800,0.000000,59.563000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.644800,0.000000,59.563000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.342800,0.000000,59.563000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.644800,0.000000,59.563000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.644800,0.000000,56.388000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.644800,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.644800,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.263800,0.000000,56.388000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.263800,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.342800,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.723800,0.000000,56.388000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.342800,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,56.388000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.260000,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,56.388000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.339000,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.533800,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.533800,0.000000,52.705000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.533800,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,54.229000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,55.245000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.446200,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,59.944000>}
box{<0,0,-0.076200><4.699000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.446200,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.533800,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,52.705000>}
box{<0,0,-0.076200><15.087600,0.036000,0.076200> rotate<0,0.000000,0> translate<39.446200,0.000000,52.705000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.533800,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.533800,0.000000,49.657000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.533800,0.000000,49.657000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,54.229000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.446200,0.000000,54.229000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,49.911000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.022000,0.000000,49.911000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,49.911000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,49.911000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,49.911000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,49.911000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,52.451000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.958000,0.000000,52.451000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,52.451000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,52.451000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.961800,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.961800,0.000000,49.911000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<49.961800,0.000000,49.911000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.961800,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.025800,0.000000,52.451000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.961800,0.000000,52.451000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.025800,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.025800,0.000000,49.911000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.025800,0.000000,49.911000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.961800,0.000000,49.911000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.025800,0.000000,49.911000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.961800,0.000000,49.911000> }
object{ARC(0.683384,0.152400,131.430111,221.994246,0.036000) translate<45.974000,0.000000,51.282722>}
object{ARC(2.439616,0.152400,51.339448,126.869605,0.036000) translate<46.939159,0.000000,49.809400>}
object{ARC(2.058863,0.152400,220.987649,321.010162,0.036000) translate<47.015334,0.000000,52.171600>}
object{ARC(0.593056,0.152400,316.726894,420.935767,0.036000) translate<48.133000,0.000000,51.231925>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.615600,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.567600,0.000000,50.800000>}
box{<0,0,-0.076200><3.113443,0.036000,0.076200> rotate<0,-11.767512,0> translate<45.567600,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.488600,0.000000,51.562000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.440600,0.000000,50.927000>}
box{<0,0,-0.076200><3.113443,0.036000,0.076200> rotate<0,-11.767512,0> translate<45.440600,0.000000,50.927000> }
object{ARC(0.683384,0.152400,131.430111,221.994246,0.036000) translate<50.952400,0.000000,51.282722>}
object{ARC(2.439656,0.152400,51.338250,126.866969,0.036000) translate<51.917494,0.000000,49.809400>}
object{ARC(2.058863,0.152400,220.987649,321.010162,0.036000) translate<51.993734,0.000000,52.171600>}
object{ARC(0.593056,0.152400,316.726894,420.935767,0.036000) translate<53.111400,0.000000,51.231925>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,50.800000>}
box{<0,0,-0.076200><3.113443,0.036000,0.076200> rotate<0,-11.767512,0> translate<50.546000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,51.562000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.419000,0.000000,50.927000>}
box{<0,0,-0.076200><3.113443,0.036000,0.076200> rotate<0,-11.767512,0> translate<50.419000,0.000000,50.927000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.025800,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.644800,0.000000,55.626000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.644800,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.961800,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.342800,0.000000,55.626000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.961800,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.342800,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.644800,0.000000,55.626000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.342800,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.533800,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.644800,0.000000,55.245000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.644800,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.644800,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.342800,0.000000,55.245000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.342800,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.342800,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,55.245000>}
box{<0,0,-0.076200><1.701800,0.036000,0.076200> rotate<0,0.000000,0> translate<48.641000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.446200,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.335200,0.000000,55.245000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.446200,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,55.245000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.339000,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,55.626000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,55.626000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.641000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.641000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,55.626000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.339000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.335200,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.611800,0.000000,55.245000>}
box{<0,0,-0.076200><3.276600,0.036000,0.076200> rotate<0,0.000000,0> translate<40.335200,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.313600,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.637200,0.000000,55.245000>}
box{<0,0,-0.076200><1.676400,0.036000,0.076200> rotate<0,0.000000,0> translate<43.637200,0.000000,55.245000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.954200,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.954200,0.000000,60.198000>}
box{<0,0,-0.076200><4.572000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.954200,0.000000,60.198000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.954200,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.335200,0.000000,55.626000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.954200,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.611800,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.335200,0.000000,55.626000>}
box{<0,0,-0.076200><3.276600,0.036000,0.076200> rotate<0,0.000000,0> translate<40.335200,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.018200,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.611800,0.000000,55.626000>}
box{<0,0,-0.076200><0.406400,0.036000,0.076200> rotate<0,0.000000,0> translate<43.611800,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.018200,0.000000,60.198000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.954200,0.000000,60.198000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.954200,0.000000,60.198000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.335200,0.000000,59.563000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.637200,0.000000,59.563000>}
box{<0,0,-0.076200><3.302000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.335200,0.000000,59.563000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.335200,0.000000,59.563000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.335200,0.000000,56.388000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.335200,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.335200,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.716200,0.000000,56.388000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.335200,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.637200,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.281600,0.000000,56.388000>}
box{<0,0,-0.076200><0.355600,0.036000,0.076200> rotate<0,0.000000,0> translate<43.281600,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.637200,0.000000,59.563000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.637200,0.000000,56.388000>}
box{<0,0,-0.076200><3.175000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.637200,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.018200,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.018200,0.000000,49.911000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.018200,0.000000,49.911000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.018200,0.000000,49.911000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.954200,0.000000,49.911000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.954200,0.000000,49.911000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.954200,0.000000,49.911000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.954200,0.000000,52.451000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.954200,0.000000,52.451000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.954200,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.018200,0.000000,52.451000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.954200,0.000000,52.451000> }
object{ARC(0.683384,0.152400,131.430111,221.994246,0.036000) translate<40.970200,0.000000,51.282722>}
object{ARC(2.439616,0.152400,51.339448,126.869605,0.036000) translate<41.935359,0.000000,49.809400>}
object{ARC(2.058719,0.152400,220.983737,321.006937,0.036000) translate<42.011719,0.000000,52.171600>}
object{ARC(0.593056,0.152400,316.726894,420.935767,0.036000) translate<43.129200,0.000000,51.231925>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.611800,0.000000,51.435000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.563800,0.000000,50.800000>}
box{<0,0,-0.076200><3.113443,0.036000,0.076200> rotate<0,-11.767512,0> translate<40.563800,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.484800,0.000000,51.562000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.436800,0.000000,50.927000>}
box{<0,0,-0.076200><3.113443,0.036000,0.076200> rotate<0,-11.767512,0> translate<40.436800,0.000000,50.927000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.018200,0.000000,60.198000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.018200,0.000000,55.626000>}
box{<0,0,-0.076200><4.572000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.018200,0.000000,55.626000> }
box{<-1.270000,0,-1.397000><1.270000,0.036000,1.397000> rotate<0,-180.000000,0> translate<51.993800,0.000000,57.023000>}
box{<-1.270000,0,-1.397000><1.270000,0.036000,1.397000> rotate<0,-180.000000,0> translate<46.990000,0.000000,57.023000>}
box{<-1.270000,0,-1.397000><1.270000,0.036000,1.397000> rotate<0,-180.000000,0> translate<41.986200,0.000000,57.023000>}
//RL-PWR silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.971500,-1.536000,35.382200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.889200,-1.536000,35.382200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,0.000000,0> translate<25.971500,-1.536000,35.382200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.971500,-1.536000,37.007800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.889200,-1.536000,37.007800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,0.000000,0> translate<25.971500,-1.536000,37.007800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-180.000000,0> translate<28.244800,-1.536000,36.195000>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-180.000000,0> translate<25.603200,-1.536000,36.195000>}
//RL-RUN silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.971500,-1.536000,32.969200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.889200,-1.536000,32.969200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,0.000000,0> translate<25.971500,-1.536000,32.969200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.971500,-1.536000,34.594800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.889200,-1.536000,34.594800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,0.000000,0> translate<25.971500,-1.536000,34.594800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-180.000000,0> translate<28.244800,-1.536000,33.782000>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-180.000000,0> translate<25.603200,-1.536000,33.782000>}
//RL-RX silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.844500,-1.536000,28.270200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.762200,-1.536000,28.270200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,0.000000,0> translate<25.844500,-1.536000,28.270200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.844500,-1.536000,29.895800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.762200,-1.536000,29.895800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,0.000000,0> translate<25.844500,-1.536000,29.895800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-180.000000,0> translate<28.117800,-1.536000,29.083000>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-180.000000,0> translate<25.476200,-1.536000,29.083000>}
//RL-TX silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.844500,-1.536000,30.683200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.762200,-1.536000,30.683200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,0.000000,0> translate<25.844500,-1.536000,30.683200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.844500,-1.536000,32.308800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.762200,-1.536000,32.308800>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,0.000000,0> translate<25.844500,-1.536000,32.308800> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-180.000000,0> translate<28.117800,-1.536000,31.496000>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-180.000000,0> translate<25.476200,-1.536000,31.496000>}
//RL1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.152800,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.152800,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<54.152800,-1.536000,22.555200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.527200,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.527200,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<52.527200,-1.536000,22.555200> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<53.340000,-1.536000,22.910800>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<53.340000,-1.536000,20.269200>}
//RL2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.612800,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.612800,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<51.612800,-1.536000,22.555200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.987200,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.987200,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<49.987200,-1.536000,22.555200> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<50.800000,-1.536000,22.910800>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<50.800000,-1.536000,20.269200>}
//RL3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.072800,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.072800,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<49.072800,-1.536000,22.555200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.447200,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.447200,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<47.447200,-1.536000,22.555200> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<48.260000,-1.536000,22.910800>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<48.260000,-1.536000,20.269200>}
//RL4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.532800,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.532800,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<46.532800,-1.536000,22.555200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.907200,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.907200,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<44.907200,-1.536000,22.555200> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<45.720000,-1.536000,22.910800>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<45.720000,-1.536000,20.269200>}
//RL5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.992800,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.992800,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<43.992800,-1.536000,22.555200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.367200,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.367200,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<42.367200,-1.536000,22.555200> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<43.180000,-1.536000,22.910800>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<43.180000,-1.536000,20.269200>}
//RL6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.452800,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.452800,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<41.452800,-1.536000,22.555200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.827200,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.827200,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<39.827200,-1.536000,22.555200> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<40.640000,-1.536000,22.910800>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<40.640000,-1.536000,20.269200>}
//RL7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.912800,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.912800,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<38.912800,-1.536000,22.555200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.287200,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.287200,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<37.287200,-1.536000,22.555200> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<38.100000,-1.536000,22.910800>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<38.100000,-1.536000,20.269200>}
//RL8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.372800,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.372800,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<36.372800,-1.536000,22.555200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.747200,-1.536000,20.637500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.747200,-1.536000,22.555200>}
box{<0,0,-0.076200><1.917700,0.036000,0.076200> rotate<0,90.000000,0> translate<34.747200,-1.536000,22.555200> }
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<35.560000,-1.536000,22.910800>}
box{<-0.368300,0,-0.876300><0.368300,0.036000,0.876300> rotate<0,-270.000000,0> translate<35.560000,-1.536000,20.269200>}
//U1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.790000,-1.536000,46.310000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.390000,-1.536000,46.710000>}
box{<0,0,-0.101600><0.565685,0.036000,0.101600> rotate<0,44.997030,0> translate<51.390000,-1.536000,46.710000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.390000,-1.536000,46.710000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.590000,-1.536000,46.710000>}
box{<0,0,-0.101600><8.800000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.590000,-1.536000,46.710000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.590000,-1.536000,46.710000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.190000,-1.536000,46.310000>}
box{<0,0,-0.101600><0.565685,0.036000,0.101600> rotate<0,-44.997030,0> translate<42.190000,-1.536000,46.310000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.190000,-1.536000,46.310000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.190000,-1.536000,37.510000>}
box{<0,0,-0.101600><8.800000,0.036000,0.101600> rotate<0,-90.000000,0> translate<42.190000,-1.536000,37.510000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.190000,-1.536000,37.510000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.590000,-1.536000,37.110000>}
box{<0,0,-0.101600><0.565685,0.036000,0.101600> rotate<0,44.997030,0> translate<42.190000,-1.536000,37.510000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.590000,-1.536000,37.110000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.390000,-1.536000,37.110000>}
box{<0,0,-0.101600><8.800000,0.036000,0.101600> rotate<0,0.000000,0> translate<42.590000,-1.536000,37.110000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.390000,-1.536000,37.110000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.790000,-1.536000,37.510000>}
box{<0,0,-0.101600><0.565685,0.036000,0.101600> rotate<0,-44.997030,0> translate<51.390000,-1.536000,37.110000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.790000,-1.536000,37.510000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.790000,-1.536000,46.310000>}
box{<0,0,-0.101600><8.800000,0.036000,0.101600> rotate<0,90.000000,0> translate<51.790000,-1.536000,46.310000> }
difference{
cylinder{<50.990000,0,45.910000><50.990000,0.036000,45.910000>0.409700 translate<0,-1.536000,0>}
cylinder{<50.990000,-0.1,45.910000><50.990000,0.135000,45.910000>0.155700 translate<0,-1.536000,0>}}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,45.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,45.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,44.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,44.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,43.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,43.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,42.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,42.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,41.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,41.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,40.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,40.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,39.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,39.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,38.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<52.390000,-1.536000,38.160000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<50.740000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<50.240000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<49.740000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<49.240000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<48.740000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<48.240000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<47.740000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<47.240000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<46.740000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<46.240000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<45.740000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<45.240000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<44.740000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<44.240000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<43.740000,-1.536000,36.510000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<43.240000,-1.536000,36.510000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,38.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,38.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,39.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,39.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,40.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,40.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,41.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,41.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,42.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,42.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,43.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,43.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,44.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,44.660000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,45.160000>}
box{<-0.600000,0,-0.100000><0.600000,0.036000,0.100000> rotate<0,-180.000000,0> translate<41.590000,-1.536000,45.660000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<43.240000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<43.740000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<44.240000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<44.740000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<45.240000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<45.740000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<46.240000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<46.740000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<47.240000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<47.740000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<48.240000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<48.740000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<49.240000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<49.740000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<50.240000,-1.536000,47.310000>}
box{<-0.100000,0,-0.600000><0.100000,0.036000,0.600000> rotate<0,-180.000000,0> translate<50.740000,-1.536000,47.310000>}
//USB silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.584100,-1.536000,42.005400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.584100,-1.536000,40.967100>}
box{<0,0,-0.050800><1.038300,0.036000,0.050800> rotate<0,-90.000000,0> translate<13.584100,-1.536000,40.967100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.584100,-1.536000,40.967100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.947500,-1.536000,40.967100>}
box{<0,0,-0.050800><0.363400,0.036000,0.050800> rotate<0,0.000000,0> translate<13.584100,-1.536000,40.967100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.947500,-1.536000,40.967100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.947500,-1.536000,41.382400>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,90.000000,0> translate<13.947500,-1.536000,41.382400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.947500,-1.536000,41.382400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.570500,-1.536000,41.382400>}
box{<0,0,-0.050800><0.623000,0.036000,0.050800> rotate<0,0.000000,0> translate<13.947500,-1.536000,41.382400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.570500,-1.536000,41.382400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.570500,-1.536000,40.967100>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,-90.000000,0> translate<14.570500,-1.536000,40.967100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.570500,-1.536000,40.967100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.962700,-1.536000,40.967100>}
box{<0,0,-0.050800><0.392200,0.036000,0.050800> rotate<0,0.000000,0> translate<14.570500,-1.536000,40.967100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.962700,-1.536000,40.967100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.962700,-1.536000,42.005400>}
box{<0,0,-0.050800><1.038300,0.036000,0.050800> rotate<0,90.000000,0> translate<14.962700,-1.536000,42.005400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.689500,-1.536000,42.005400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.998600,-1.536000,42.005400>}
box{<0,0,-0.050800><2.309100,0.036000,0.050800> rotate<0,0.000000,0> translate<15.689500,-1.536000,42.005400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.075200,-1.536000,42.005400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.998600,-1.536000,42.005400>}
box{<0,0,-0.050800><2.076600,0.036000,0.050800> rotate<0,0.000000,0> translate<17.998600,-1.536000,42.005400> }
object{ARC(0.207600,0.101600,90.000000,180.000000,0.036000) translate<17.998600,-1.536000,41.797800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.791000,-1.536000,41.797800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.791000,-1.536000,41.642000>}
box{<0,0,-0.050800><0.155800,0.036000,0.050800> rotate<0,-90.000000,0> translate<17.791000,-1.536000,41.642000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.791000,-1.536000,41.642000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.179000,-1.536000,41.642000>}
box{<0,0,-0.050800><2.388000,0.036000,0.050800> rotate<0,0.000000,0> translate<17.791000,-1.536000,41.642000> }
object{ARC(0.571100,0.101600,270.000000,360.000000,0.036000) translate<20.179000,-1.536000,42.213100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,42.887900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.703500,-1.536000,43.095600>}
box{<0,0,-0.050800><2.759228,0.036000,0.050800> rotate<0,4.316719,0> translate<12.703500,-1.536000,43.095600> }
object{ARC(0.294747,0.101600,197.025267,265.655116,0.036000) translate<12.725831,-1.536000,43.389500>}
object{ARC(0.973903,0.101600,162.950256,197.049744,0.036000) translate<13.375100,-1.536000,43.588750>}
object{ARC(0.294747,0.101600,94.344884,162.974733,0.036000) translate<12.725831,-1.536000,43.788000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.703500,-1.536000,44.081900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,44.341500>}
box{<0,0,-0.050800><2.763620,0.036000,0.050800> rotate<0,-5.389657,0> translate<12.703500,-1.536000,44.081900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,44.341500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,44.133800>}
box{<0,0,-0.050800><0.207700,0.036000,0.050800> rotate<0,-90.000000,0> translate<15.454900,-1.536000,44.133800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,44.133800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.066900,-1.536000,43.874300>}
box{<0,0,-0.050800><2.402058,0.036000,0.050800> rotate<0,-6.201492,0> translate<13.066900,-1.536000,43.874300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.066900,-1.536000,43.874300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.066900,-1.536000,43.355100>}
box{<0,0,-0.050800><0.519200,0.036000,0.050800> rotate<0,-90.000000,0> translate<13.066900,-1.536000,43.355100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.066900,-1.536000,43.355100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,43.095600>}
box{<0,0,-0.050800><2.402058,0.036000,0.050800> rotate<0,6.201492,0> translate<13.066900,-1.536000,43.355100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,43.095600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,42.887900>}
box{<0,0,-0.050800><0.207700,0.036000,0.050800> rotate<0,-90.000000,0> translate<15.454900,-1.536000,42.887900> }
object{ARC(0.259500,0.101600,270.000000,360.000000,0.036000) translate<20.075200,-1.536000,42.264900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,42.264900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,42.836000>}
box{<0,0,-0.050800><0.571100,0.036000,0.050800> rotate<0,90.000000,0> translate<20.334700,-1.536000,42.836000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,42.836000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.698100,-1.536000,42.836000>}
box{<0,0,-0.050800><0.363400,0.036000,0.050800> rotate<0,0.000000,0> translate<20.334700,-1.536000,42.836000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.985000,-1.536000,41.590100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.985000,-1.536000,40.967100>}
box{<0,0,-0.050800><0.623000,0.036000,0.050800> rotate<0,-90.000000,0> translate<18.985000,-1.536000,40.967100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.985000,-1.536000,40.967100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.400300,-1.536000,40.967100>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,0.000000,0> translate<18.985000,-1.536000,40.967100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.400300,-1.536000,40.967100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.400300,-1.536000,41.382400>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,90.000000,0> translate<19.400300,-1.536000,41.382400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.400300,-1.536000,41.382400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.919400,-1.536000,41.382400>}
box{<0,0,-0.050800><0.519100,0.036000,0.050800> rotate<0,0.000000,0> translate<19.400300,-1.536000,41.382400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.919400,-1.536000,41.382400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.919400,-1.536000,40.967100>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,-90.000000,0> translate<19.919400,-1.536000,40.967100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.919400,-1.536000,40.967100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,40.967100>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,0.000000,0> translate<19.919400,-1.536000,40.967100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,40.967100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,41.590100>}
box{<0,0,-0.050800><0.623000,0.036000,0.050800> rotate<0,90.000000,0> translate<20.334700,-1.536000,41.590100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.842900,-1.536000,44.081900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.842900,-1.536000,47.612000>}
box{<0,0,-0.050800><3.530100,0.036000,0.050800> rotate<0,90.000000,0> translate<17.842900,-1.536000,47.612000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.310100,-1.536000,47.663900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.310100,-1.536000,44.030000>}
box{<0,0,-0.050800><3.633900,0.036000,0.050800> rotate<0,-90.000000,0> translate<18.310100,-1.536000,44.030000> }
object{ARC(0.207500,0.101600,269.972388,360.027612,0.036000) translate<18.102600,-1.536000,44.029900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.102500,-1.536000,43.822400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.102400,-1.536000,43.822400>}
box{<0,0,-0.050800><0.000100,0.036000,0.050800> rotate<0,0.000000,0> translate<18.102400,-1.536000,43.822400> }
object{ARC(0.259600,0.101600,180.022071,269.977929,0.036000) translate<18.102500,-1.536000,44.082000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.829300,-1.536000,47.871600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.698100,-1.536000,47.871600>}
box{<0,0,-0.050800><1.868800,0.036000,0.050800> rotate<0,0.000000,0> translate<18.829300,-1.536000,47.871600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,47.819600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,43.874300>}
box{<0,0,-0.050800><3.945300,0.036000,0.050800> rotate<0,-90.000000,0> translate<20.334700,-1.536000,43.874300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.703600,-1.536000,44.601100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.752800,-1.536000,44.808700>}
box{<0,0,-0.050800><4.054518,0.036000,0.050800> rotate<0,-2.934756,0> translate<12.703600,-1.536000,44.601100> }
object{ARC(0.219922,0.101600,273.127888,356.899705,0.036000) translate<16.740800,-1.536000,45.028294>}
object{ARC(0.207600,0.101600,180.000000,270.000000,0.036000) translate<12.703500,-1.536000,44.808700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.495900,-1.536000,44.808700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.495900,-1.536000,44.808800>}
box{<0,0,-0.050800><0.000100,0.036000,0.050800> rotate<0,90.000000,0> translate<12.495900,-1.536000,44.808800> }
object{ARC(0.207600,0.101600,90.000000,180.000000,0.036000) translate<12.703500,-1.536000,44.808800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.703500,-1.536000,45.016400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.129800,-1.536000,45.224000>}
box{<0,0,-0.050800><3.432583,0.036000,0.050800> rotate<0,-3.467092,0> translate<12.703500,-1.536000,45.016400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.584100,-1.536000,49.688400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.584100,-1.536000,50.726700>}
box{<0,0,-0.050800><1.038300,0.036000,0.050800> rotate<0,90.000000,0> translate<13.584100,-1.536000,50.726700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.584100,-1.536000,50.726700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.947500,-1.536000,50.726700>}
box{<0,0,-0.050800><0.363400,0.036000,0.050800> rotate<0,0.000000,0> translate<13.584100,-1.536000,50.726700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.947500,-1.536000,50.726700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.947500,-1.536000,50.311400>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,-90.000000,0> translate<13.947500,-1.536000,50.311400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.947500,-1.536000,50.311400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.570500,-1.536000,50.311400>}
box{<0,0,-0.050800><0.623000,0.036000,0.050800> rotate<0,0.000000,0> translate<13.947500,-1.536000,50.311400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.570500,-1.536000,50.311400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.570500,-1.536000,50.726700>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,90.000000,0> translate<14.570500,-1.536000,50.726700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.570500,-1.536000,50.726700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.962700,-1.536000,50.726700>}
box{<0,0,-0.050800><0.392200,0.036000,0.050800> rotate<0,0.000000,0> translate<14.570500,-1.536000,50.726700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.962700,-1.536000,50.726700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.962700,-1.536000,49.688400>}
box{<0,0,-0.050800><1.038300,0.036000,0.050800> rotate<0,-90.000000,0> translate<14.962700,-1.536000,49.688400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.962700,-1.536000,49.688400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.075200,-1.536000,49.688400>}
box{<0,0,-0.050800><5.112500,0.036000,0.050800> rotate<0,0.000000,0> translate<14.962700,-1.536000,49.688400> }
object{ARC(0.207600,0.101600,180.000000,270.000000,0.036000) translate<17.998600,-1.536000,49.896000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.791000,-1.536000,49.896000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.791000,-1.536000,50.051800>}
box{<0,0,-0.050800><0.155800,0.036000,0.050800> rotate<0,90.000000,0> translate<17.791000,-1.536000,50.051800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.791000,-1.536000,50.051800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.179000,-1.536000,50.051800>}
box{<0,0,-0.050800><2.388000,0.036000,0.050800> rotate<0,0.000000,0> translate<17.791000,-1.536000,50.051800> }
object{ARC(0.571000,0.101600,359.989965,450.010035,0.036000) translate<20.179100,-1.536000,49.480800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,48.805900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.703500,-1.536000,48.598200>}
box{<0,0,-0.050800><2.759228,0.036000,0.050800> rotate<0,-4.316719,0> translate<12.703500,-1.536000,48.598200> }
object{ARC(0.294747,0.101600,94.344884,162.974733,0.036000) translate<12.725831,-1.536000,48.304300>}
object{ARC(0.973903,0.101600,162.950256,197.049744,0.036000) translate<13.375100,-1.536000,48.105050>}
object{ARC(0.294747,0.101600,197.025267,265.655116,0.036000) translate<12.725831,-1.536000,47.905800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.703500,-1.536000,47.611900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,47.352300>}
box{<0,0,-0.050800><2.763620,0.036000,0.050800> rotate<0,5.389657,0> translate<12.703500,-1.536000,47.611900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,47.352300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,47.560000>}
box{<0,0,-0.050800><0.207700,0.036000,0.050800> rotate<0,90.000000,0> translate<15.454900,-1.536000,47.560000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,47.560000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.066900,-1.536000,47.819500>}
box{<0,0,-0.050800><2.402058,0.036000,0.050800> rotate<0,6.201492,0> translate<13.066900,-1.536000,47.819500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.066900,-1.536000,47.819500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.066900,-1.536000,48.338700>}
box{<0,0,-0.050800><0.519200,0.036000,0.050800> rotate<0,90.000000,0> translate<13.066900,-1.536000,48.338700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.066900,-1.536000,48.338700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,48.598200>}
box{<0,0,-0.050800><2.402058,0.036000,0.050800> rotate<0,-6.201492,0> translate<13.066900,-1.536000,48.338700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,48.598200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.454900,-1.536000,48.805900>}
box{<0,0,-0.050800><0.207700,0.036000,0.050800> rotate<0,90.000000,0> translate<15.454900,-1.536000,48.805900> }
object{ARC(0.259400,0.101600,359.977912,450.022088,0.036000) translate<20.075300,-1.536000,49.429000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,49.428900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,48.857800>}
box{<0,0,-0.050800><0.571100,0.036000,0.050800> rotate<0,-90.000000,0> translate<20.334700,-1.536000,48.857800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,48.857800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.698100,-1.536000,48.857800>}
box{<0,0,-0.050800><0.363400,0.036000,0.050800> rotate<0,0.000000,0> translate<20.334700,-1.536000,48.857800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.985000,-1.536000,50.103700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.985000,-1.536000,50.726700>}
box{<0,0,-0.050800><0.623000,0.036000,0.050800> rotate<0,90.000000,0> translate<18.985000,-1.536000,50.726700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.985000,-1.536000,50.726700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.400300,-1.536000,50.726700>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,0.000000,0> translate<18.985000,-1.536000,50.726700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.400300,-1.536000,50.726700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.400300,-1.536000,50.311400>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,-90.000000,0> translate<19.400300,-1.536000,50.311400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.400300,-1.536000,50.311400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.919400,-1.536000,50.311400>}
box{<0,0,-0.050800><0.519100,0.036000,0.050800> rotate<0,0.000000,0> translate<19.400300,-1.536000,50.311400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.919400,-1.536000,50.311400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.919400,-1.536000,50.726700>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,90.000000,0> translate<19.919400,-1.536000,50.726700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.919400,-1.536000,50.726700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,50.726700>}
box{<0,0,-0.050800><0.415300,0.036000,0.050800> rotate<0,0.000000,0> translate<19.919400,-1.536000,50.726700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,50.726700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.334700,-1.536000,50.103700>}
box{<0,0,-0.050800><0.623000,0.036000,0.050800> rotate<0,-90.000000,0> translate<20.334700,-1.536000,50.103700> }
object{ARC(0.207500,0.101600,359.972388,450.027612,0.036000) translate<18.102600,-1.536000,47.663900>}
object{ARC(0.259800,0.101600,90.066162,179.933839,0.036000) translate<18.102700,-1.536000,47.611600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.829300,-1.536000,47.819500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.829300,-1.536000,43.822200>}
box{<0,0,-0.050800><3.997300,0.036000,0.050800> rotate<0,-90.000000,0> translate<18.829300,-1.536000,43.822200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.829300,-1.536000,43.822200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.698100,-1.536000,43.822200>}
box{<0,0,-0.050800><1.868800,0.036000,0.050800> rotate<0,0.000000,0> translate<18.829300,-1.536000,43.822200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.703600,-1.536000,47.092700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.752800,-1.536000,46.885100>}
box{<0,0,-0.050800><4.054518,0.036000,0.050800> rotate<0,2.934756,0> translate<12.703600,-1.536000,47.092700> }
object{ARC(0.220028,0.101600,3.124877,86.847531,0.036000) translate<16.740700,-1.536000,46.665406>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.960400,-1.536000,46.677400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.960400,-1.536000,45.016300>}
box{<0,0,-0.050800><1.661100,0.036000,0.050800> rotate<0,-90.000000,0> translate<16.960400,-1.536000,45.016300> }
object{ARC(0.207600,0.101600,90.000000,180.000000,0.036000) translate<12.703500,-1.536000,46.885100>}
object{ARC(0.207600,0.101600,180.000000,270.000000,0.036000) translate<12.703500,-1.536000,46.885000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.703500,-1.536000,46.677400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.129800,-1.536000,46.469800>}
box{<0,0,-0.050800><3.432583,0.036000,0.050800> rotate<0,3.467092,0> translate<12.703500,-1.536000,46.677400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.129800,-1.536000,46.469800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.129800,-1.536000,45.223800>}
box{<0,0,-0.050800><1.246000,0.036000,0.050800> rotate<0,-90.000000,0> translate<16.129800,-1.536000,45.223800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<15.689400,-1.536000,49.688400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.998700,-1.536000,49.688500>}
box{<0,0,-0.050800><2.309300,0.036000,0.050800> rotate<0,-0.002481,0> translate<15.689400,-1.536000,49.688400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<14.962700,-1.536000,42.005400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<17.998500,-1.536000,42.005500>}
box{<0,0,-0.050800><3.035800,0.036000,0.050800> rotate<0,-0.001887,0> translate<14.962700,-1.536000,42.005400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.750100,-1.536000,47.871500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.750100,-1.536000,48.857900>}
box{<0,0,-0.050800><0.986400,0.036000,0.050800> rotate<0,90.000000,0> translate<20.750100,-1.536000,48.857900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.750100,-1.536000,42.213000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.750000,-1.536000,48.857900>}
box{<0,0,-0.050800><6.644900,0.036000,0.050800> rotate<0,89.993198,0> translate<20.750000,-1.536000,48.857900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.750200,-1.536000,42.836000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.750200,-1.536000,43.822400>}
box{<0,0,-0.050800><0.986400,0.036000,0.050800> rotate<0,90.000000,0> translate<20.750200,-1.536000,43.822400> }
//X-B silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.198000,0.000000,53.213000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.198000,0.000000,53.467000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<60.198000,0.000000,53.467000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.182000,0.000000,53.467000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.198000,0.000000,53.467000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.182000,0.000000,53.467000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.182000,0.000000,53.467000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.182000,0.000000,53.213000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.182000,0.000000,53.213000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.198000,0.000000,53.213000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.182000,0.000000,53.213000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.182000,0.000000,53.213000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.198000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,52.959000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.690000,0.000000,52.959000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.198000,0.000000,53.721000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,53.721000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.690000,0.000000,53.721000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,53.721000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,54.102000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.690000,0.000000,54.102000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,53.721000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.182000,0.000000,53.721000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.182000,0.000000,53.721000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,52.578000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.690000,0.000000,52.578000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.182000,0.000000,52.959000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.182000,0.000000,52.959000> }
object{ARC(1.016000,0.152400,134.998366,179.997689,0.036000) translate<59.690000,0.000000,53.339959>}
object{ARC(1.016000,0.152400,180.002311,225.001634,0.036000) translate<59.690000,0.000000,53.340041>}
object{ARC(1.016000,0.152400,314.998366,359.997689,0.036000) translate<59.690000,0.000000,53.340041>}
object{ARC(1.016000,0.152400,0.002311,45.001634,0.036000) translate<59.690000,0.000000,53.339959>}
difference{
cylinder{<59.690000,0,53.340000><59.690000,0.036000,53.340000>1.092200 translate<0,0.000000,0>}
cylinder{<59.690000,-0.1,53.340000><59.690000,0.135000,53.340000>0.939800 translate<0,0.000000,0>}}
//XA silk screen
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<61.849000,0.000000,42.672000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<61.849000,0.000000,48.768000>}
box{<0,0,-0.203200><6.096000,0.036000,0.203200> rotate<0,90.000000,0> translate<61.849000,0.000000,48.768000> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<57.531000,0.000000,42.672000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<57.531000,0.000000,48.768000>}
box{<0,0,-0.203200><6.096000,0.036000,0.203200> rotate<0,90.000000,0> translate<57.531000,0.000000,48.768000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.341000,0.000000,42.672000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.341000,0.000000,48.768000>}
box{<0,0,-0.076200><6.096000,0.036000,0.076200> rotate<0,90.000000,0> translate<61.341000,0.000000,48.768000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.039000,0.000000,48.768000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.039000,0.000000,42.672000>}
box{<0,0,-0.076200><6.096000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.039000,0.000000,42.672000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,45.974000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<58.928000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,45.974000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,45.466000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.452000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,45.466000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,45.466000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,45.466000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,46.355000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,46.355000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.690000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,45.085000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.452000,0.000000,45.085000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.690000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,46.990000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.690000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.690000,0.000000,44.450000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.690000,0.000000,44.450000> }
object{ARC(2.159000,0.406400,180.000000,360.000000,0.036000) translate<59.690000,0.000000,42.672000>}
object{ARC(2.159000,0.406400,0.000000,180.000000,0.036000) translate<59.690000,0.000000,48.768000>}
object{ARC(1.651000,0.152400,180.000000,360.000000,0.036000) translate<59.690000,0.000000,42.672000>}
object{ARC(1.651000,0.152400,0.000000,180.000000,0.036000) translate<59.690000,0.000000,48.768000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  DRIVER_CONTROLLER(-40.665500,0,-35.745500,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//L-PWR		SML1206
//L-RUN		SML1206
//L-RX		SML1206
//L-TX		SML1206
//LED1		SML1206
//LED2		SML1206
//LED3		SML1206
//LED4		SML1206
//LED5		SML1206
//LED6		SML1206
//LED7		SML1206
//LED8		SML1206
//PWR		AK300/3
//USB	MINI-USB-32005-201	32005-201
