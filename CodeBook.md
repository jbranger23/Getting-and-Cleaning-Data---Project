---
title: "CodeBook.md"
author: "Juan Branger"
date: "25 May 2016"
output: html_document
---

This file should be downloaded to the working directory as previus step

## Assigment:Getting and Cleaning Data Course Project
1) Download required files from: https://github.com/jbranger23/Getting-and-Cleaning-Data---Project
Run the following lines:
-------------------
download.file("https://github.com/jbranger23/Getting-and-Cleaning-Data---Project/blob/master/run_analysis.R",destfile = "run_analysis.R", method = "curl")
download.file("https://github.com/jbranger23/Getting-and-Cleaning-Data---Project/blob/master/README.txt",destfile = "README.txt", method = "curl")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","dataset.zip","curl")
--------------------
## and to uncompress run: 
unzip("dataset.zip")

2) and finally run-analysis.R script to obtain required datasets
run_analysis.R
