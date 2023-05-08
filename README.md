The purpose of this repository is to supply an implementation of most
of the operators in the Conses dictionary of the Common Lisp standard.

We value performance, but we value correctness and maintainability
even more.  We do not think it is important to optimize the
implementation of an operator that is not used very often.  While we
do not know a priori how often an operator might be used, we think
that an application that uses an operator very often, and where our
implementation of that operator does not have the best performance,
the application writer is very likely to implement a special version
anyway that takes into account the specific needs of that application.
