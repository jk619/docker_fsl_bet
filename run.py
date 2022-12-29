#!/usr/bin/env python
import os
import sys
import glob
sourcestr = ". /usr/local/fsl/etc/fslconf/fsl.sh;"
filesforbet = glob.glob("/input/*.gz")

for f in filesforbet:

	f_out = os.path.split(f[:-7] + '_bet')
	
	os.system(sourcestr + "bet " + f + " /output/" + f_out[1])

