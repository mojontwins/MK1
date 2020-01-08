from PIL import Image
from sys import argv

def main (inputfn, outputfn):
	in_img = Image.open (inputfn)
	out_img = Image.new ("RGB", (256, 64), "white")
	copy_img = Image.new ("RGB", (16, 8), "white")
	# Procesar 8asta 64 tiles
	x0, y0, x1, y1 = (0, 0, 0, 0)
	for i in range (0, 64):	
		# Copiamos la parte superior del tile
		box = (x0, y0, x0 + 16, y0 + 8)
		copy_img = in_img.crop (box)
		coord = (x1, y1)
		out_img.paste (copy_img, coord)
		# Copiamos la parte inferior del tile
		box = (x0, y0 + 8, x0 + 16, y0 + 8 + 8)
		copy_img = in_img.crop (box)
		coord = (x1 + 16, y1)
		out_img.paste (copy_img, coord)
		# Actualizamos las coordenadas
		x0 = x0 + 16
		if x0 == 256:
			x0 = 0
			y0 = y0 + 16
		x1 = x1 + 32
		if x1 == 256:
			x1 = 0
			y1 = y1 + 8
	out_img.save(outputfn, 'PNG')
		
if __name__ == '__main__':
	if len(argv) == 3:
		main(argv [1], argv [2])
	else:
		print "Modo de uso:\n reordenator.py in.png out.png"
