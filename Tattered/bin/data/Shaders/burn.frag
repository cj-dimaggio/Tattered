precision highp float;

// The texture that openFrameworks just drew
uniform sampler2D tex0;

// The fire texture we passed in
uniform sampler2D fireTex;

// Our randomly generated noise texture for PRNG
uniform sampler2D noiseTex;

// OpenGl-ES equivalent of 'gl_texcoord', passed in from
// the vert shader
varying vec2 texCoordVarying;

float rand() {
    return texture2D(noiseTex, texCoordVarying).x;
}

void main()
{
    vec4 color = texture2D(tex0, texCoordVarying);
    vec4 fireColor = texture2D(fireTex, texCoordVarying);
    
    if  (fireColor.b > 0.0) {
        float random = rand() * 5.0;
        color.r -= random;
        color.g -= random;
        color.b -= random;
    } else if (fireColor.r > 0.0) {
        float random = rand();
        color.r += random;
    }
        
    gl_FragColor = color;
}
