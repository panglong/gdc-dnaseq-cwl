#!/usr/bin/env cwl-runner

cwlVersion: v1.0

requirements:
  - class: DockerRequirement
    dockerPull: quay.io/jeremiahsavage/gdc_bed_liftover
  - class: InlineJavascriptRequirement

class: CommandLineTool

inputs:
  []

outputs:
  - id: BAIT_INTERVAL_LIST
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.baitIntervals.hg38.list.xz"

  - id: TARGET_INTERVAL_LIST
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.targetIntervals.hg38.list.xz"

baseCommand: [/usr/local/bin/main.sh]