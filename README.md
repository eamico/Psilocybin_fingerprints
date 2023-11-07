# Psilocybin Pharmacological Fingerprinting
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-3-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

Sample code to replicate analyses and figures of the paper "*The Unique Neural Signature of Your Trip: Functional Connectome Fingerprints of Subjective Psilocybin Experience*" by Tolle et al., Network Neuroscience 2023. <https://direct.mit.edu/netn/article/doi/10.1162/netn_a_00349/117963/The-Unique-Neural-Signature-of-Your-Trip>

## Citing

If you use this analysis in your research, please cite the following paper:

Hanna M. Tolle, Juan Carlos Farah, Pablo Mallaroni, Natasha L. Mason, Johannes G. Ramaekers, Enrico Amico;_The Unique Neural Signature of Your Trip: Functional Connectome Fingerprints of Subjective Psilocybin Experience_. Network Neuroscience 2023; doi: [https://doi.org/10.1162/netn_a_00349](https://doi.org/10.1162/netn_a_00349)

```
@article{tolle2023unique,
    author = {Tolle, Hanna M. and Farah, Juan Carlos and Mallaroni, Pablo and Mason, Natasha L. and Ramaekers, Johannes G. and Amico, Enrico},
    title = "{The Unique Neural Signature of Your Trip: Functional Connectome Fingerprints of Subjective Psilocybin Experience}",
    journal = {Network Neuroscience},
    pages = {1-54},
    year = {2023},
    month = {11},
    issn = {2472-1751},
    doi = {10.1162/netn_a_00349},
    url = {https://doi.org/10.1162/netn\_a\_00349},
    eprint = {https://direct.mit.edu/netn/article-pdf/doi/10.1162/netn\_a\_00349/2165989/netn\_a\_00349.pdf},
}
```

🙏

## Description

The code generates figures analogous to Figure 2 and Figure 3A-C and E of the paper. However, note that the sample data provided in this repository is not from the participants of our study, but instead from 10 healthy subjects of the [Human Connectome Project](https://www.humanconnectomeproject.org). Hence, while running this code will perform the same analyses as in our study, it will not generate the exact same results and figures. The data used in our study is available upon request.

## Running this Code

In order to run this code, clone the repository and make sure to adjust the file paths in main.m according to your file system.
Then, navigate into the `scripts` directory where `main.m` is located and execute `main.m`.

## Dependencies

Running this code requires the following MATLAB packages, which must be downloaded and added to the path (the latter is done by `scripts/prepare_environment.m` if `paths.externals` is set to the file path of the external dependencies).
- [bluewhitered](https://de.mathworks.com/matlabcentral/fileexchange/4058-bluewhitered)
- [ICC](https://de.mathworks.com/matlabcentral/fileexchange/22099-intraclass-correlation-coefficient-icc)
- [resampling statistical toolkit](https://de.mathworks.com/matlabcentral/fileexchange/27960-resampling-statistical-toolkit)
- [notBoxPlot-master](https://de.mathworks.com/matlabcentral/fileexchange/26508-notboxplot)

The code was written in MATLAB R2023b.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/hannatolle"><img src="https://avatars.githubusercontent.com/u/88772546?v=4?s=100" width="100px;" alt="hannatolle"/><br /><sub><b>hannatolle</b></sub></a><br /><a href="https://github.com/eamico/Psilocybin_fingerprints/commits?author=hannatolle" title="Code">💻</a> <a href="https://github.com/eamico/Psilocybin_fingerprints/commits?author=hannatolle" title="Documentation">📖</a> <a href="#ideas-hannatolle" title="Ideas, Planning, & Feedback">🤔</a> <a href="#research-hannatolle" title="Research">🔬</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://juancarlosfarah.com"><img src="https://avatars.githubusercontent.com/u/1707188?v=4?s=100" width="100px;" alt="Juan Carlos Farah"/><br /><sub><b>Juan Carlos Farah</b></sub></a><br /><a href="https://github.com/eamico/Psilocybin_fingerprints/commits?author=juancarlosfarah" title="Code">💻</a> <a href="https://github.com/eamico/Psilocybin_fingerprints/commits?author=juancarlosfarah" title="Documentation">📖</a> <a href="#ideas-juancarlosfarah" title="Ideas, Planning, & Feedback">🤔</a> <a href="#research-juancarlosfarah" title="Research">🔬</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://miplab.epfl.ch/index.php/people/eamico"><img src="https://avatars.githubusercontent.com/u/6409808?v=4?s=100" width="100px;" alt="Enrico Amico"/><br /><sub><b>Enrico Amico</b></sub></a><br /><a href="https://github.com/eamico/Psilocybin_fingerprints/commits?author=eamico" title="Code">💻</a> <a href="https://github.com/eamico/Psilocybin_fingerprints/commits?author=eamico" title="Documentation">📖</a> <a href="#ideas-eamico" title="Ideas, Planning, & Feedback">🤔</a> <a href="#research-eamico" title="Research">🔬</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
