#!/bin/csh -f
setenv IMAGIC_BATCH 1
echo "! "
echo "! "
echo "! ====================== "
echo "! IMAGIC ACCUMULATE FILE "
echo "! ====================== "
echo "! "
echo "! "
echo "! IMAGIC program: inc2dmenu --------------------------------------------"
echo "! "
/usr/local/softEM/imagic/openmpi/bin/mpirun -np 8 -x IMAGIC_BATCH  /usr/local/softEM/imagic/incore/inc2dmenu.e_mpi MODE NORM_VARIANCE <<EOF
SOFT
all
all-n
0.95,3.0
10.0
YES
8
EOF
echo "! "
echo "! IMAGIC program: alimass ----------------------------------------------"
echo "! "
/usr/local/softEM/imagic/openmpi/bin/mpirun -np 8 -x IMAGIC_BATCH  /usr/local/softEM/imagic/align/alimass.e_mpi <<EOF
YES
8
all-n
all-nc
TOTSUM
CCF
0.2
3
NO_FILTER
EOF
