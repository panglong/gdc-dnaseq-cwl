#!/usr/bin/env cwl-runner

cwlVersion: v1.0

requirements:
  - class: DockerRequirement
    dockerPull: quay.io/ncigdc/mirna-profiler:latest
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.sam.basename)
        entry: $(inputs.sam)
        writable: true
  - class: ShellCommandRequirement

class: CommandLineTool

inputs:
  - id: sam
    format: "edam:format_2572"
    type: File
    
  - id: mirbase
    type: string
    default: "hg38"
    inputBinding:
      position: 90
      prefix: -m
      shellQuote: false

  - id: ucsc_database
    type: string
    default: "hg38"
    inputBinding:
      position: 91
      prefix: -u
      shellQuote: false

  - id: species_code
    type: string
    default: "hsa"
    inputBinding:
      position: 92
      prefix: -o
      shellQuote: false

  - id: project_directory
    type: string
    default: "."
    inputBinding:
      position: 93
      prefix: -p
      shellQuote: false

outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.sam.basename)

arguments:
  - valueFrom: "chmod 1777 /tmp"
    position: 0
    shellQuote: false

  - valueFrom: "&& /usr/sbin/mysqld --defaults-file=/etc/mysql/my.cnf --user=mysql --daemonize"
    position: 1
    shellQuote: false

  - valueFrom: "&& /root/mirna/v0.2.7/code/annotation/annotate.pl"
    position: 3
    shellQuote: false

baseCommand: []