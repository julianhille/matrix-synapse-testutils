# matrix-synapse-testutils
Base testutils of matrix synapse

This project includes the test utils from [matrix-synapse](https://github.com/matrix-org/synapse)
to make them reusable in other projects.

There are some very good basic unittest classes to test
routes and plugins, but one is unable to import them, because
 - the files are in a module called 'test'
 - the imports are absolute
 - the test module is included in the sdist but not after installation


# Sample usage

```python
from matrix_synapse_testutils.unittest import HomeserverTestCase
```
# Versioning

The version of this module always fits the version of its
respective synapse version.

Synapse version `1.70.0` leads to a version of matrix_synapse_testutils of
`1.70.0.N`.
N is a numeric revision number for matrix_synapse_testutils
starting at 1 for every release of synapse, just like you would expect.

## Examples

1.70.0.0
This means it is the first release of `matrix_synapse_testutils` for synapse 1.70.0

1.70.0.1
This means it is the second release of `matrix_synapse_testutils` for synapse 1.70.0

1.71.1.0
This means it is the first release of `matrix_synapse_testutils` for synapse 1.71.1

# Scripts

Under `bin/` is a shell script which does most of the work of updating the
utilities from synapse.
It downloads, unpacks, syncs and tries to patch the files from synapse.
This is far from perfect and might needs manual adaption.