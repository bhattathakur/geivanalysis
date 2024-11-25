#intended to show the efficiency plot of given isotope 

import streamlit as st
from pathlib import Path
import numpy as np
from pdf2image import convert_from_path

plot_root_dir=Path("/home/thakur/lccfiles/efficiency_plots_dir")

if plot_root_dir.is_dir():
    print(f"{plot_root_dir} exists!\n")
else:
    print(f"{plot_root_dir} doesnot exist!\n")

#pdf and png files in the plot_root_dir

files_list=[i for i in plot_root_dir.iterdir()]

am241_files=[i for i in files_list if 'am241' in i.name]
pb210_files=[i for i in files_list if 'pb210' in i.name]
ra226_files=[i for i in files_list if 'ra226' in i.name]

print(f"am241_files_list: {am241_files}")
#print(f"pb210_files: {pb210_files}")
#print(f"ra226_files: {ra226_files}")

#get unique parents, isotopes, and energies
def get_unique_parents_isotopes_energies(isotope_files):
    for c,file in enumerate(isotope_files):
        print(f"{c+1:>5}|{len(isotope_files)}->{file}\n")

#get_unique_parents_isotopes_energies(files_list)
parent_list=np.unique([j.stem.split('_')[1] for j in files_list if j.name.endswith('.png')or j.name.endswith('.pdf')])
print(f"parent_list: {parent_list}")

parent_choice=st.sidebar.selectbox('choose a parent',parent_list)
print(f"you have chosen a parent: {parent_choice}")

#get isotopes for given parent
isotopes_list=np.unique([j.stem.split('_')[2] for j in files_list if parent_choice in j.name.split('_')[1]])
print(f"isotopes_list: {isotopes_list}")
isotope_choice=st.sidebar.selectbox('choose an isotope',isotopes_list)
print(f"you have chosen an isotope: {isotope_choice}")

#get energy for given parent and isotope 
energies_list=np.unique([j.stem.split('_')[3] for j in files_list if parent_choice in j.name.split('_')[1]\
        and isotope_choice in j.name.split('_')[2]])
print(f"energies_list: {energies_list}")
energy_choice=st.sidebar.selectbox('choose an energy',energies_list)
print(f"you have chosen an energy: {energy_choice}")

show_button=st.sidebar.button('show_plot')

if show_button:
    print(f'You have clicked a button')
    file_path=plot_root_dir/f'efficiency_{parent_choice}_{isotope_choice}_{energy_choice}.pdf'
    #print(f'file chosen: {file_path}: {file_path.exists()}')
    #st.text(f'{file_name}:{file_name.exists()}')
    # Display the PDF
    # Convert PDF to images
    image = convert_from_path(file_path, dpi=300)  # Higher DPI for better quality
    st.image(image,width=1200)




