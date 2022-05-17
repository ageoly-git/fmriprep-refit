#!/bin/bash
#THIS REVISES THE DIRECTORY STRUCTURE OF AN FMRIPREP DIRECTORY (V.21.0.1) TO MEET BSLPP REQUIREMENTS

# Written by: Andrew Geoly, MS
#Stanford Brain Stimulation Lab
#5/11/2022

WORK_DIR=$1
OUTPUT_DIR=$2
##############################################################################
# Reformat the fmriprep directory to match BSLPP and then zip to output directory
echo "mkdir ${WORK_DIR}/fmriprep"
mkdir ${WORK_DIR}/fmriprep
echo "mv ${WORK_DIR}/*/sub-* ${WORK_DIR}/fmriprep"
mv ${WORK_DIR}/*/sub-* ${WORK_DIR}/fmriprep
echo "ls -l $WORK_DIR"
ls -l $WORK_DIR
echo "zip -r $OUTPUT_DIR/fmriprep_reformatted_21.0.1.zip  fmriprep"
zip -r $OUTPUT_DIR/fmriprep_reformatted_21.0.1.zip  fmriprep

