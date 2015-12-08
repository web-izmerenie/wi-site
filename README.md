wi-site
=======

How to deploy
-------------

1. Clone this repo;

2. Install git submodules:

  ```bash
  $ git submodule update --init
  ```

3. Install dependencies:

  ```bash
  $ npm install
  ```

  It will automatically run `./deploy.sh` after install
  and build front-end stuff (styles, scripts) by `front-end-gulp` tool.
  See more about `front-end-gulp` tool for building front-end:
  [front-end-gulp-pattern](https://github.com/unclechu/front-end-gulp-pattern)
  or just run: `./front-end-gulp help` to show available tasks.
  Use `--production` flag for minification styles and scripts
  (deploy script uses it by default).

Info for developers
-------------------

* Logic written on [LiveScript](http://livescript.net)
  with [prelude.ls](http://preludels.com) library.
* Styles written on [Stylus](https://learnboost.github.io/stylus/)
  with [nib](http://tj.github.io/nib/) library
  (<b>nib</b> automatically creates browser prefixes).
