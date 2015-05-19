---
layout: default
title: Problems of integration
---
One level up: [Contribute](../contribute.html)

# Problems of integration

In modern systems with complicated dependency chains, RPM cannot be used as is. Higher level tools provide dependency evaluation and RPM provides installation service. RPM was not designed for this concept of work and programmers of higher level tools have to work-around RPM in some way.

## Transaction x download

RPM supports donwload on its own. If the update is done by a high level tool, downloading by this tool may be preferred (prograss bar, protocol unknown to RPM).

Why:
: To install packages in large transaction means in this case: download everything, then add everything to command line. It is not possible due to potentially limited disk space.

Work-arounds:
: * Need extra place, up to 100% of installed size. 
  * Download per package by high level tool, the install per package using --nodeps --force. This work-around causes short breakages, when functionallity depends on transaction completion. (i. e. libraries are upgraded, removing files of the old instance should be done after upgrading of all packages using the old instance) 

## Database duplication

Upper level tools need to store dependencies and additional information in its custom database.

Why:
: Requires/Provides information has to be stored in two independent databases. The higher level tool database has to be rebuilt whenever the tool detect change done by rpm alone.

Work-arounds:
: * Dependency database is stored twice. 
  * When higher level tool starts, it scans RPM database and rebuilds its own database to make both consistent. 

Proposed solution:
: Design a way to share these databases as much as possible, either by defining back-end API for RPM database or by defining a way, how front-end can store additional information to existing database.

## Solver weakness
RPM provides no simple way to access the dependence solver.

Examples:
: Try to define: "This package have to conflict with all other packages providing symbol foo" Impossible on RPM level, but may be required for higher level tool.

Why:
: Solver of RPM is powerful enough to detect requirement or some conflicts, but weak enough to be able to propose a solution. It forces most users to higher level solutions. These solutions have its own solver.

Work-arounds:
: Higher level solution use --nodeps --force and its solver has to be bug-compatible with RPM.

Proposed solution:
: RPM could be able to delegate conflict evaluation to the higher level tool.



