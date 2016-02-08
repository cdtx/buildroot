#! /usr/bin/env python

import os

with open('output/target/lib/modules/3.13.5/modules.dep', 'r') as org:
    with open('output/target/lib/modules/3.13.5/new.dep', 'w') as new:
        for line in org:
            new.write(' '.join([x for x in line.split() if not 'mii' in x]) + '\n')


os.rename('output/target/lib/modules/3.13.5/modules.dep', 'output/target/lib/modules/3.13.5/modules.dep.bak')
os.rename('output/target/lib/modules/3.13.5/new.dep', 'output/target/lib/modules/3.13.5/modules.dep')

