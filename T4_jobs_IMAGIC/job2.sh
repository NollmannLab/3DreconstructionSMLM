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
all-nc
all-alig1
all-n
mra-ref1n
NO_FILTER
0.2
0.05
-180,180
-180,180
HIGH
0.0,0.6
5
NO
EOF
#
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
all-alig1
all-alig2
all-n
mra-ref1n
NO_FILTER
0.2
0.05
-180,180
-180,180
HIGH
0.0,0.6
5
NO
EOF
echo "! "
echo "! IMAGIC program: msa --------------------------------------------------"
echo "! "
/usr/local/softEM/imagic/openmpi/bin/mpirun -np 8 -x IMAGIC_BATCH  /usr/local/softEM/imagic/msa/msa.e_mpi <<EOF
YES
8
NO
FRESH_MSA
MODULATION
all-alig2
msamask
eigenim-2
YES
50
50
msa-2
EOF
echo "! "
echo "! IMAGIC program: classify ---------------------------------------------"
echo "! "
/usr/local/softEM/imagic/msa/classify.e <<EOF
IMAGES/VOLUMES
all-alig2
0
50
YES
200
classes-2-200
EOF
echo "! "
echo "! IMAGIC program: classum ----------------------------------------------"
echo "! "
/usr/local/softEM/imagic/msa/classum.e <<EOF
all-alig2
classes-2-200
classums-2-200
YES
0
NONE
EOF
echo "! "
echo "! IMAGIC program: classify ---------------------------------------------"
echo "! "
/usr/local/softEM/imagic/msa/classify.e <<EOF
IMAGES/VOLUMES
all-alig2
0
10
YES
100
classes-2-100
EOF
echo "! "
echo "! IMAGIC program: classum ----------------------------------------------"
echo "! "
/usr/local/softEM/imagic/msa/classum.e <<EOF
all-alig2
classes-2-100
classums-2-100
YES
0
NONE
EOF
echo "! "
echo "! IMAGIC program: classify ---------------------------------------------"
echo "! "
/usr/local/softEM/imagic/msa/classify.e <<EOF
IMAGES/VOLUMES
all-alig2
0
10
YES
150
classes-2-150
EOF
echo "! "
echo "! IMAGIC program: classum ----------------------------------------------"
echo "! "
/usr/local/softEM/imagic/msa/classum.e <<EOF
all-alig2
classes-2-150
classums-2-150
YES
0
NONE
EOF
