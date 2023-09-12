Creation of a user interface using a Basys3 card to control the speed and activation/deactivation of headlight calls or sound
announcements of one or more trains. 

# File architecture :

* sim : contains all the testbench's of the DCC Central modules
* src  :
```txt
    - contains the c code file for the software part in vitis
    - the vhd source codes of the DCC Central modules
```

``Central_DCC_on_FPGA ``\
├── ``sim/`` : all the testbench's of the DCC Central modules\
├── ``src/``\
│   ├── ``c code/`` : c code file for the software part in vitis\
│   ├── ``vhd code/`` : vhd source codes of the DCC Central modules\
├── ``Basys_3_Master.xdc`` : constraint file for the Basys3\
├── ``Rapport_projet_FPGA_BISLIEV_YANG.pdf`` : project report\
├── ``wrapper.xsa`` : FPGA wrapper file\

This project is design as follow :\
``RiVer_SoC``\
├── ``Documentation`` : some usefull documentation like riscv spec, our project report...etc\
├── ``IMPL``\
│   ├── ``hw`` : IP source for FPGA implementation\
│   └── ``sw`` : software and drivers use for FPGA implementation\
├── ``riscof`` : framework riscof used to validate our model. It contains a lot of assembly tests\
├── ``scripts`` : scripts used to validate github push on main\
├── ``Shell_script`` : helper script for setup your environment\
├── ``SIM``\
│   ├── ``CORE_VHDL`` : source code of our VHDL implementation\
│   ├── ``ELFIO`` : c++ parsor library that we used to parse an elf file in our SystemC implementation\
│   └── ``SystemC`` : contains all the source code of our cores\
│      ├── ``CORE`` : source code of the RV32IMZicsr with branch prediction mecanism\
│       └── ``sysc_miniriscv`` : source code of a RV32I simplified core \
├── ``SOFT`` : contains all our software code such as reset and exception handler code\
    ├── ``riverOS`` : Rust OS prototype\
    └── ``TESTS`` : some .c and .s file that we wrote to validate our model\


