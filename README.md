# VHDL_cooley-tukey_fft
VHDL implementation of a 8-points FFT using Cooley-Tukey algorithm during academic lessons with Martin Deshardillier, my classmate.

Read the PDF attached (it is written in French).

This project aims to develop a hardware structure on FPGA with VHDL. This FFT was developped using Cooley-Tukey algorithm, based on a 8-point structure.

We decided to improve two criterias:

- reduce silicon costs
- optimize calculation time

The first one was reached by using 2 Dual port RAMs to store transitional results. It asks a lot of time to think about addresses of different transitional results, because we can not access to the same memory at the same time. If we did not care about time, let's do this. But it was a challenge to try to do the best hardware description, so we did the best. After our viva voce to our senior lecturer, he told us that an algorithm exists to do the address positioning: it is named graph coloring.

We also used only one butterfly hardware instance to reduce silicon costs. But we need 2 switches for the addressing, one before the butterfly operator, one after. 

The calculation time was improved during the memory optimization with the addressing management.
