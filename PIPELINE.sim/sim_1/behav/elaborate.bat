@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto c1c93375afed4e18a1b126f1fbeb919e -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot PIPELINE_behav xil_defaultlib.PIPELINE -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
