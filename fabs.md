# An floating point absolute value implementation: fabs(x)

A floating point absolute value implementation that runs faster than the macro implentation on a DSP:

    double x;
    *(((int *) &x) + 1) &= 0x7fffffff;

Depending on the number of calls the function can/should be defined inline.
