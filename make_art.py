import skimage.io as io
import numpy as np
# import matplotlib.pyplot as plt

def main():
    # pokemon_list = ['mimikyu','pawniard','unown','pikachu']
    with open('./scrape/nameslist.txt','r') as names_file:
        pokemon_list = names_file.readlines()
        for pokemon in pokemon_list:
            pokemon=pokemon.strip()
            try:
                pokemon_art=get_pokemon_art(pokemon)
            except Exception as e:
                # raise Exception()
                print(f"couldn't generate art for {pokemon}")
                print(e)
                continue
            # print(pokemon_art)
            write_pokemon_to_file(pokemon,pokemon_art)
            # break

def write_pokemon_to_file(pokemon,pokemon_art):
    with open(f'./pokeart/{pokemon}.txt','w') as file:
        file.write(pokemon_art)

def get_pokemon_art(pokemon):
    """ Takes the name of a pokemon and prints out its art"""

    # string to hold the color formatted string
    pokemon_art=''

    # loading in image
    path = f'./images/{pokemon}.png'
    original_image = io.imread(path)
    image_cropped = crop_image_to_content(original_image)
    # doubling on the width axis as characters are not as wide as they are high
    image = np.repeat(image_cropped,2,1)
    image = image.astype(np.uint8)
    rows,columns,_ = image.shape

    # creating matrix for storing the unicode glyphs
    string_matrix = np.full((rows,columns),fill_value=' ',dtype=str)
    # set all non transparent pixels to the block glyph
    string_matrix[image[:,:,3]==255]='█'

    # print out the image with appropriate colors
    for i in range(rows):
        pokemon_art+='\n'
        old_color=None
        for j in range(columns):
            r,g,b=image[i,j,:3]
            new_color = get_color_escape(r,g,b,background=False)
            if new_color==old_color:
                color_escape=''
            else:
                color_escape=new_color
                old_color=new_color

            pokemon_art+=f'{color_escape}{string_matrix[i,j]}'
    pokemon_art+='\033[0m\n'
    return pokemon_art


def crop_image_to_content(image):
    """Crops the image so that all non essential space is removed"""

    # Finding coordinates for a bounding box of the content
    alpha_channel = image[:,:,3]
    min_x,min_y = find_top_left(alpha_channel)
    cropped_half=image[min_y:,min_x:,:]

    #flip image and perform the same action to crop other corner
    flipped_image = np.flip(cropped_half,(0,1))
    max_x,max_y = find_top_left(flipped_image[:,:,3])
    full_cropped_flipped = flipped_image[max_y:,max_x:,:]

    #flip back to restore original orientation
    cropped_image = np.flip(full_cropped_flipped,(0,1))

    return cropped_image

def find_top_left(alpha_channel):
    """Finds top left corner of bounding box to crop to content and returns
       coordinates of top left"""
    # first non alpha values on each column and row. argmax works as only 0,255
    # values are present
    min_values_x = alpha_channel.argmax(axis=1)
    min_values_y = alpha_channel.argmax(axis=0)
    # top left corner of bounding box
    min_x = np.min(min_values_x[min_values_x!=0])
    min_y = np.min(min_values_y[min_values_y!=0])

    return min_x,min_y

def get_color_escape(r, g, b, background=False):
    """ Given rgb values give the escape sequence for printing out the color"""
    return '\033[{};2;{};{};{}m'.format(48 if background else 38, r, g, b)

if __name__=='__main__':
    main()
