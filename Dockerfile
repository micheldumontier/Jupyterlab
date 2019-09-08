FROM python:3.7

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  apt-get upgrade -y && \
  apt-get install -y nodejs texlive-latex-extra texlive-xetex && \
  rm -rf /var/lib/apt/lists/*

RUN pip install \
  jupyterlab \
  ipywidgets \
  jupyterlab_latex \
  plotly \
  bokeh \
  numpy \
  scipy \
  matplotlib \
  ipython \
  pandas \
  sympy \
  seaborn \
  nose

RUN jupyter labextension install \
  @jupyter-widgets/jupyterlab-manager \
  @jupyterlab/latex \
  @mflevine/jupyterlab_html \
  jupyterlab-drawio \
  @jupyterlab/plotly-extension \
  jupyterlab_bokeh \
  jupyterlab-spreadsheet

COPY bin/entrypoint.sh /usr/local/bin/
COPY config/jupyter_notebook_config.py /root/.jupyter/
COPY config/plugin.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/terminal-extension/

EXPOSE 8888
VOLUME /notebooks
WORKDIR /notebooks
ENTRYPOINT ["entrypoint.sh"]
