# DTI-RME

DTI-RME: A Robust and Multi-Kernel Ensemble Approach for Drug-Target Interaction Prediction

MATLAB Version: R2018b

📁 Project Structure

main.m: Main script to run the DTI-RME model.

datasets.zip: ZIP containing the datasets for training and testing.

🚀 How to Run the Program

Ensure dataset files are placed correctly under datasets/, with the same format used in the original experiments.

In the MATLAB command window, run:

main.m

| Parameter | Default | Description                                                                                                                   |
| --------- | ------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `seed`    | 2024    | Random seed to ensure reproducibility of cross-validation splits and results.                                                 |
| `nfolds`  | 5       | Number of folds for cross-validation; the dataset is split into 5 parts, with each part used as the test set once.            |
| `nruns`   | 20      | Number of runs (currently unused in the script, but can be extended for repeated experiments).                                |
| `ratio`   | 5       | Ratio of negative to positive samples in the test set; negative samples are downsampled accordingly.                          |
| `cv_type` | 'CVD'   | Type of cross-validation. `'CVD'` indicates cross-validation on drugs (CVP,CVT). |


The script will output predicted drug-target interaction scores.

Check AUC,AUPR results printed at the end to compare with those reported in the paper.

📩 Contact

For questions or issues, please email: ustsyuqingqian@gmail.com

