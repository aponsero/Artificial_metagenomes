export CWD=$PWD
# where programs are
export GEMSIM=
# where the dataset to prepare is
export PROFILE=
export VEC=
export GENOMES_DIR=
export RESULT_DIR=
# parameters
export NB_READS= #nb reads to generate
export NB_METAGENOMES= #nb metagenomes per groups to generate
export MODEL= #error/legth model to use
export NB_GROUPS= # nb of groups to generate
#export SD= #T or F for custom SD
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers" 
# User informations
export QUEUE="standard"
export GROUP="bhurwitz"
export MAIL_USER="aponsero@email.arizona.edu"
export MAIL_TYPE="bea"

#
# --------------------------------------------------
function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function lc() {
    wc -l $1 | cut -d ' ' -f 1
}
