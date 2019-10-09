#!/bin/sh
# download nltk tokenizer
python -m nltk.downloader punkt

wget -c http://qim.fs.quoracdn.net/quora_duplicate_questions.tsv

# download index
wget -c https://storage.googleapis.com/paws/english/paws_qqp.tar.gz -O - | tar -xz 

ORIGINAL_QQP_FILE="${PWD}/quora_duplicate_questions.tsv"
PAWS_QQP_DIR="${PWD}/paws_qqp"
PAWS_QQP_OUTPUT_DIR="${PWD}/paws_qqp/output"

mkdir -p ${PAWS_QQP_OUTPUT_DIR}

python qqp_generate_data.py \
  --original_qqp_input="${ORIGINAL_QQP_FILE}" \
  --paws_input="${PAWS_QQP_DIR}/train.tsv" \
  --paws_output="${PAWS_QQP_OUTPUT_DIR}/train.tsv"

python qqp_generate_data.py \
  --original_qqp_input="${ORIGINAL_QQP_FILE}" \
  --paws_input="${PAWS_QQP_DIR}/dev_and_test.tsv" \
  --paws_output="${PAWS_QQP_OUTPUT_DIR}/dev_and_test.tsv"