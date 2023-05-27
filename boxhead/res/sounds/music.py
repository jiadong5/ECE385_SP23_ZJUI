## This code generate a txt version file for a wav music file
## Which can be used for the FPGA audio module
## Author: Ge Yuhao
## Cited and modified by Jiadong Hong (23/05/16)

import numpy as np
import wave

name = wave.input('Please type in the wave name:')
addr_r = './original_sound/'+name+'.wav'
music = wave.open(addr_r, 'r')
signal = music.readframes(-1)
soundwave = np.frombuffer(signal, dtype="uint16")
addr_w = './txt_sound/' + name+'.txt'
with open(addr_w,"w") as f:
    for i in soundwave:
        f.write('{:04X}'.format(i))
        f.write("\n")
print(addr_w,' writing completed!')