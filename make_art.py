import skimage.io as io
import skimage.transform as tm
import numpy as np
import matplotlib.pyplot as plt

def main():
    # image = io.imread('bulbasaur.png',as_gray=True)
    image = io.imread('bulbasaur.png',as_gray=False)
    # image = tm.rescale(image,0.5,anti_aliasing=False,channel_axis=2)
    rows,columns,channels = image.shape
    image = tm.resize(image,(int(rows/2),int(columns/2),channels),anti_aliasing=False,preserve_range=True)
    image = np.repeat(image,2,1)
    print(image.shape)
    image = image.astype(np.uint8)
    rows,columns,channels = image.shape
    string_matrix = np.full((rows,columns),fill_value=' ',dtype=str)
    print(image[:,:,3].max())
    string_matrix[image[:,:,3]==255]='█'
    # string_matrix[image!=1]='█'
    # # string_matrix[image==0]='█'
    for i in range(rows):
        print('')
        for j in range(columns):
            # print(string_matrix[i,j],end='')
            r,g,b=image[i,j,:3]
            color_escape = get_color_escape(r,g,b,background=False)
            print(f'{color_escape}{string_matrix[i,j]}',end='')
    # plt.imshow(image,cmap='gray')
    # plt.imshow(image)
    # plt.show()

def get_color_escape(r, g, b, background=False):
    return '\033[{};2;{};{};{}m'.format(48 if background else 38, r, g, b)

if __name__=='__main__':
    main()
