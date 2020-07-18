FROM sphinxdoc/sphinx
LABEL maintainer="Ben Cunningham <benjamescunningham@gmail.com>"

RUN python3 -m pip install sphinx-autobuild

WORKDIR /docs
ADD requirements.txt .
RUN pip3 install -r requirements.txt

CMD ["make", "autohtml"]
