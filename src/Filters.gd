extends Object

class_name Filters


static func generate_grayscale(image):
	var width = image.get_width()
	var height = image.get_height()
	var grayscale = Image.new()
	grayscale.create(width, height, false, Image.FORMAT_L8)
	for y in range(height):
		image.lock()
		for x in range(width):
			grayscale.lock()
			var color = image.get_pixel(x, y)
			# Convert the pixel to grayscale using the formula: 0.2989 * R + 0.5870 * G + 0.1140 * B
			var value = float(0.2989 * color.r + 0.5870 * color.g + 0.1140 * color.b)
			
			grayscale.set_pixel(x, y, Color(value, value, value, color.a))
			grayscale.unlock()
		image.unlock()
	return grayscale
	
static func gaussian_blur_1d(pixels, size, sigma, direction):
	# Calculate the size of the kernel based on sigma
#	var kernel_size = int(2 * ceil(sigma) + 1)
	var kernel_size = 7

	# Initialize the kernel array
	var kernel = []
	for i in range(kernel_size):
		kernel.append(0)

	# Calculate the values of the Gaussian function
	# for each position in the kernel
	var sum = 0
	for i in range(kernel_size):
		var x = i - (kernel_size - 1) / 2
		kernel[i] = exp(-0.5 * x * x / sigma / sigma)
		sum += kernel[i]

	# Normalize the kernel so that its values sum to 1
	for i in range(kernel_size):
		kernel[i] /= sum

	# Initialize the result array
	var result = []
	for i in range(len(pixels)):
		result.append(0)

	# Perform the 1-dimensional Gaussian blur in the chosen direction
	if direction == "horizontal":
		for y in range(size.y):
			for x in range(size.x):
				var sum_r = 0
				for i in range(kernel_size):
					var px = x + i - (kernel_size - 1) / 2
					if px >= 0 and px < size.x:
						var py = y
						sum_r += pixels[px + py * size.x] * kernel[i]
				result[x + y * size.x] = sum_r
	elif direction == "vertical":
		for y in range(size.y):
			for x in range(size.x):
				var sum_r = 0
				for i in range(kernel_size):
					var py = y + i - (kernel_size - 1) / 2
					if py >= 0 and py < size.y:
						var px = x
						sum_r += pixels[px + py * size.x] * kernel[i]
				result[x + y * size.x] = sum_r
	else:
		print("Error: invalid direction")

	# Return the blurred image
	return result


static func create_histogram(image):
	var image_sizes = image.get_size()
	var histogram = []
	for _i in range(1, 256):
		histogram.append(0)
	image.lock()
	for x in range(image_sizes.x):
		for y in range(image_sizes.y):
			histogram[int(image.get_pixel(x,y).r * 255)] += 1
	image.unlock()
