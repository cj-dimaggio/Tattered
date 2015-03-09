precision highp float;

// The texture that openFrameworks just drew
uniform sampler2D tex0;

// OpenGl-ES equivalent of 'gl_texcoord', passed in from
// the vert shader
varying vec2 texCoordVarying;

void main()
{
    vec4 color = texture2D(tex0, texCoordVarying);
    
    gl_FragColor = color;
}
