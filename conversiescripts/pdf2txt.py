#from pptx import Presentation
import pdfplumber
import sys
import os
import re

startdir=sys.argv[1]

def read_full_pdf(pdf):
    text=''
    for page in pdf.pages:
        text+=page.extract_text()
    return text

def process_files(files,root):
    for f in files:
        print('Processsing', root+'/'+f,file=sys.stderr)
        if re.search('pdf$',f):
            outfilename=f+'.txt'
            if os.path.isfile(root+'/'+outfilename):
                pass
            else:
                outfile = open(root+'/'+outfilename,'w') 
                with pdfplumber.open(root+'/'+f) as pdf:
                    text=read_full_pdf(pdf)
                    print(text,file=outfile)


for root,subFolders,files in os.walk(startdir):
    process_files(files,root)
    

