import shutil
import os


def copyFiles(file_name, ext, dest_folder):
    file_txt = open(file_name, 'r')
    file_txt_lines = file_txt.readlines()

    count = 0
    for line in file_txt_lines:
        count += 1
        print('File Name{}: {}'.format(count, line.strip()))
        shutil.copy(line.strip() + ext, dest_folder)


copyFiles('test.txt', '.xml', './test/')
copyFiles('train.txt', '.xml', './train/')
copyFiles('trainval.txt', '.xml', './trainval/')
copyFiles('val.txt', '.xml', './val/')
