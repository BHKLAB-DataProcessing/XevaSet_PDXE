from snakemake.remote.S3 import RemoteProvider as S3RemoteProvider
# S3 = S3RemoteProvider(
#     access_key_id=config["key"],
#     secret_access_key=config["secret"],
#     host=config["host"],
#     stay_on_remote=False
# )

prefix = config["prefix"]

rule get_xevaset:
    input:
        prefix + "data/drug_info.csv",
        prefix + "data/expriment.csv",
        prefix + "data/model_info.csv",
        prefix + "data/modToBiobaseMap.csv",
        prefix + "data/molProf_cnv.rds",
        prefix + "data/molProf_mutation.rds",
        prefix + "data/molProf_RNASeq.rds",
    output:
        prefix + "Xeva_PDXE.rds"
    shell:
        """
        Rscript {prefix}scripts/create_PDXE_xevaset.R {prefix}       
        """

rule download_data:
    output:
        prefix + "data/drug_info.csv",
        prefix + "data/expriment.csv",
        prefix + "data/model_info.csv",
        prefix + "data/modToBiobaseMap.csv",
        prefix + "data/molProf_cnv.rds",
        prefix + "data/molProf_mutation.rds",
        prefix + "data/molProf_RNASeq.rds",
    shell:
        """
        wget 'https://github.com/BHKLAB-DataProcessing/getPDXE/raw/main/drug_info.csv' \
            -O {prefix}download/drug_info.csv
        wget 'https://github.com/BHKLAB-DataProcessing/getPDXE/raw/main/expriment.csv' \
            -O {prefix}download/expriment.csv
        wget 'https://github.com/BHKLAB-DataProcessing/getPDXE/raw/main/model_info.csv' \
            -O {prefix}download/model_info.csv
        wget 'https://github.com/BHKLAB-DataProcessing/getPDXE/raw/main/modToBiobaseMap.csv' \
            -O {prefix}download/modToBiobaseMap.csv
        wget 'https://github.com/BHKLAB-DataProcessing/getPDXE/raw/main/molProf_cnv.rds' \
            -O {prefix}download/molProf_cnv.rds
        wget 'https://github.com/BHKLAB-DataProcessing/getPDXE/raw/main/molProf_mutation.rds' \
            -O {prefix}download/molProf_mutation.rds
        wget 'https://github.com/BHKLAB-DataProcessing/getPDXE/raw/main/molProf_RNASeq.rds' \
            -O {prefix}download/molProf_RNASeq.rds
        """
