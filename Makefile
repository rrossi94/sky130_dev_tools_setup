PDK_ROOT = /usr/local/share/pdk
XSCHEM_SHAREDIR = /usr/local/share/xschem
XSCHEM_130_SHAREDIR = /usr/local/share/pdk/sky130A/libs.tech/xschem

hello:
	echo "hello world"	
.PHONY: install		
install: 
	cd sky130_dev_tools_setup
	cd scripts
	chmod +x install_sky130_dev_tools.sh
	$(shell ./install_sky130_dev_tools.sh)
.PHONY: new-analog-project	
new-analog-project: 
	ifeq ($(strip $((call args,defaultstring))),)
		echo "Forget to pass the name of the project. Try again"	
		exit 0
	endif
	@echo $(call args,defaultstring)
	cd
	mkdir -p Projects
	mkdir -p $(call args,defaultstring)
	cd $(call args,defaultstring)
	$(shell git clone https://github.com/efabless/caravel.git)
	mkdir -p design
	mkdir -p layout
	mkdir -p testbench
	mkdir -p examples
	cd examples
	$(shell git clone https://github.com/efabless/caravel_user_project_analog.git)
	cd ..
	cd design
	touch xschemrc
	printf "%s\n" "set XSCHEM_LIBRARY_PATH {}" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :$(XSCHEM_SHAREDIR)/xschem_library" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :/usr/local/share/doc/xschem/examples" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :/usr/local/share/doc/xschem/ngspice" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :/usr/local/share/doc/xschem/logic" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :/usr/local/share/doc/xschem/xschem_simulator" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :/usr/local/share/doc/xschem/binto7seg" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :/usr/local/share/doc/xschem/pcb" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :/usr/local/share/doc/xschem/rom8k" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :$(PDK_ROOT)/sky130A/libs.tech/xschem" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :$(PDK_ROOT)/sky130B/libs.tech/xschem" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :$(HOME)/tools/xschem_sky130" >> xschemrc
	printf "%s\n" "append XSCHEM_LIBRARY_PATH :$(PWD)/design" >> xschemrc
	printf "%s\n" "set SKYWATER_MODELS $(PDK_ROOT)/skywater-pdk/libraries/sky130_fd_pr_ngspice/latest" >> xschemrc
	printf "%s\n" "set SKYWATER_STDCELLS $(PDK_ROOT)/skywater-pdk/libraries/sky130_fd_sc_hd/latest" >> xschemrc
	printf "%s\n" "lappend tcl_files $(XSCHEM_SHAREDIR)/ngspice_backannotate.tcl" >> xschemrc
	printf "%s\n" "lappend tcl_files $(XSCHEM_130_SHAREDIR)/scripts/sky130_models.tcl" >> xschemrc
	touch magicrc
	printf "%s\n" "puts stdout \"Sourcing design .magicrc for technology sky130A ...\"" >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "# Put grid on 0.005 pitch.  This is important, as some commands don't" >> magicrc
	printf "%s\n" "# rescale the grid automatically (such as lef read?)." >> magicrc
	printf "%s\n" ""
	printf "%s\n" "set scalefac [tech lambda]" >> magicrc
	printf "%s\n" "if {[lindex \$$scalefac 1] < 2} {" >> magicrc
	printf "%s\n" "    scalegrid 1 2" >> magicrc
	printf "%s\n" "}" >> magicrc
	printf "%s\n" "" >> magicrc
	printf "%s\n" "# drc off" >> magicrc
	printf "%s\n" "drc euclidean on" >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "# Allow override of PDK path from environment variable PDKPATH" >> magicrc
	printf "%s\n" "if {[catch {set PDKPATH \$$env(PDKPATH)}]} {" >> magicrc
	printf "%s\n" "    set PDKPATH "\$(PDK_ROOT)/sky130A"" >> magicrc
	printf "%s\n" "}" >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "# loading technology"  >> magicrc
	printf "%s\n" "tech load \$$PDKPATH/libs.tech/magic/current/sky130A.tech" >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "# load device generator" >> magicrc
	printf "%s\n" "source \$$PDKPATH/libs.tech/magic/current/sky130A.tcl" >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "# load bind keys (optional)" >> magicrc
	printf "%s\n" "# source \$$PDKPATH/libs.tech/magic/current/sky130A-BindKeys" >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "# set units to lambda grid " >> magicrc
	printf "%s\n" "snap lambda" >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "# set sky130 standard power, ground, and substrate names" >> magicrc
	printf "%s\n" "set VDD VPWR" >> magicrc
	printf "%s\n" "set GND VGND" >> magicrc
	printf "%s\n" "set SUB VSUBS" >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "# Allow override of type of magic library views used, "mag" or "maglef"," >> magicrc
	printf "%s\n" "# from environment variable MAGTYPE" >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "if {[catch {set MAGTYPE \$$env(MAGTYPE)}]} {" >> magicrc
	printf "%s\n" "   set MAGTYPE maglef" >> magicrc
	printf "%s\n" "}"  >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "# add path to reference cells" >> magicrc
	printf "%s\n" "if {[file isdir \$${PDKPATH}/libs.ref/\$${MAGTYPE}]} {" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/\$${MAGTYPE}/sky130_fd_pr" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/\$${MAGTYPE}/sky130_fd_io" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/\$${MAGTYPE}/sky130_fd_sc_hd" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/\$${MAGTYPE}/sky130_fd_sc_hdll" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/\$${MAGTYPE}/sky130_fd_sc_hs" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/\$${MAGTYPE}/sky130_fd_sc_hvl" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/\$${MAGTYPE}/sky130_fd_sc_lp" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/\$${MAGTYPE}/sky130_fd_sc_ls" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/\$${MAGTYPE}/sky130_fd_sc_ms" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/\$${MAGTYPE}/sky130_osu_sc" >> magicrc
	printf "%s\n" "} else {"  >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/sky130_fd_pr/\$${MAGTYPE}" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/sky130_fd_io/\$${MAGTYPE}" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/sky130_fd_sc_hd/\$${MAGTYPE}" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/sky130_fd_sc_hdll/\$${MAGTYPE}" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/sky130_fd_sc_hs/\$${MAGTYPE}" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/sky130_fd_sc_hvl/\$${MAGTYPE}" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/sky130_fd_sc_lp/\$${MAGTYPE}" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/sky130_fd_sc_ls/\$${MAGTYPE}" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/sky130_fd_sc_ms/\$${MAGTYPE}" >> magicrc
	printf "%s\n" "    addpath \$${PDKPATH}/libs.ref/sky130_osu_sc/\$${MAGTYPE}" >> magicrc
	printf "%s\n" "}"  >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "# add path to GDS cells" >> magicrc
	printf "%s\n" "#ifdef FULLTECH"  >> magicrc
	printf "%s\n" "    if {[file isdir ${}/TECHNAME/libs.ref/gds]} {" >> magicrc
	printf "%s\n" "        	path cell \$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_fd_pr" >> magicrc
	printf "%s\n" "        	path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_fd_io" >> magicrc
	printf "%s\n" "        	path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_fd_sc_hd" >> magicrc
	printf "%s\n" "        	path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_fd_sc_hdll" >> magicrc
	printf "%s\n" "    	   	path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_fd_sc_hs" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_fd_sc_hvl" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_fd_sc_lp" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_fd_sc_ls" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_fd_sc_ms" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_osu130" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_osu130_t18" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_ml_xx_hd" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/gds/sky130_sram_macros" >> magicrc
	printf "%s\n" "    } else {" >> magicrc
	printf "%s\n" "    		path cell ${PDKPATH}/TECHNAME/libs.ref/sky130_fd_pr/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_fd_io/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_fd_sc_hd/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_fd_sc_hdll/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_fd_sc_hs/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_fd_sc_hvl/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_fd_sc_lp/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_fd_sc_ls/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_fd_sc_ms/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_osu130/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_osu130_t18/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_ml_xx_hd/gds" >> magicrc
	printf "%s\n" "    		path cell +\$${PDKPATH}/TECHNAME/libs.ref/sky130_sram_macros/gds" >> magicrc
	printf "%s\n" "    }" >> magicrc
	printf "%s\n" "#endif (FULLTECH)" >> magicrc
	printf "%s\n" ""  >> magicrc
	printf "%s\n" "# add path to IP from catalog.  This procedure defined in the PDK script." >> magicrc
	printf "%s\n" "catch {magic::query_mylib_ip}" >> magicrc
	printf "%s\n" "# add path to local IP from user design space.  Defined in the PDK script." >> magicrc
	printf "%s\n" "catch {magic::query_my_projects}" >> magicrc
	

		
