#!/usr/bin/env python3

#
# Consider these two function definitions in Python.  They include
# purpose statements and unit tests using one of the several unit
# test frameworks Python provides.
#

def sum(lon):
    """produce sum of elements of list
    
    >>> sum([1, 2, 3]) 
    6
    """
    
    result = 0
    for n in lon:
        result = result+ n
    return result


      
def rev(lon):
    """produce list with elements in reverse order
    
    >>> rev([1, 2, 3])
    [3, 2, 1]
    """
    
    result = []
    for n in lon:
        result = [n] + result
    return result



#
# Given the two function definitions above, use abstraction to
# figure out the template for a function that goes through a list
# with one accumulator.
#




#
# Use that template to complete the body of the average function
# below. Note that we already have a purpose as well as 2 unit
# tests for average.
#

def average(lon):
    """Produce average of numbers in list. List MUST HAVE at least
    one element.

    >>> average([1, 2, 3])
    2

    >>> average([5, 3, 4])
    4
    """
    return 0



#
# this makes the tests run
#
if __name__ == "__main__":
    import doctest
    doctest.testmod()
