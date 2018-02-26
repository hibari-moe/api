# LaTeX Report

:warning: Packages requiring Shell Escape [are not supported](https://github.com/tectonic-typesetting/tectonic/issues/38)

## Requirements

- linux, macOS or Windows Subsystem for Linux*
- [miniconda]
- pygments
- tectonic

\* Tectonic does not natively support Windows currently

## Install

1. Install [miniconda]
2. `conda config --add channels conda-forge`
3. `conda update --all`
4. `conda install pygments tectonic`

## Build

```shell
bin/report
```

[miniconda]: https://conda.io/miniconda.html
