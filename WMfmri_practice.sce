scenario = "WM fMRI expt";
scenario_type = trials;

#scenario_type = fMRI;
#scenario_type = fMRI_emulation;
scan_period = 2000;
pulses_per_scan = 1;
pulse_code = 1; 

pcl_file="WMfmri_practice.pcl";

pulse_width=indefinite_port_code;

active_buttons = 3; 
button_codes= 3, 1, 9;
#left mouse button, right mouse button

#write_codes=true; # use if sending codes out through a port

default_background_color=0,0,0; 
default_font="arial";
default_font_size = 40;
#default_text_color = 255,255,255;            
default_text_color=255,255,255;

begin;

picture { }default;

bitmap {filename="WMscreenshot.bmp";} screenshot;

picture{text {caption="debug"; }debug_txt; x=0; y=0;}debug_pic;

picture{
	bitmap screenshot; x=0; y=0;
	text {caption="Index finger
			for yes"; 
		font_size=14;
		font="arial";
	}instructions_txtL; x=-150; y=-150;
	text {caption="Middle finger
			for no"; 
		font_size=14;
		font="arial";
	}instructions_txtR; x=150; y=-150;
	text {caption="INSTRUCTIONS";
		font_size=14;
		font="arial";
	}instrct; x = 0; y = 150;
}instructions_pic1;

picture{
	bitmap screenshot; x=0; y=0;
	text instructions_txtL; x=-150; y=0;
	text instructions_txtR; x=150; y=0;
	text {caption="STARTING...";
			font_size=14;
			font="arial";
			}starting; x = 0; y = 150;
}instructions_pic2;

########################################################

trial{
	trial_type = specific_response;
	trial_duration = forever;
	terminator_button = 3;

	stimulus_event{
		picture instructions_pic1;
		duration=response; #for practice
	}instructions_event;
}instructions_trial;

trial{
#	trial_type = first_response; #for screenshot taking
#	trial_duration = forever; #for screenshot taking
	
#	stimulus_event{
#		picture {text{caption="+";}iti_txt; x=0; y=0; }fixn_pic;
#		duration=500;
#		code="fixn";
#	}fixn_event;
	stimulus_event{
		picture {text{caption="DEBUG";}encode_txt; x=0; y=0; }encode_pic;
		#deltat=500;
		duration=4000;
		code="encode";
	}encode_event;
	stimulus_event{
		picture {text{caption=" ";}delay_txt; x=0; y=0; }delay_pic;
		deltat=4000;
		duration=4000; # will be set in pcl to be 0 or 4 sec
		code="delay";
	}delay_event;
	stimulus_event{
		picture {text{caption="A";}probe_txt; x=0; y=0; }probe_pic;
		deltat=4000;
		duration=2000;
		code="probe";
	}probe_event;
	stimulus_event{
		picture {text{caption="*";}iti_txt; x=0; y=0; }iti_pic;
		deltat=2000;
		duration=2000; # will be set in pcl to be 2, 4, 6, or 12 sec
		code="iti";
	}iti_event;
}wm_trial;

trial{
	stimulus_event{
		picture default;
		duration=27000;
		code="rest_break_blankscreen";
	}rest_blank_event;
}rest_break_blank; 

trial {
	picture instructions_pic2;
	code = "start_trial";
	duration = 100;
	mri_pulse = 1;
}start_trial;

trial {
	all_responses = false; # responses made in this trial will be ignored
	picture {text{caption = "Thank you!";}; x = 0; y = 0;}finished;
	code = "Complete";
	duration = 2000;
}end_trial;