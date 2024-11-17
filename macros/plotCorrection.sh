#!/bin/bash

dest_path=/home/thakur/geivanalysis/geiv_cornercorner1122/

source='cornercorner1122'
total_simulations='25M'
dest_file=source_correction_${source}_${total_simulations}.dat

dest_arg=${dest_path}${dest_file}

echo 'saving into: '${dest_arg}


python3 plotCorrection.py am241
python3 plotCorrection.py pb210
python3 plotCorrection.py ra226

mv -v source_correction.dat ${dest_arg}

#python3 plotCorrection.py ba133
#python3 plotCorrection.py co60
#python3 plotCorrection.py cs137
#python3 plotCorrection.py eu152
#python3 plotCorrection.py na22
