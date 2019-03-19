#!/bin/sh
set -u
#
# Checking args
#

source scripts/config.sh

if [[ ! -f "$PROFILE" ]]; then
    echo "$PROFILE does not exist. Please provide the path to the profile to process. Job terminated."
    exit 1
fi

if [[ ! -d "$GENOME_DIR" ]]; then
  echo "$GENOME_DIR does not exist. Please provide the path to folder containing the genomes to process. Job terminated."
  exit 1
fi

if [[ ! -d "$RESULT_DIR" ]]; then
  echo "$RESULT_DIR does not exist. Directory created"
  mkdir $RESULT_DIR
fi

#
# Job submission
#

PREV_JOB_ID=""
ARGS="-q $QUEUE -W group_list=$GROUP -M $MAIL_USER -m $MAIL_TYPE"

#
## 01-run abundance vectors
#

PROG="01-run-vectors"
export STDERR_DIR="$SCRIPT_DIR/err/$PROG"
export STDOUT_DIR="$SCRIPT_DIR/out/$PROG"

init_dir "$STDERR_DIR" "$STDOUT_DIR"

export NUM_FILE=$(wc -l < "$FILE_LIST_R1")


echo "launching $SCRIPT_DIR/run_abundance_vectors.sh "


JOB_ID=`qsub $ARGS -v PROFILE,NB_METAGENOMES,NB_GROUPS,RESULT_DIR,STDERR_DIR,STDOUT_DIR -N run_vectors -e "$STDERR_DIR" -o "$STDOUT_DIR"  $SCRIPT_DIR/run_abundance_vectors.sh.sh`

if [ "${JOB_ID}x" != "x" ]; then
    echo Job: \"$JOB_ID\"
    PREV_JOB_ID=$JOB_ID  
else
    echo Problem submitting job. Job terminated
fi
    
echo "job successfully submited"

