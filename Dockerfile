ARG BASE_IMAGE=quay.io/jupyter/all-spark-notebook:latest
FROM $BASE_IMAGE

# for information why "ln -s / .lsp_symlink": https://github.com/jupyter-lsp/jupyterlab-lsp#installation

RUN mamba install --yes 'flake8' \
    'notebook>=7.2.2' \
    'conda-forge::jupyterlab-latex' \
    'conda-forge::plotly' \
    'conda-forge::anywidget' \
    'conda-forge::jupyterlab-lsp' \
    'conda-forge::python-lsp-server' \
    'conda-forge::r-languageserver' \
    'conda-forge::sql-language-server' \
    'conda-forge::bash-language-server' \
    'conda-forge::pyrefly' \
    'conda-forge::pyright' \
    'conda-forge::basedpyright' \
    'conda-forge::texlab' \
    && pip install --upgrade \
    'jupyterlab-git'  \
    'lxml' \
    'jupyterlab-code-formatter' 'black' 'isort' \
    && mamba clean --all -f -y \
    && ln -s / .lsp_symlink \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}" \
    && jupyter labextension enable @jupyterlab/completer-extension:base-service \
    && jupyter labextension enable @jupyterlab/fileeditor-extension:language-server \
    && jupyter labextension enable @jupyterlab/lsp-extension:settings \
    && jupyter labextension enable @jupyterlab/notebook-extension:language-server