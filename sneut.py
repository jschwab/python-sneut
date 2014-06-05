from . import fsneut
import numpy as np

NAMES = ("pair", "plas", "phot", "brem", "recomb", "snu", "dsnudt", "dsnudd", "dsnuda", "dsnudz")

class SneutOutput:

    def __init__(self, output, size, shape):

        # set size and shape data
        self.size = size
        self.shape = shape

        # loop through and nicely reformat everything
        for name, data in zip(NAMES, output):
            setattr(self, name, self._reshape(data))

    def _reshape(self, data):
        # put things back like they came in
        return np.reshape(data[:self.size], self.shape)


def _make_uniform_arrays(inputs):

    # make numpy arrays out of everthing
    arrays = [np.array(array) for array in inputs]

    # set size & shape to 1st non-scalar input
    size = 1
    shape = (1,)
    for array in arrays:
        if array.size != 1:
            size  = array.size
            shape = array.shape
            break

    outputs = []
    for array in arrays:
        if array.size  == 1:
            outputs.append(np.tile(array.flatten(), size))
        else:
            outputs.append(array.flatten())

    return size, shape, outputs


def sneut(dens, temp, abar, zbar):

    # make sure everything is the same size and shape
    inputs = (dens, temp, abar, zbar)
    size, shape, finputs = _make_uniform_arrays(inputs)

    # call the eos
    output = fsneut.call_sneut(*finputs)

    # container for output
    return SneutOutput(output, size, shape)
