extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_blur_image(pixels, size, sigma):
	
	# Apply the 1-dimensional blur in the horizontal direction
	var blurred_pixels_h = Filters.gaussian_blur_1d(pixels, size, sigma, 'horizontal')
	# Apply the 1-dimensional blur in the vertical direction
	var blurred_pixels_v = Filters.gaussian_blur_1d(blurred_pixels_h, size, sigma, 'vertical')
	return blurred_pixels_v
	# Transpose the image back to its original orientation
	var blurred_pixels = []
	for y in range(size.y):
		for x in range(size.x):
			blurred_pixels.append(blurred_pixels_v[y + x * size.y])
	# Return the blurred image
	return blurred_pixels

func _on_Button_pressed():
	$FileDialogBase.popup()
 
func apply_threshold(image, threshold):
	var image_sizes = image.get_size()
	image.lock()
	for y in range(image_sizes.y):
		for x in range(image_sizes.x):
			var value = image.get_pixel(x, y).r
			if value < threshold:
				image.set_pixel(x, y, Color(0,0,0,1))

func set_blur_image(image):
	var image_sizes = image.get_size()
	image.lock()
	var pixels = []
	var pixels_2 = []
	for y in range(image_sizes.y):
		for x in range(image_sizes.x):
			pixels.append(image.get_pixel(x,y).r)
			pixels_2.append(image.get_pixel(x,y).r)
	image.unlock()
	var blur_image = Image.new()
	var blur_data = get_blur_image(pixels, image_sizes, 0.5)
	var blur_data_2 = get_blur_image(pixels_2, image_sizes, 20)
	blur_image.copy_from(image)
	blur_image.lock()
	var sum = 0
	for y in range(image_sizes.y):
		for x in range(image_sizes.x):
			var r = abs(blur_data_2[x + y*image_sizes.x] - blur_data[x + y*image_sizes.x])
			sum += r

			blur_image.set_pixel(x, y, Color(r, r, r, 1.0) )
	blur_image.unlock()
	#apply_threshold(blur_image, sum/(image_sizes.x * image_sizes.y))
	var tex_blur = ImageTexture.new()
	tex_blur.create_from_image(blur_image, 0)
	$BlurImg.texture = tex_blur


func _on_FileDialog_file_selected(path):
	var image = Image.new()
	var image_blur = Image.new()
	image_blur.load(path)
	var gray_image = Filters.generate_grayscale(image_blur)
	Filters.create_histogram(gray_image)
	var texture_gray = ImageTexture.new()
	texture_gray.create_from_image(gray_image, 0)
	$GrayImg.texture = texture_gray
	set_blur_image(gray_image)
	image.load(path)
	var texture = ImageTexture.new()
	texture.create_from_image(image, 0)
	#$SpriteBaseImage.texture = texture
		


			


func _on_ButtonPaper_pressed():
	$FileDialogPaper.popup()

func _on_ButtonInk_pressed():
	$FileDialogInk.popup()


func _on_FileDialogPaper_file_selected(path):
	var image = Image.new()
	image.load(path)
	var texture = ImageTexture.new()
	texture.create_from_image(image, 0)
	$SpritePaper.texture = texture


func _on_FileDialogInk_file_selected(path):
	var image = Image.new()
	image.load(path)
	var texture = ImageTexture.new()
	texture.create_from_image(image, 0)
	$SpriteInk.texture = texture


# As a method to enhance contrast, may keep only the greyscale image from Filters
func equalize_histogram(image):
	# Get the size of the image
	var size = image.get_size()

	# Compute the histogram of the image
	var histogram = []
	for i in range(1, 256):
		histogram[i] = 0
	image.lock()
	for y in range(size.y):
		for x in range(size.x):
			var color = image.get_pixel(x,y)
			histogram[int(color.r * 255)] += 1

	# Compute the cumulative histogram
	var cumulative_histogram = []
	cumulative_histogram[0] = histogram[0]
	for i in range(1, 256):
		cumulative_histogram[i] = cumulative_histogram[i - 1] + histogram[i]

	# Normalize the cumulative histogram
	var normalization_factor = size.x * size.y
	for i in range(256):
		cumulative_histogram[i] = cumulative_histogram[i] / normalization_factor * 255

	# Create a new image to store the equalized histogram data
	var equalized_image = Image.new()
	equalized_image.create(size.x, size.y, false, Image.FORMAT_RGBA8)
	equalized_image.lock()
	# Apply the cumulative histogram transformation to each pixel
	var i = 0
	for y in range(size.y):
		for x in range(size.x):
			var color = image.get_pixel(x,y)
			var equalized_intensity = cumulative_histogram[color.r]
			equalized_image.set_pixel(i % size.x, i / size.x, Color(equalized_intensity, equalized_intensity, equalized_intensity, color.a))
			i += 1

	# Return the equalized image
	return equalized_image
