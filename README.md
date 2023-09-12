Creation of a user interface using a Basys3 card to control the speed and activation/deactivation of headlight calls or sound
announcements of one or more trains. 

# Project architecture :

``Central_DCC_on_FPGA ``\
├── ``sim/`` : all the testbench's of the DCC Central modules\
├── ``src/``\
│   ├── ``c code/`` : c code file for the software part in vitis\
│   ├── ``vhd code/`` : vhd source codes of the DCC Central modules\
├── ``Basys_3_Master.xdc`` : constraint file for the Basys3\
├── ``Rapport_projet_FPGA_BISLIEV_YANG.pdf`` : project report\
└── ``wrapper.xsa`` : FPGA wrapper file\
