# docker-graphics

[![Docker Repository on Quay](https://quay.io/repository/ukhomeofficedigital/docker-graphics/status "Docker Repository on Quay")](https://quay.io/repository/ukhomeofficedigital/docker-graphics)
[![Build Status](https://drone.digital.homeoffice.gov.uk/api/badges/UKHomeOffice/docker-graphics/status.svg)](https://drone.digital.homeoffice.gov.uk/UKHomeOffice/docker-graphics)

## What is this software and what does it do
The software in this image is used to generate png files from graphviz dot files and from plantuml puml files.

The graphviz files and plantuml files can be used to create:
- logical infrastructure diagrams
- application sequence diagrams
- application environment progression diagrams
- any other type of diagrams ...

It will make it easier to create/update/maintain diagrams in git repos.

## How to use the software
Teams are meant to have a docs git repo with graphics source files ( dot and/or plantuml files ).

This container comes with all necessary software so that people can generate `png` files out of the source files on laptops/workstations/ci without having to install any software.

## Release process
The release process is done using drone, have a look at `.drone.yml`

## Local iteration cycle
This paragraph should contain some links to actual repositories using this container for accurate docker commands.

This container comes with a local, non-priviledged user, called `graphics`, which has its `$HOME` set to `/home/graphics`. This user can't write to any other location, make sure your source files are bind mounted in `/home/graphics`.

The use of a `Makefile` make it so that local development and iteration cycles on this container look and behave exactly like they would inside drone. The local devel and iteration cycles will mirror the drone cycle up to the point when the container has to be pushed to a container registry.

Simply run `make` to see the list of supported make targets.

The following docker commands are presented as an example and are not 100% accurate since your git repo layout might be slightly different.

If a teams' docs git repo has this layout:
```
.
├── docs
├── graphicsrc
│   ├── dot
│   │   └── img
│   └── plantuml
├── graphictarget
├── README.md
└── util
```

Therefore to generate `png` files out of `dot` source files using the graphics container one needs to run:
```
docker run \
  --rm \
  -ti \
  -v $PWD/graphicsrc/dot:/home/graphics/dot \
  -v $PWD/graphictarget:/home/graphics/graphictarget \
  docker-graphics \
  <dot_command_from_dotfile_to_png>
```

Therefore to generate `png` files out of `puml` plantuml source files using the graphics container one needs to run:
```
docker run \
  --rm \
  -ti \
  -v $PWD/graphicsrc/plantuml:/home/graphics/plantuml \
  -v $PWD/graphictarget:/home/graphics/graphictarget \
  docker-graphics \
  <plantuml_command_from_puml_to_png>
```

# Raising issues
Use the github issue functionality on this repository to raise issues against this project.
