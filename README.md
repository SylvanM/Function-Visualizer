# Function-Visualizer
iOS/iPad OS/macOS tool for visualizing complex functions, or any function that maps a 2D field to another.

This visualization method is based on [this video by 3Blue1Brown.](https://www.youtube.com/watch?v=b7FxPsqfkOY)

## What is this thing?

Great question! This is a tool that visualizes functions mapping a two dimensional plane to another two dimensional plane. This could be R2 -> R2, or C -> C.

### Notation

I'm not sure if there's already a convention for these sorts of functions, but I'm going to say that "(x,y) -> ( f(x), g(y) )" denotes a function that maps a point (x, y) to the point ( f(x), g(y) ) where f and g map R -> R.

### Visualization method

As said before, I'm going based off the 3b1b video, but here is a brief summary. Each "output point" is treated as a vector. The final "graph" of the function will be a plane where every point's color represents its output point. The "colors" of these output points are determined as follows:

1. Overlay the output point as a vector over a hue circle. Whichever hue it points to is the hue of this point.
2. The brightness of the point is determined by the magnitude of the vector (higher magnitude means a more intense color)
3. Do this for every point on the output plane

## Here are some pretty examples! (and some interesting properties I noticed)

