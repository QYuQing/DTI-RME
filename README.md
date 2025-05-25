# DTI-RME
DTI-RME: A Robust and Multi-Kernel Ensemble Approach for Drug-Target Interaction Prediction
MATLAB Version: R2018b
Author Contact: ustsyuqingqian@gmail.com

📁 Project Structure
main.m: Main script to run the DTI-RME model.

datasets/: Directory containing the datasets for training and testing.

functions/: Custom functions used in the model (if applicable).

results/: Output folder where prediction scores will be saved (create if not present).

🚀 How to Run the Program
Environment Setup

Install MATLAB R2018b or newer.

Add all subfolders to the MATLAB path:

matlab
复制
编辑
addpath(genpath(pwd));
Execute the Main Script

In the MATLAB command window, run:

matlab
复制
编辑
main
Output

The script will output predicted drug-target interaction scores.

Results will be displayed in the console or saved to the results/ folder if configured.

🔁 How to Replicate the Results in the Paper
Ensure dataset files are placed correctly under datasets/, with the same format used in the original experiments.

Run main.m — the script includes all necessary steps for preprocessing, model training, and evaluation.

Check AUC/ACC results printed at the end to compare with those reported in the paper.

If exact data splits are needed (e.g., 5-fold CV), please make sure the same random seed or split files are used. You can edit main.m to control this.

📩 Contact
For questions or issues, please email: ustsyuqingqian@gmail.com
