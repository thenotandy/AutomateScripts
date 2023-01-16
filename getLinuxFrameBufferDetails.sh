#!/bin/sh

# Transfer this script to the desired headless linux machine and give it executable permissions.
# Run this script as root to get that headless linux machine's frame buffer's details.

if [ "$(whoami)" = "root" ]; then
	AVAILABLE_FRAME_BUFFER_NAME=$(ls /dev/ 2>/dev/null | grep -Eo 'fb[0-9]+' | head -n1 | awk '{ print "/dev/" $1 }' || ls /dev/fb/ 2>/dev/null | grep -Eo '[0-9]+' | head -n1 | awk '{ print "/dev/fb/" $1 }')
	
	if [ ! -z "${AVAILABLE_FRAME_BUFFER_NAME}" ]; then
		if (! $(which gcc > /dev/null 2>&1)); then
			echo "gcc not found. Installing gcc."
		
			apt-get --assume-yes install gcc > /dev/null 2>&1 || yum --assumeyes install gcc > /dev/null 2>&1
		
			case $? in
				0) DID_SCRIPT_INSTALL_GCC=true ;;
				*) DID_SCRIPT_INSTALL_GCC=false ;;
			esac
		
			if [ "${DID_SCRIPT_INSTALL_GCC}" = "true" ]; then
				echo "Installed gcc successfully."
			else
				echo "Could not install gcc. Aborting shell script."
				exit 1
			fi
		fi
	
		printf "%s" "
					#include <sys/stat.h>
					#include <fcntl.h>
					#include <sys/ioctl.h>
					#include <unistd.h>
					#include <linux/fb.h>
					#include <stdio.h>
				
					int main(int argc, char *argv[])
					{
						struct fb_fix_screeninfo finfo;
						struct fb_var_screeninfo vinfo;
					
						int frameBufferFD = open(argv[1], O_RDONLY | O_NONBLOCK);
						ioctl(frameBufferFD, FBIOGET_FSCREENINFO, &finfo);
						ioctl(frameBufferFD, FBIOGET_VSCREENINFO, &vinfo);
						
						printf(\"Details for Frame Buffer %s: \n\", argv[1]);
						printf(\"Width : %d\n\", vinfo.xres);
						printf(\"Height : %d\n\", vinfo.yres);
						printf(\"Stride : %d\n\", finfo.line_length);
						printf(\"Bits Per Pixel : %d\n\", vinfo.bits_per_pixel);
						printf(\"Red Offset : %d\n\", vinfo.red.offset);
						printf(\"Green Offset : %d\n\", vinfo.green.offset);
						printf(\"Blue Offset : %d\n\", vinfo.blue.offset);
						printf(\"Red Length : %d\n\", vinfo.red.length);
						printf(\"Green Length : %d\n\", vinfo.green.length);
						printf(\"Blue Length : %d\n\", vinfo.blue.length);
					
						return 0;
					}" > print_frame_buffer_details.c
				
		gcc -o print_frame_buffer_details print_frame_buffer_details.c && chmod +x print_frame_buffer_details
			
		echo "------------------------------------------------------"
		./print_frame_buffer_details "${AVAILABLE_FRAME_BUFFER_NAME}"
		echo "------------------------------------------------------"
			
		rm -f print_frame_buffer_details print_frame_buffer_details.c 
	
		if [ "${DID_SCRIPT_INSTALL_GCC}" = "true" ]; then
			echo "Uninstalling gcc."
			apt-get --assume-yes remove gcc > /dev/null 2>&1 || yum --assumeyes remove gcc > /dev/null 2>&1
		fi
	else
		echo "No Frame Buffers Found. Aborting shell script."
		exit 1
	fi
else
	echo "You need to be root to run this script. Aborting shell script."
	exit 1
fi
