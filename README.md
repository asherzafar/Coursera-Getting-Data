---
title: "Getting and Cleaning Data: Course Project"
author: "Asher Zafar"
date: "January 25, 2015"
output: html_document
---

This repo contains the tidy data set for the a Cousera course project, as well as the analysis code to produce this set from the source files.

# Files in this repo
The following other files are in this repo:
* AveragesBySubjectAndActivity.txt - the tidy data set required for the project.
* run_analysis.R - the script required to produce this data set from the source files.

The original files may be found here: (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

A description of this data may be found here: (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# Description of transformation

The raw data contained separate files for labels, activities, features, and subjects. It was also split into a training set and a test set. Using the run_analysis.R script, each set was aligned and appropriately labelled, then the two sets were merged. Only columns containing the strings "mean" or "std" were kept, in addition to the subject and activity columns. The mean was then tabulated for each combination of subject and activity for remaining columns. The tidy output was then exported to AveragesBySubjectAndActivity.txt.

# Description of variables

* Subject: there is a number assigned to each subject for whom data was collected (1 - 30)
* Activity: there are six activities for which movements were tracked. Each is labelled with a plain english description
* Features: From the original data set, 82 variables which contained the strings "mean" or "std" were filtered. The mean was tabulated by subject and activity across all observations, and is contained within these columns.
