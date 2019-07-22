export CWD=$PWD
# where programs are
export GEMSIM=
# where the dataset to prepare is
export PROFILE="/rsgrps/bhurwitz/alise/my_data/De_Novo_meta/Simulated_datasets/SimSetQ_genomes.txt"
export VEC="/rsgrps/bhurwitz/alise/my_data/De_Novo_meta/Simulated_datasets/abundance_vec2_SQ.txt"
export GENOMES_DIR="../../my_data/De_Novo_meta/Simulated_datasets/orginal_genomes" #GemSim won't work if this is not relative to $GEMSIM
export RESULT_DIR="/rsgrps/bhurwitz/alise/my_data/De_Novo_meta/Simulated_datasets/test_cluster"
export REL_OUT="../../my_data/De_Novo_meta/Simulated_datasets/test_cluster" #output dir relative to $GEMSIM
# parameters
export NB_READS=5000 #nb reads to generate
export NB_METAGENOMES=10 #nb metagenomes per groups to generate
export MODEL="models/ill100v4_p.gzip" #error/legth model to use
export NB_GROUPS=3 # nb of groups to generate
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
