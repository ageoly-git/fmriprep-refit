#!/bin/bash
#THIS REVISES THE DIRECTORY STRUCTURE OF AN FMRIPREP DIRECTORY (V.21.0.1) TO MEET BSLPP REQUIREMENTS

# Written by: Andrew Geoly, MS
#Stanford Brain Stimulation Lab
#5/11/2022



##############################################################################
# Configure paths

FLYWHEEL_BASE=/flywheel/v0
OUTPUT_DIR=/flywheel/v0/output
WORK_DIR=/flywheel/v0/work
CONFIG_FILE=$FLYWHEEL_BASE/config.json
MANIFEST_FILE=$FLYWHEEL_BASE/manifest.json

if [[ ! -f $CONFIG_FILE ]]; then
  CONFIG_FILE=$MANIFEST_FILE
fi

##############################################################################
# Parse configuration

# If the config file does not exist (i.e., local run) then parse the config
# options and values from the manifest. Those variables can be found in the
# manifest.json file within the `config` map.


function parse_config {
  # If config.json exists, then we parse config file  Otherwise we parse
  # manifest.json.

  CONFIG_FILE=$FLYWHEEL_BASE/config.json
  MANIFEST_FILE=$FLYWHEEL_BASE/manifest.json

  if [[ -f $CONFIG_FILE ]]; then
    echo "$(cat $CONFIG_FILE | jq -r '.config.'$1)"
  else
    CONFIG_FILE=$MANIFEST_FILE
    echo "$(cat $MANIFEST_FILE | jq -r '.config.'$1'.default')"
  fi
}

##############################################################################




##############################################################################
# Extract the input file into working directory

INPUT_ZIP="$(cat $CONFIG_FILE | jq -r '.inputs.fMRIprep_zip.location.path')"
echo "input zipfile: $INPUT_ZIP"

WORK_ZIP=${WORK_DIR}/fmriprep_zip.zip

if [ ! -d $WORK_DIR ]; then
  mkdir $WORK_DIR
fi

echo "copying $INPUT_ZIP to $WORK_ZIP"
echo "cp "$INPUT_ZIP" $WORK_ZIP"
cp "$INPUT_ZIP" $WORK_ZIP

echo "unzipping $WORK_ZIP"

echo "unzip $WORK_ZIP -d $WORK_DIR"
unzip $WORK_ZIP -d $WORK_DIR

rm -f ${WORK_ZIP}

cd $WORK_DIR
 
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

echo "Done reformatting the zip"
