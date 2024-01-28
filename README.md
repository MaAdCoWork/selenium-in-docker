# Selenium Pytest tests execution on Docker
Testing with **Selenium** can be tricky some times. Interacting with the DOM might be hard and it's full of undesired
behaviours.

One big problem when it comes to testing with **Selenium** is versioning and environment. Running tests with a specific
version of **Firefox** could work but it won't for another. These tests work on my **Mac** but they don't on this other **Debian**. The Python version I'm using on this host is different to yours.

**Docker** is the king of fixing this kind of problems. I though it could be a good idea to create a scenario where
tests were running faithfully and reliably.

Everything here has be tested on **Elementary OS 5.1.7 Hera** (based on _Ubuntu 18.04_). I've used
**Docker 19.03.12-19.03.13**, **Docker Compose 1.26.1** and **Python 3.8.3-3.9.0**.

[![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)

#### Tests
I've developed a small testing application under `selenium_tests/`. It uses **Pytest** as testing framework.
The tests are developed implementing a page object pattern.
They are run against the web _http://www.automationpractice.pl/index.php_, which seems to be a webpage to use in cases like this.

## Running the tests locally (not recommended)
We are using Docker, so there's no need of running the tests locally. But if you really want it, here it is a how to:

1) Make sure you are on the `selenium_tests/` root.
2) Set a Python virtual environment. Activate it.
   1) _**NOTA PROPIA**_: Se necesita "python 3.11" (en mi caso, usé 3.11.7 en la Dell Latitude 7400). 
3) Install all the dependencies defined on `selenium_tests/requirements.txt` (`pip install -r requirements.txt`).
4) Download the last version of the Geckodriver (we will use Firefox as browser, so we assume you got it install on your system).
Running the following command will work:
`
wget -q "https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz" -O /tmp/geckodriver.tgz && tar zxf /tmp/geckodriver.tgz -C ./selenium_tests/ && rm /tmp/geckodriver.tgz
`
   1) _**NOTA PROPIA**_: Dejar el "geckodriver" dentro de la subcarpeta "selenium_tests". 
5) Finally, simply run: `pytest`
   1) _**NOTA PROPIA**_: Ejecutar `pytest` dentro de la carpeta "selenium_tests".

## Running the tests using containers
#### Deploy the scenario and run all the tests
Funciona con una sola imagen que combina Pyhton + Firefox, pudiendose ejecutar con el siguiente comando:
```
docker build . -t selenium-in-docker_python-front-firefox:v0.1
```

Si se llega a ver que la consola colapsa los pasos una vez realizados, utilizando una tonalidad azul, sin llegar a poder ver los resultaos de cada paso, se debe a que utiliza la alternativa propuesta en https://github.com/moby/buildkit/issues/1837#issuecomment-977135975, que menciona usar el siguiente comando:
```
docker build . -t selenium-in-docker_python-front-firefox:v0.1 --no-cache --progress=plain
```

_**NOTA PROPIA**_: Si al ejecutar el comando varias veces sigue fallando sin importar los cambios, a pesar que los test funcionen localmente,
probar eliminando el contenedor e imagen creada.