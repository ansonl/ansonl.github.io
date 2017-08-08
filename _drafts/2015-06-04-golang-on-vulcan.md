---
layout: post
title:  "Go on Vulcan"
date:   2015-06-04 12:00:00
categories: vulcan good
draft: true
---
Vulcan is a Blue Gene/Q system located at Lawerence Livermore National Lab in California. The processor architecture is IBM Power7 and PowerPC A2 cores. There are 3.7 GHz Power7 cores located on login nodes and 1.6 GHz PowerPC A2 cores on compute nodes. http://computation.llnl.gov/computers/vulcan

We cannot simply download and build the `gc` Go compiler from [source](http://golang.org/doc/install/source) because the `gc` compiler and related tools do not support the Power Architecture that Vulcan is based upon. 
It would be nice to just run `./all.bash` though - that is all I would need on a supported architecture...

Go can also be compiled by using gccgo, a new frontend for GNU GCC. The Go page on [setting up gccgo](http://golang.org/doc/install/gccgo) does a good job on describing what needs to be done to use gccgo.

- We must build gcc with support for the Go language. Get gccgo.

```
svn checkout svn://gcc.gnu.org/svn/gcc/branches/gccgo gccgo
cd gccgo
```

- Download gccgo prerequisite libraries. Steps that are not obvious from the [Installing GCC](https://gcc.gnu.org/install/) page that are explained on the [FAQ](https://gcc.gnu.org/wiki/FAQ#configure) and [here](http://advogato.org/person/redi/diary/240.html):
  - You do not need to download the GMP, MPFR, MPC, etc libraries individually and specify them as `./configure` options. GCC provides a `download_prerequisites` script that may be able to do this for you. 
  - Create a new directory outside of the GCC source directory to `./configure` and `make` GCC within. 
  - `make` will take a long time to complete due to the amount of recipes in GCC. Using `-j` option on multiple cores may lower the compile time. Compiling on compute nodes allows use of more cores but this could not be done as most installed executables on Vulcan were compiled for use on the login nodes (Power7 only). GNU make and bash were among the tools that I unsuccessfully tried to build from scratch and run. 

```
./contrib/download_prerequisites
cd ../
mkdir objdir
cd objdir
../gccgo/configure --prefix=$HOME/opt/gccgo --enable-languages=c,c++,go
make -j 15
make install
```

- Add the just installed gccgo to $PATH environment variable so that the shell can find it. 

```
export $PATH=$HOME/opt/gccgo/bin
export $GOPATH=$HOME/workspace/go/
export $LD_LIBRARY_PATH=$HOME/opt/multi-gccgo/lib64
export $PORT=8080
```

We are going to download and parse Congress federal lobbyist records with my https://github.com/ansonl/lobbyist-lookup/ to test out the install.

First we must get the necessary imports for this project and download the project itself from github. 
```
go get golang.org/x/net/html
go get code.google.com/p/go-charset/charset
https://github.com/ansonl/lobbyist-lookup/
```

Now we can build and run it. 

```
cd $GOPATH/src/github.com/ansonl/lobbyist-lookup
go build
export $GOMAXPROCS=15
./lobbyist-lookup
```


Code.google.com may use Mercurial as source control so you may need to install it yourself beforehand. I also had to install mercurial locally because Vulcan did not have it preinstalled. 

Observations: Google Chrome keeps its own DNS cache apart from the OS so in order to view updated DNS records' effects you must either use incognito mode or clear the cache in settings.  