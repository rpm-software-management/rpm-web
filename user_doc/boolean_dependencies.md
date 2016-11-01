---
layout: default
title: Boolean Dependencies
---


## Boolean Dependencies

With rpm-4.13 RPM is able to process boolean expressions in all dependencies (Requires, Recommends, Suggests, Supplements, Enhances, Conflicts). Boolean Expressions are always enclosed with parenthesis. They are build out of "normal" dependencies: either name only or name, comparison and version description.

## Boolean Operators

 * `and` - requires all operands to be fulfilled for the term to be True.
  * `Conflicts: (pkgA and pkgB)`
 * `or` - requires one of the operands to be fulfilled
  * `Requires: (pkgA >= 3.2 or pkgB)`
 * `if` - requires the first operand to be fulfilled if the second is (reverse implication)
  * `Recommends: (myPkg-langCZ if langsupportCZ)`
 * `if else` - same as above but requires the third operand to be fulfilled if the second is not
  * `Requires: (myPkg-backend-mariaDB if mariaDB else sqlite)`

For now there is no `not` operator. If it turns out that the operators above are not sufficient it might be added in the future.

## Nesting 

Operands can be Boolean Expressions themselves. They also need to be surrounded by parenthesis. `and` and `or` operators may be chained together repeating the same operator with only one set of surrounding parenthesis.

Examples:

`Requires: (pkgA or pkgB or pkgC)`

`Requires: (pkgA or (pkgB and pkgC))`

`Supplements: (foo and (lang-support-cz or lang-support-all))`

## Semantics

The Semantic of the dependencies stay unchanged but instead checking for one match all names are checked and the Boolean value of there being a match is then aggregated over the Boolean operators. For a conflict to not prevent an install the result has to be False for everything else it has to be True.

Note that '''Provides''' are not dependencies and '''cannot contain Boolean Expressions'''.

### Cautionary tale about `if`

Note that the `if` operator is also returning a Boolean value. This is close to what the intuitive reading in most cases. E.g:

`Requires: (pkgA if pkgB)` 

is True (and everything is OK) if pkgB is not installed. But if the same term is used where the "default" is False things become complicated:


`Conflicts: (pkgA if pkgB)` 

is a Conflict unless pkgB is installed and pkgA is not. So one might rather want to use

`Conflicts: (pkgA and pkgB)`

 in most cases. The same is true if the `if` operator is nested in `or` terms.

`Requires: ((pkgA if pkgB) or pkgC or pkg)` 

As the `if` term is True if pkgB is not installed this also makes the whole term True. If pkgA only helps if pkgB is installed you should use `and` instead:

`Requires: ((pkgA and pkgB) or pkgC or pkg)` 
