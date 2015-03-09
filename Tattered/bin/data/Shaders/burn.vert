uniform mat4 modelViewProjectionMatrix;
uniform sampler2D tex0;

attribute vec4 postion;
attribute vec2 texcoord;

// Pass the texture coords to the frag shader
varying vec2 texCoordVarying;

void main(){
    texCoordVarying = texcoord;
    gl_Position = modelViewProjectionMatrix * postion;
}