# Crescendo: Towards Real-time, Wide-band, High-Fidelity Spectrum Sensing Systems (Artifact)

This repository contains the Artifact for the paper titled **Crescendo: Towards Real-time, Wide-band, High-Fidelity Spectrum Sensing Systems**, conditionally accepted by MobiCom 2023.

The codebase provided here includes both MATLAB scripts and functions that were used to generate the figures and results detailed in the paper, particularly Figures 3 and 9.

## Structure of the Repository

The repository is organized as follows:

1. MATLAB Scripts: Main scripts that utilize the defined MATLAB functions to analyze data and generate figures. They include:

    - `ub_lo_linearity.m`: This script processes LO linearity data and plots Figure 3(b).
    - `ub_lo_stability.m`: This script processes LO stability data and plots Figure 3(a).
    - `case_study.m`: This script processes I/Q data received by the SM200C prototype of crescendo along with real-time gain settings.

2. MATLAB Functions: Supporting functions that are called within the main scripts. They include:

    - `get_lo_linearity_metrics.m`: Function to analyze linearity of LO sweeps.
    - `get_lo_stability_metrics.m`: Function to analyze stability of LO across consecutive sweeps.
    - Read/write functions

3. Data:
    - For Figure 3: The `.mat` files containing the processed IQ samples from the frequency sweeps are expected to be found within designated folders as specified in the MATLAB scripts.
    - For Figure 9 (case_study): The folders containing the binary data files are expected to be found where `case_study.m` specifies it.

## Download data

The data is available on google drive: [Link to google drive](https://drive.google.com/drive/folders/1ecI_8KYO7wolqB8gUnYW-j0yYid8wMzr?usp=sharing)

1. For Figure 3: folders starting with the prefix `ub` (total size: 23.3 MB)
2. For Figure 9: all zip files (total size: ~4.5 GB)
    - Download each zip file
    - Verify hash using `md5sum <zip_file_name>`. Hashes are in the `hashes` google doc
    - Uncompress to get the folder and data

Put all folders in `crescendo_mobicom/data/`

## Instructions to Run the Code

Before running the code, please ensure you have MATLAB installed on your system (versions R2021b or later are recommended for best compatibility). The Curve Fitting Toolbox is required.

1. Clone the repository to your local machine using Git:

```sh
git clone https://github.com/rfspectrum/crescendo_mobicom23.git
```

2. Navigate to the repository folder:

```sh
cd crescendo_mobicom23
```

3. Run the MATLAB scripts. For example, to run the `ub_lo_linearity.m` script, use the following command in the MATLAB command window:

```sh
run ub_lo_linearity.m
```

4. Repeat Step 3 for the `ub_lo_stability.m` and `case_study.m` script.

By following the above steps, you should be able to reproduce Figures 3 and 9.

Please note that you need to provide the actual data in `.mat` files as the repository does not contain the original data due to its large size. You may need to adjust the paths to these `.mat` files in the MATLAB scripts depending on your local setup.

## Support

For any inquiries or issues running the provided code, please open an issue in this repository or contact the corresponding author.

Thank you for your interest in our research and for evaluating our artifact.

(This readme, and other documentation were partly generated using LLMs)
