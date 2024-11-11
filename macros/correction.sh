echo "Inside orgcorrection.sh"
#delete correction.dat if it is present
rm -rf correction.dat

dir_path="/home/thakur/geivanalysis/geiv_cornercorner1122"
position="cornercorner1122"
correction_file="${dir_path}/correction_geiv_${position}.dat" #save into this file

echo "correction_file: ${correction_file}"

#rm -rf /home/thakur/mylab/ryanfiles/multisimulation/door-s-0.3-t-0.11-d-1.68/correctiondoor-s-0.3-t-0.11-d-1.68.dat
#echo "cor_file: $cor_file"
#if [ -f "$cor_file" ];then
#  echo "$cor_file exists and removing!"
#  rm -rf $cor_file
#else
#  echo "$cor_file doesnot exist!"
#  echo ""
#fi
  

./correction.py am241
./correction.py pb210
./correction.py ra226

mv correction.dat ${correction_file} 

#./correction.py ba133
#./correction.py co60
#./correction.py cs137
#./correction.py eu152
#./correction.py na22

#cp correction.dat correctionfeb17.dat
