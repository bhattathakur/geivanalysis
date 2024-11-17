#!/usr/bin/python3
'''
This macro produces the plot for the data efficiencies of different isotopes from GeIV
'''
import array
from   matplotlib import pyplot
import numpy
import sys
import time
import os

import ROOT

from   printVal   import printVal

parent = sys.argv[1]
print("working for data for "+parent+" ...")
#./plotData.py co60
# Read all entries from data.dat,
# then remove earlier superseeded entries.

position='cornercorner1122'
total_simulations='25M'
dir_path=f'/home/thakur/geivanalysis/geiv_cornercorner1122'
pdf_save=f'{dir_path}/data_{parent}_geiv_{position}_{total_simulations}.pdf'
data_file=f'{dir_path}/data_geiv_{position}_{total_simulations}.dat'
#pdf_save='/home/thakur/mylab/ryanfiles/geiv_'+position+'_data/'
#data_file=f'{dir_path}/datageiv_{position}.dat'
#data_file="final_"+position+"_data.dat"
print("data file ",data_file)
if os.path.isfile(data_file):
    print(f'{data_file} exists!\nprocessing ....\n')
    time.sleep(5)
else:
    print(f'{data_file} doesnot exist')
    print('quiting...\n')
    time.sleep(5)
    sys.exit(1)



data = []
file = open(data_file, 'r')
for line in file:
    words = line.split()
    if words[0] != parent:
        continue
    data.append([
        [ words[0],         # 0: parent
          words[1] ],       # 0: isotope
        float(words[ 2]),   # 1: energy
        float(words[ 3]),   # 2: efficiency
        float(words[ 4]),   # 3: uncorrelated error (minus)
        float(words[ 5]),   # 4: uncorrelated error (plus)
        float(words[ 8]),   # 5: total activity error (minus)
        float(words[ 9]) ]) # 6: total activity error (plus)
for entry in reversed(range(len(data))):
    for e in range(entry):
        # If this entry's isotope and energy match a later one, then remove it.
        if data[e][0] == data[entry][0] and data[e][1] == data[entry][1]:
            data.remove(data[e])
            break

# Separate the different daughter isotopes.
iso = [[]]
for d in data:
    if len(iso[0]) == 0:
        iso[0].append(d)
        continue
    for t in iso:
        if t[0][0][1] == d[0][1]:
            t.append(d)
            break
    else:
        iso.append([])
        iso[-1].append(d)

isotopes = [] # names of daughter isotopes
for i in iso:
    isotopes.append(i[0][0][1])

# Plot, separately, each isotope of this parent.
for i in range(len(iso)):
    for entry in range(len(iso[i])):
        iso[i][entry] = [0] + iso[i][entry][1:] # remove non-floats (isotope names)
    data = numpy.array(iso[i])
    pyplot.errorbar(data[:,1], 100*data[:,2], yerr=[100*data[:,3], 100*data[:,4]], fmt='.' )

pyplot.xlabel('Energy/keV')
pyplot.ylabel('Efficiency/%')
pyplot.xlim(0, 2500)
#pyplot.ylim(0,    1)
pyplot.autoscale(axis='y')
pyplot.title(parent+"("+position+" data)")


#pyplot.savefig(pdf_save+'('+position+')-data'+parent+'.pdf', bbox_inches='tight')
pyplot.savefig(pdf_save, bbox_inches='tight')
pyplot.savefig(pdf_save.replace('.pdf','.png'), bbox_inches='tight')
print("\nFinal data efficiency plots saved as: {}".format(pdf_save))
