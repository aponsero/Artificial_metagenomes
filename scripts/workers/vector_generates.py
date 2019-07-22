#!/usr/bin/env python3

import random
import itertools
import sys, getopt
import argparse
import numpy as np
from sklearn import preprocessing

def get_args():
  parser = argparse.ArgumentParser(description='generates vectors for community simulation')
  parser.add_argument('-f', '--genomes', help='genome file path',
    type=str, metavar='GENOMES', required=True)
  parser.add_argument('-v', '--vector', help='vector list file path',
    type=str, metavar='VECTOR', required=True)
  parser.add_argument('-g', '--groups', help='nb of groups',
    type=int, metavar='GROUPS', required=True)
  parser.add_argument('-m', '--meta', help='nb of metagenomes by groups',
    type=int, metavar='META', required=True)
  parser.add_argument('-o', '--output', help='output directory',
    type=str, metavar='OUTPUT', required=True)

  return parser.parse_args()

def get_meta(vec, nb):

    for x in range(nb):
        list2=list()
        for i in np.nditer(vec):
            print(i, end=' ')
            temp=abs(float(np.random.normal(0, i, 1)))
            list2.append(float(temp))

        vec2 = np.array(list2)
        vec_temp = np.add(vec, vec2)
        vecsum=np.sum(vec_temp)
        norm_vec=vec_temp/vecsum

        if x==0:
            vec_total=norm_vec
            #print(vec_total.shape)
        else :
            vec_total=np.vstack((vec_total, norm_vec)) 
            #print(vec_total.shape)
        
#    vec3_normalized_l1 = preprocessing.normalize(vec_total, norm='l1')

    return vec_total

def get_group(vec):
    list2=list()
    for i in np.nditer(vec):
        #print(i, end=' ')
        temp=abs(float(np.random.normal(1, i, 1)))
        list2.append(float(temp*i))

    group = np.array(list2)
    groupsum=np.sum(group)
    #print(groupsum)
    norm_group=group/groupsum
    #print(np.sum(norm_group))
    return norm_group

def myprint(vec, names, mymeta, outseed):

    for i in range(mymeta):
        temp=(vec[i, :])
        cpt=0
        outfile=outseed+"_meta_"+str(i+1)+".txt"
        fout = open(outfile, 'w')
        for i in np.nditer(temp):
            fout.write(names[cpt]+"\t"+str(float(i))+"\n")
            cpt+=1

def main():
    args = get_args()
    outdir= args.output
    mygenomes= args.genomes
    myabundance=args.vector
    mymeta= args.meta
    mygroup= args.groups
    my_vec = list()
    my_names = list()
    np.set_printoptions(precision=5,suppress=True)

    fin = open(myabundance, "r")
    for x in fin:
        line=x.strip()
        my_vec = line.split(",")
    vec = np.array( my_vec)
    vec=vec.astype(np.float)
    print(vec)

    fin2 = open(mygenomes, "r")
    for x in fin2:
        my_names.append(x.strip())
    names=np.array(my_names)
    print(names) 

    if mygroup==1:
        print("creating one unique group")
        new_vec = get_meta(vec, mymeta) 
        outseed=outdir+"/vec_group_1"
        np.random.shuffle(names)
        myprint(new_vec, names, mymeta, outseed)
 
    else :
        for x in range(mygroup):
            new_group=get_group(vec)
            print(new_group)
            new_vec=get_meta(new_group, mymeta)
            outseed=outdir+"/vec_group_"+str(x+1)
            np.random.shuffle(names)
            myprint(new_vec, names, mymeta, outseed) 


if __name__ == "__main__":main()
