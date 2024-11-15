#libraries
import os
import sys

desintation_folder='/home/thakur/lccfiles/cornercorner1122_25M/'

position='cornercorner'
sim_value='25M'
label_format=f'{position}_{sim_value}'
run_command=True

print(f'label_format: {label_format}')

#check if destination dir exists quit otherwise

if os.path.isdir(desintation_folder):
    print(f'{desintation_folder} exists ! ... proceeding !!')

else:
    print(f'{desintation_folder} does not exist ! ... exiting !!')
    sys.exit(1)

isotopes=['am241','pb210','ra226']
print(f'isotopes: {isotopes}')


#move the files

#gdf files associates with isotpes

all_files=os.listdir('.')
print(f'all_files: {all_files}')
gdf_files=[i for i in all_files if i.endswith('.gdf') and any(j in i for j in isotopes)]
bgrate_data_files=[i for i in all_files if i.endswith('.dat') and 'bgrates' in i and any(j in i for j in isotopes)]

print()

print(f'bgrate_data_files: {bgrate_data_files}')

for f in bgrate_data_files:
    new_file_path=os.path.join(desintation_folder,f)
    copy_command=f'cp -v {f} {new_file_path}' 
    print(f'Debug: copy_command: {copy_command}')
    if run_command:os.system(copy_command)


for gf in gdf_files:
    gf_parts=gf.split('.')
    iso=gf_parts[0]
    sim='' if 'sim' in iso else 'data'
    new_gf_name=f'{iso}{sim}_{label_format}.gdf'
    #print(f'new_gf_name: {new_gf_name}')
    new_file_path=os.path.join(desintation_folder,new_gf_name)
    copy_gdf_command=f'cp -v {gf} {new_file_path}' 
    print(f'Debug: copy_gdf_command: {copy_gdf_command}')
    if run_command:os.system(copy_gdf_command)
    #print(f'new_file_path: {new_file_path}')



#print(f'gdf_files: {gdf_files}')
