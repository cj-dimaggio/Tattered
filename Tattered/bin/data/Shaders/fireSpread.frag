precision highp float;

// The texture that openFrameworks just drew
uniform sampler2D tex0;

// Our randomly generated noise texture for PRNG
uniform sampler2D noiseTex;

// Needed to determin adjacent texels
uniform vec2 texSize;

// OpenGl-ES equivalent of 'gl_texcoord', passed in from
// the vert shader
varying vec2 texCoordVarying;

// CONSTANTS
const float THRESHOLD = 0.5;
const int THICKNESS = 2;
const vec4 BLACK = vec4(1, 1, 1, 1);
const vec4 RED = vec4(1, 0, 0, 1);
const vec4 GREEN = vec4(0, 1, 0, 1);
const vec4 BLUE = vec4(0, 0, 1, 1);

vec4 getPixel(vec2 coords) {
    return texture2D(tex0, texCoordVarying + coords);
}

/** 
 It is costly to do this operation several times for every pixel and the
 results should be constant anyway. Factor out into CPU and send in via
 a uniform vec2 (We will need n of these variables based on thickness = n)
 **/
vec2 getOffSet(int offSetX, int offSetY) {
    return vec2(float(offSetX)/texSize.x, float(offSetY)/texSize.y);
}

/**
 Perhaps more GPU intensive than an in shader PRNG but using openFrameworks perlin-like
 random noise generator is much more truly random than any one liner hashing function
 I could put inside this shader. Also, it will only be called when we already know we
 are a black texel adjacent to a red texel and will never even be touched in any other
 case. In terms of optimization, we should probably look elsewhere.
**/
float rand(int offSetX, int offSetY) {
    return texture2D(noiseTex, texCoordVarying + getOffSet(offSetX, offSetY)).x;
}

void main()
{
    vec4 color = texture2D(tex0, texCoordVarying);
    
    /**
     We are trying to find the edges where the blank, 'unburnt', parts
     of the texture abut a red, 'on fire', texel
     **/
    if(color.rgb != RED.rgb && color.rgb != BLUE.rgb) {
        for(int i = 0; i <= THICKNESS; i++) {
            /**
             Each one of these queries the texture which is a,
             relativly, costly call. Splitting this up to an
             horizantal shader and a vertical shader might quicken
             this up.
             **/
            
            /**
             We want the fire to spread, so we check if we are next to
             a red texel and, if we are, randomly spread or stop
            **/
            if (getPixel(getOffSet(i, 0)).rgb == RED.rgb) {
                if(rand(1, 0) > THRESHOLD) {
                    color = GREEN;
                }
            }
            if (getPixel(getOffSet(-i,0)).rgb == RED.rgb) {
                if(rand(-1, 0) > THRESHOLD) {
                    color = GREEN;
                }
            }
            if (getPixel(getOffSet(0, i)).rgb == RED.rgb) {
                if(rand(0, 1) > THRESHOLD) {
                    color = GREEN;
                }
            }
            if (getPixel(getOffSet(0, -i)).rgb == RED.rgb) {
                if(rand(0, -1) > THRESHOLD) {
                    color = GREEN;
                }
            }
        }
        
    }
    
    // Set the color the gpu should use to render this fragment as
    gl_FragColor = color;
}
