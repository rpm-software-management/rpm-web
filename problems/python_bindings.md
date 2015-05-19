---
layout: default
title: Problems of python bindings
---
One level up: [Contribute](../contribute.html)

# Problems of python bindings

The Python bindings have a number of known weaknesses. Due to the small number of users and to maintain compatibility their development has been relatively slow. Python API user should state as precise as possible what changes or additions they want to seen. Either create a new section on this page or open a ticket and link it here (if you have write access).

## Documentation

The Python bindings are basically without docs. This is especially annoying as most classes are not meant to be instantiated at all.

## Cheap access to NEVRA of installed Packages

Create NEVRA index and a way to iterate over it without loading the headers

## Cheap access to file requires in rpmdb

Add an interface to search for a index key and iterate onwards

Requires #112.

## Transaction callback

There's no way to get exact information about packages being removed, currently only %{name} is passed on removals which isn't sufficient on multilib. The fundamental problem lies deep in the design and requires #183, but it might be possible to create a sub-classable callback object which can at least return the correct header on removal. 
