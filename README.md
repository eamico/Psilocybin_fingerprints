# Psilocybin Pharmacological Fingerprinting
Sample code to replicate analyses and figures of the paper "*The Unique Neural Signature of Your Trip: Functional Connectome Fingerprints of Subjective Psilocybin Experience*" by Tolle et al., Network Neuroscience 2023. <https://direct.mit.edu/netn/article/doi/10.1162/netn_a_00349/117963/The-Unique-Neural-Signature-of-Your-Trip>

The code generates figures analogous to Figure 2 and Figure 3A-C and E of the paper. However, note that the sample data provided in this repository is not from the participants of our study, but instead from 10 healthy subjects of the Human Connectome Project (<https://www.humanconnectomeproject.org>). Hence, while running this code will perform the same analyses as in our study, it will not generate the exact same results and figures. The data used in our study is available upon request. 

## Running this code
In order to run this code, clone the repository and make sure to adjust the file paths in main.m according to your file system. 
Then, navigate into the `scripts` directory where `main.m` is located and execute `main.m`.

## Dependencies
Running this code requires the following MATLAB packages, which must be downloaded and added to the path (the latter is done by `scripts/prepare_environment.m` if `paths.externals` is set to the file path of the external dependencies).
- bluewhitered <https://de.mathworks.com/matlabcentral/fileexchange/4058-bluewhitered>
- ICC <https://de.mathworks.com/matlabcentral/fileexchange/22099-intraclass-correlation-coefficient-icc>
- resampling statistical toolkit <https://de.mathworks.com/matlabcentral/fileexchange/27960-resampling-statistical-toolkit>
- notBoxPlot-master <https://de.mathworks.com/matlabcentral/fileexchange/26508-notboxplot>

The code was written in MATLAB R2023b.

## Contributors to this repository
- Enrico Amico
- Juan Carlos Farah
- Hanna Tolle
