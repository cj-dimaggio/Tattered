precision highp float;

// The texture that openFrameworks just drew
uniform sampler2D tex0;

// OpenGl-ES equivalent of 'gl_texcoord', passed in from
// the vert shader
varying vec2 texCoordVarying;

const vec4 BLACK = vec4(1, 1, 1, 1);
const vec4 RED = vec4(1, 0, 0, 1);
const vec4 GREEN = vec4(0, 1, 0, 1);
const vec4 BLUE = vec4(0, 0, 1, 1);

void main()
{
    vec4 color = texture2D(tex0, texCoordVarying);
    
    if (color.r > 0.0) {
        color = BLUE;
    }
    
    if (color.g > 0.0) {
        color = RED;
    }
    
    gl_FragColor = color;
}
