#!/bin/csh -f
setenv IMAGIC_BATCH 1
echo "! "
echo "! "
echo "! ====================== "
echo "! IMAGIC ACCUMULATE FILE "
echo "! ====================== "
echo "! "
echo "! "
echo "! IMAGIC program: mralign ----------------------------------------------"
echo "! "
/usr/local/softEM/imagic/openmpi/bin/mpirun -np 8 -x IMAGIC_BATCH  /usr/local/softEM/imagic/align/mralign.e_mpi <<EOF
YES
8
FRESH
ALL_REFERENCES
ALIGNMENT
BOTH (ROT AND TRANS)
ROTATION_FIRST
CCF
classums-2-200
classums-2-200-ali
classums-2-200
mra-ref1n
NO_FILTER
0.2
-180,180
HIGH
0.0,0.6
5
NO
EOF
echo "! "
echo "! IMAGIC program: inc2dmenu --------------------------------------------"
echo "! "
/usr/local/softEM/imagic/incore/inc2dmenu.e MODE HIGHPASS <<EOF
classums-2-200-ali
classums-2-200-ali-hp
0.4
0
NO
EOF
