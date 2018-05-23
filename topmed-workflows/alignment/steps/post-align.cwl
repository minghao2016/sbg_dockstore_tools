class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://sevenbridges.com'
id: marko_zecevic/topmed-alignment/topmed-post-align/3
baseCommand:
  - samtools
  - merge
inputs:
  - id: reference
    type: File
  - id: dbsnp
    type: File?
    inputBinding:
      position: 2
      prefix: '--dbsnp'
      shellQuote: false
  - id: alignment_files
    type: 'File[]?'
    'sbg:fileTypes': BAM
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: '*cram'
label: Post-align
arguments:
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: >-
      --threads 1 -c merged.bam *.sorted.bam && bam-non-primary-dedup
      dedup_LowMem --allReadNames --binCustom --binQualS
      0:2,3:3,4:4,5:5,6:6,7:10,13:20,23:30 --log dedup_lowmem.metrics
      --recab --in merged.bam --out -.ubam
  - position: 1
    prefix: '--refFile'
    shellQuote: false
    valueFrom: |-
      ${
          return inputs.reference.path
      }
  - position: 3
    prefix: ''
    shellQuote: false
    valueFrom: '| samtools view -h -C'
  - position: 4
    prefix: '-T'
    shellQuote: false
    valueFrom: |-
      ${
          return inputs.reference.path
      }
  - position: 5
    prefix: ''
    shellQuote: false
    valueFrom: '-o output.cram --threads 1'
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 8000
    coresMin: 0
  - class: DockerRequirement
    dockerPull: images.sbgenomics.com/marko_zecevic/topmed_alignment
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.alignment_files)
  - class: InlineJavascriptRequirement
'sbg:latestRevision': 3
'sbg:revisionsInfo':
  - 'sbg:revisionNotes': Copy of marko_zecevic/topmed-align/post-align/2
    'sbg:modifiedBy': marko_zecevic
    'sbg:revision': 0
    'sbg:modifiedOn': 1525523301
  - 'sbg:revisionNotes': single output
    'sbg:modifiedBy': marko_zecevic
    'sbg:revision': 1
    'sbg:modifiedOn': 1525968584
  - 'sbg:revisionNotes': shellquote on arg3 off
    'sbg:modifiedBy': marko_zecevic
    'sbg:revision': 2
    'sbg:modifiedOn': 1526043700
  - 'sbg:revisionNotes': catch cram on output
    'sbg:modifiedBy': marko_zecevic
    'sbg:revision': 3
    'sbg:modifiedOn': 1526052274
'sbg:publisher': sbg
'sbg:modifiedOn': 1526052274
'sbg:id': marko_zecevic/topmed-alignment/topmed-post-align/3
'sbg:createdBy': marko_zecevic
'sbg:image_url': >-
  https://igor.sbgenomics.com/ns/brood/images/marko_zecevic/topmed-alignment/topmed-post-align/3.png
'sbg:validationErrors': []
'sbg:revision': 3
'sbg:createdOn': 1525523301
'sbg:modifiedBy': marko_zecevic
'sbg:projectName': TOPMed alignment
'sbg:project': marko_zecevic/topmed-alignment
'sbg:appVersion':
  - v1.0
'sbg:revisionNotes': catch cram on output
'sbg:contributors':
  - marko_zecevic
'sbg:sbgMaintained': false