# pynaive
A toy project to demonstrate Python development environment and toolchain.

Set up the [development invironment](https://github.com/ktrushin/ganvigar)
```shell
host> git clone git@github.com:ktrushin/ganvigar.git
host> git clone git@github.com:ktrushin/pynaive.git
host> cd pynaive
host> ../ganvigar/devenv-launch ganvigar/dev.conf
container>
```

Run style checkes, linters and tests
```shell
container> ./tools/full_check.sh
Success: no issues found in 2 source files

--------------------------------------------------------------------
Your code has been rated at 10.00/10 (previous run: 10.00/10, +0.00)

========================= test session starts ==========================
platform linux -- Python 3.8.5, pytest-4.6.9, py-1.8.1, pluggy-0.13.0
rootdir: /pynaive
plugins: flake8-1.0.6
collected 7 items

tests/test_math.py .......                                       [100%]

======================= 7 passed in 0.03 seconds =======================
```

Prepare binary distribution and upload to PyPI
```shell
container> python3 setup.py sdist bdist_wheel
<lots_of_output_here>
container> twine check dist/*
container> twine upload --repository-url https://test.pypi.org/legacy/ dist/*
container> twine upload dist/*
```

## Instanllation
In order to install the project in the editable mode without creating a
binary distribution and uploading it to the PyPI, execute the following:
```shell
$ pip3 install -e /path/to/the/top/dir/of/pynaive/where/setup.py/is/located
```
Install the previously prepared binary distribution from the PyPI:
```shell
$ pip3 install pynaive
```

## Example
The simplest snippet which uses the package:
```
shell> python3
>>> from naive.math import average
>>> average([2.5, 0.0, -1.0, 3.5])
1.25
>>>
```
