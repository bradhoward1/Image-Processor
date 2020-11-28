ls *?.v > Wrapper.txt
iverilog -o Processor -c Wrapper.txt -s VGAController_tb
vvp Processor
