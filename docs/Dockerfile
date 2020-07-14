FROM sphinxdoc/sphinx
LABEL maintainer="Ben Cunningham <benjamescunningham@gmail.com>"

WORKDIR /docs
ADD requirements.txt .
RUN pip3 install -r requirements.txt

CMD ["make", "html"]
