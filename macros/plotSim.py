#!/usr/bin/python3
'''
This macro proces the plot for the simulated efficiences of different isotopes
'''


import array
from   matplotlib import pyplot
import numpy
import sys
import os
import time

import ROOT

from   printVal   import printVal

parent = sys.argv[1]
print("\nWorking on simulation data for "+parent+" ...")
#./plotSim.py co60
# Read all entries from data.dat,
# then remove earlier superseeded entries.

position='cornercorner1122'
data_type='sim'
plot_title=f'{parent}({position} {data_type})'
dir_path=f'/home/thakur/geivanalysis/geiv_cornercorner1122'
saveplot=f'{dir_path}/{data_type}_{parent}_geiv_{position}.pdf'
f=f'{dir_path}/{data_type}_geiv_{position}.dat'
#pdf_save='/home/thakur/mylab/ryanfiles/geiv_'+position+'_data/'
#f=f'{dir_path}/simgeiv_{position}.dat'
#data_file="final_"+position+"_data.dat"
print("data file ",f)
if os.path.isfile(f):
   print(f'{f} exists!\nprocessing ....')
   time.sleep(5)
else:
   print(f'{f} doesnot exist')
   print('quiting...')
   time.sleep(5)
   sys.exit(1)



data = []
#########################################################
#saveplot="/home/thakur/mylab/ryanfiles/multisimulation/door-s-0.3-t-0.11-d-1.68/" #root for the simulation data and plots
#dataroot='simdoor-s-0.3-t-0.11-d-1.68'
#f=saveplot+dataroot+'.dat'

print("Plot save location:\t",saveplot)
print("Sim  data file:    \t",f)

file = open(f, 'r')
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
        float(words[ 5]) ]) # 4: uncorrelated error (plus)
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
pyplot.autoscale(enable=True)
#pyplot.xlim(0, 2500)
#pyplot.ylim(-2, 5)
pyplot.title(plot_title)

pyplot.savefig(saveplot, bbox_inches='tight')
pyplot.savefig(saveplot.replace('.pdf','.png'), bbox_inches='tight')
print(f"Plot saved as {saveplot}")

#pyplot.savefig(saveplot+dataroot+parent+'.pdf', bbox_inches='tight')
#print("\nPlot saved: "+saveplot+dataroot+parent+'.pdf')
