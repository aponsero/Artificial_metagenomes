#!/bin/sh

#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=2:mem=10gb
#PBS -l walltime=78:00:00
#PBS -l place=free:shared
#PBS -M aponsero@email.arizona.edu
#PBS -m bea

NBHOST=${PBS_ARRAY_INDEX}
LOG="$STDOUT_DIR2/${NBHOST}_gemsim.log"
ERRORLOG="$STDERR_DIR2/${NBHOST}_error.log"

touch $LOG
touch $ERRORLOG

echo "Started `date`">>"$LOG"

echo "Host `hostname`">>"$LOG"


cd /rsgrps/bhurwitz/alise/tools/GemSIM_v1.6

CURR_PROFILE=`head -n +${PBS_ARRAY_INDEX} $SPLIT_LIST | tail -n 1`
CFILE=${CURR_PROFILE:2}
FILE="$REL_OUT/profiles/$CFILE"
OUT="$REL_OUT/$CFILE"
echo "./GemReads.py -R $GENOMES_DIR -a $FILE -n $NB_READS -l d -u d -m $MODEL -q 64 -o $REL_OUT -p"

./GemReads.py -R $GENOMES_DIR -a $FILE -n $NB_READS -l d -u d -m $MODEL -q 64 -o $OUT -p

#./GemReads.py -R ../../my_data/databases/GemSIM/mock_com_LIBRA/ref_genomes -a /rsgrps/bhurwitz/alise/my_data/databases/GemSIM/mock_com_LIBRA/mock_ref1_profile_low.txt -n 10000000 -l d -m models/r454ti_s.gzip -q 33 -o ../../my_data/databases/GemSIM/mock_com_LIBRA/meta_mock1_lowV2_c10M
