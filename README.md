# ML-KMeans-ImageCompression
In this project, you will apply K-means to image compression. In a straightforward 24-bit color representation of an image, each pixel is represented as three 8-bit unsigned integers (ranging from 0 to 255) that specify the red, green and blue intensity values. This encoding is often refered to as the RGB encoding. Our image contains thousands of colors, and in this project, I will reduce the number of colors to 16 colors. By making this reduction, it is possible to represent (compress) the photo in an efficient way. 

I will use the K-means algorithm to select the 16 colors that will be used to represent the compressed image. Concretely, I will treat every pixel in the original image as a data example and use the K-means algorithm to find the 16 colors that best group (cluster) the pixels in the 3-dimensional RGB space. Once I have computed the cluster centroids on the image, I will then use the 16 colors to replace the pixels in the original image.

## K-means on pixels
The code below first loads the image, and then reshapes it to create an m by 3 matrix of pixel colors (where ), and calls your K-means function on it.

```
%  Load an image of a bird
A = double(imread('bird_small.png'));
A = A / 255; % Divide by 255 so that all values are in the range 0 - 1

% Size of the image
img_size = size(A);
```

Reshape the image into an Nx3 matrix where N = number of pixels. Each row will contain the Red, Green and Blue pixel values. This gives us our dataset matrix X that we will use K-Means on.
```
X = reshape(A, img_size(1) * img_size(2), 3);
```

Run the K-Means algorithm on this data. I tried different values of K and max_iters here:
```
K = 16;
max_iters = 10;
```

When using K-Means, it is important the initialize the centroids randomly
```
initial_centroids = kMeansInitCentroids(X, K);
% Run K-Means
[centroids, ~] = runkMeans(X, initial_centroids, max_iters);
```

The new representation requires some overhead storage in form of a dictionary of 16 colors, each of which require 24 bits, but the image itself then only requires 4 bits per pixel location. The final number of bits used is therefore  bits, which corresponds to compressing the original image by about a factor of 6. 
```
% Find closest cluster members
idx = findClosestCentroids(X, centroids);
```

Finally, I viewed the effects of the compression by reconstructing the image based only on the centroid assignments. Specically, I replaced each pixel location with the mean of the centroid assigned to it. Even though the resulting image retains most of the characteristics of the original, we also see some compression artifacts. Essentially, now I have represented the image X as in terms of the indices in `idx`. I can now recover the image from the indices `(idx)` by mapping each pixel (specified by it's index in `idx`) to the centroid value.
```
% Reshape the recovered image into proper dimensions
X_recovered = reshape(X_recovered, img_size(1), img_size(2), 3);

% Display the original image 
figure;
subplot(1, 2, 1);
imagesc(A); 
title('Original');
axis square

% Display compressed image side by side
subplot(1, 2, 2);
imagesc(X_recovered)
title(sprintf('Compressed, with %d colors.', K));
axis square
```
