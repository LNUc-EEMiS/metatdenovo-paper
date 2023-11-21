#!/bin/sh

# Script to fetch fastq files for the MST-1 project from ENA

mkdir reads
cd reads
wget \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978610/ERR978610_1.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978610/ERR978610_2.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978611/ERR978611_1.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978611/ERR978611_2.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978612/ERR978612_1.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978612/ERR978612_2.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978613/ERR978613_1.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978613/ERR978613_2.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978614/ERR978614_1.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978614/ERR978614_2.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978615/ERR978615_1.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978615/ERR978615_2.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978616/ERR978616_1.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978616/ERR978616_2.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978617/ERR978617_1.fastq.gz \
    https://ftp.sra.ebi.ac.uk/vol1/fastq/ERR978/ERR978617/ERR978617_2.fastq.gz
