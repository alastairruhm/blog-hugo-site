+++
title = "pycodestyle 备忘"
date = "2016-09-05"
tags = ["Python"]
+++

## 基本情况 

* 项目文档：[pycodestyle’s documentation — pycodestyle 2.1.0.dev0 documentation](https://pycodestyle.readthedocs.io/en/latest/)
* 项目地址：[PyCQA/pycodestyle: Simple Python style checker in one Python file](https://github.com/PyCQA/pycodestyle)

## 使用中遇到的问题

对于文档中，[项目级别的配置](https://pycodestyle.readthedocs.io/en/latest/intro.html#configuration)提到在 `tox.ini` 文件中加入`[pycodestyle]` 区域配置，但是在实际使用时，写入了配置文件但没有效果，查看了pycodestyle 的帮助文档，

```
> pycodestyle -h
Usage: pep8 [options] input ...

Options:
  --version            show program's version number and exit
  -h, --help           show this help message and exit
  -v, --verbose        print status messages, or debug with -vv
  -q, --quiet          report only file names, or nothing with -qq
  -r, --repeat         (obsolete) show all occurrences of the same error
  --first              show first occurrence of each error
  --exclude=patterns   exclude files or directories which match these comma
                       separated patterns (default:
                       .svn,CVS,.bzr,.hg,.git,__pycache__,.tox)
  --filename=patterns  when parsing directories, only check filenames matching
                       these comma separated patterns (default: *.py)
  --select=errors      select errors and warnings (e.g. E,W6)
  --ignore=errors      skip errors and warnings (e.g. E4,W) (default:
                       E121,E123,E126,E226,E24,E704,W503)
  --show-source        show source code for each error
  --show-pep8          show text of PEP 8 for each error (implies --first)
  --statistics         count errors and warnings
  --count              print total number of errors and warnings to standard
                       error and set exit code to 1 if total is not null
  --max-line-length=n  set maximum allowed line length (default: 79)
  --hang-closing       hang closing bracket instead of matching indentation of
                       opening bracket's line
  --format=format      set the error format [default|pylint|<custom>]
  --diff               report changes only within line number ranges in the
                       unified diff received on STDIN

  Testing Options:
    --benchmark        measure processing speed

  Configuration:
    The project options are read from the [pep8] section of the tox.ini
    file or the setup.cfg file located in any parent folder of the path(s)
    being processed.  Allowed options are: exclude, filename, select,
    ignore, max-line-length, hang-closing, count, format, quiet, show-
    pep8, show-source, statistics, verbose.

    --config=path      user config file location
```

按照文档要求的增加了 `[pep8]` 配置后即可。


