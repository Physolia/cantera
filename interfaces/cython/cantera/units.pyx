# This file is part of Cantera. See License.txt in the top-level directory or
# at https://cantera.org/license.txt for license and copyright information.

cdef class Units:
    """
    A class for handling C++ units
    """
    def __cinit__(self, name=None, init=True):

        if init and name:
            self.units = CxxUnits(stringify(name))
        elif init:
            self.units = CxxUnits()

    def __repr__(self):
        return f"<Units({pystr(self.units.str())}) at {id(self):0x}>"

    property factor:
        """
        Return the factor for converting from this unit to Cantera's base units.
        """
        def __get__(self):
            return self.units.factor()

    @staticmethod
    cdef copy(CxxUnits other):
        """Copy a C++ Units object to a Python object."""
        cdef Units units = Units(init=False)
        units.units = CxxUnits(other)
        return units
