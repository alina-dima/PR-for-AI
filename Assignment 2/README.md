# Assignment 2
Alina, Lisa, Nikolai, Ömer (Group 07)

## Before running
- Install *requirements.txt*
- Add the *Genes* and *creditcard* datasets to *Data-PR-As2*

## Running the notebooks
The contents of the notebooks are already in the right order, so they can be ran from top to bottom.

## Warning!
- Running the SIFT grid search took around 9 hours for us (the entire ORB pipeline takes less than 20 minutes).
- Running all 100 iterations of Task 2 took around 9 hours for us.
- We would recommend restarting the kernel after running the ORB pipeline and before running the SIFT pipeline because there is an issue where the contents of the plots would overlap. We tried clearing the figures, closing them and creating new ones, but nothing fixed the issue. There appears to be an issue with the way Jupyter interacts with matplotlib.
