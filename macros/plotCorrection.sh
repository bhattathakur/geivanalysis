#!/bin/bash
rm -vrf /home/thakur/mylab/ryanfiles/multisimulation/door-s-0.3-t-0.11-d-1.68/sourceCorrectiondoor-s-0.3-t-0.11-d-1.68.dat

python3 plotCorrection.py am241
#python3 plotCorrection.py ba133
#python3 plotCorrection.py co60
#python3 plotCorrection.py cs137
#python3 plotCorrection.py eu152
#python3 plotCorrection.py na22
python3 plotCorrection.py pb210
#python3 plotCorrection.py ra226
