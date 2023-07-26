# Crescendo: Towards Real-time, Wide-band, High-Fidelity Spectrum Sensing Systems (Artifact)

This repository contains the Artifact for the paper titled **Crescendo: Towards Real-time, Wide-band, High-Fidelity Spectrum Sensing Systems**, conditionally accepted by MobiCom 2023.

The codebase provided here includes both MATLAB scripts and functions that were used to generate the figures and results detailed in the paper, particularly Figures 3(a) and 3(b).

## Structure of the Repository

The repository is organized as follows:

1. MATLAB Scripts: Main scripts that utilize the defined MATLAB functions to analyze data and generate figures. They include:

    - `ub_lo_linearity.m`: This script processes LO linearity data and plots Figure 3(b).
    - `ub_lo_stability.m`: This script processes LO stability data and plots Figure 3(a).

2. MATLAB Functions: Supporting functions that are called within the main scripts. They include:

    - `get_lo_linearity_metrics.m`: Function to analyze linearity of LO sweeps.
    - `get_lo_stability_metrics.m`: Function to analyze stability of LO across consecutive sweeps.

3. Data: The `.mat` files containing the processed IQ samples from the frequency sweeps are expected to be found within designated folders as specified in the MATLAB scripts.

## Download data

```
TODO
```

## Instructions to Run the Code

Before running the code, please ensure you have MATLAB installed on your system (versions R2019b or later are recommended for best compatibility).

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

4. Repeat Step 3 for the `ub_lo_stability.m` script.

By following the above steps, you should be able to reproduce Figures 3(a) and 3(b) as shown in the paper.

Please note that you need to provide the actual data in `.mat` files as the repository does not contain the original data due to its large size. You may need to adjust the paths to these `.mat` files in the MATLAB scripts depending on your local setup.

## Support

For any inquiries or issues running the provided code, please open an issue in this repository or contact the corresponding author.

Thank you for your interest in our research and for evaluating our artifact.
