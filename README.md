# VHDL_cooley-tukey_fft
VHDL implementation of a 8-points FFT using Cooley-Tukey algorithm during academic lessons with Martin Deshardillier, my classmate.

This project aims to develop a hardware structure on FPGA with VHDL. This FFT was developped using Cooley-Tukey algorithm, based on a 8-point structure.

We decided to improve two criterias:

- reduce silicon costs
- optimize calculation time

The first one was reached by using Dual port RAM to store transitional results. It asks a lot of time to think about places of different results, because we can not access to the same 
