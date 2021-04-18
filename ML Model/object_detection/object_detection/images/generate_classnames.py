import os
import pickle
import json


def copyFiles(file_name, ext, dest_folder):
    global classnames_set
    file_txt = open(file_name, 'r')
    file_txt_lines = file_txt.readlines()

    count = 0
    for line in file_txt_lines:
        count += 1
        print('File Name{}: {}'.format(count, line.strip()))
        split_string = line.strip().split("0", 1)
        substring = split_string[0]
        classnames_set.add(substring)


classnames_set = {"coin"}
copyFiles('train.txt', '.xml', './train/')
classnames_list = list(classnames_set)
print(classnames_set)

with open('class-names.txt', 'w') as filehandle:
    filehandle.writelines("%s\n" % classname for classname in classnames_list)
