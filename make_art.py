import skimage.io as io
import skimage.transform as tm
import numpy as np
import matplotlib.pyplot as plt

def main():
    # image = io.imread('bulbasaur.png',as_gray=True)
    image = io.imread('bulbasaur.png',as_gray=True)
    image = tm.rescale(image,0.5,anti_aliasing=False)
    image = np.repeat(image,2,1)
    string_matrix = np.full(image.shape,fill_value=' ',dtype=str)
    rows,columns = string_matrix.shape
    # string_matrix[image!=1]='@'
    string_matrix[image!=1]='█'
    # string_matrix[image==0]='█'
    for i in range(rows):
        print('')
        for j in range(columns):
            color=int(image[i,j]*255)
            color_escape = get_color_escape(color,color,color,background=False)
            print(f'{color_escape}{string_matrix[i,j]}',end='')
    # plt.imshow(image,cmap='gray')
    # plt.show()

def get_color_escape(r, g, b, background=False):
    return '\033[{};2;{};{};{}m'.format(48 if background else 38, r, g, b)

if __name__=='__main__':
    main()
