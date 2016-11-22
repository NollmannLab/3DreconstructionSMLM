#!/bin/csh -f
setenv IMAGIC_BATCH 1
echo "! "
echo "! "
echo "! ====================== "
echo "! IMAGIC ACCUMULATE FILE "
echo "! ====================== "
echo "! "
echo "! "
echo "! IMAGIC program: euler ------------------------------------------------"
echo "! "
/usr/local/softEM/imagic/openmpi/bin/mpirun -np 8 -x IMAGIC_BATCH  /usr/local/softEM/imagic/angrec/euler.e_mpi <<EOF
C6
0.0
ANCHO
FRESH
SINGLE_ANCHOR_SET
IMAGES
classums-2-200-ali-hp-ex1
sino-2
NO
0.6
IMAGES
mra-ref1n
arsino-2
sinecorr-2
YES
2.0
FISHER_TRANSFORM
YES
8
FINAL_OUTPUT
YES
EOF
echo "! "
echo "! IMAGIC program: true_3d ----------------------------------------------"
echo "! "
/usr/local/softEM/imagic/openmpi/bin/mpirun -np 8 -x IMAGIC_BATCH  /usr/local/softEM/imagic/threed/true_3d.e_mpi <<EOF
BOTH
8
ALL
C6
YES
classums-2-200-ali-hp-ex1
ANGREC_HEADER_VALUES
NO
3d-2-1
3d-2-1_reprojs
3d-2-1_err
YES
0.6
0.75
0.5
EOF
