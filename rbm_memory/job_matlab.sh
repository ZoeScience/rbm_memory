#!/bin/bash
#!/bin/sh
#SBATCH -J test
#SBATCH -N 1 -n 1 -c 24
#SBATCH -p paratera
#SBATCH -exclusive

export LD_LIBRARY_PATH=/HOME/pp334/test/lib:$LD_LIBRARY_PATH
cd ~/Matlab2014a/R2014a/bin/

yhrun ./matlab -nodisplay -r "run ('/HOME/pp334/HLZ/github/Boltzmann/test/test_Srbm.m'); exit" >/HOME/pp334/HLZ/github/Boltzmann/output_tests.out






