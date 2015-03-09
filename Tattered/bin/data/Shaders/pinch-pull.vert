uniform mat4 modelViewProjectionMatrix;
uniform sampler2D tex0;

uniform vec2 midPoint;
uniform float pullForce;

attribute vec4 position;
attribute vec2 texcoord;

// Pass the texture coords to the frag shader
varying vec2 texCoordVarying;

void main(){
    texCoordVarying = texcoord;
    
    vec4 pos = position;
    
    vec2 dir = pos.xy - midPoint;
    
    float dist =  distance(pos.xy, midPoint);
    
    if(dist > 0.0 && dist < abs(pullForce)) {
        
        float distNorm = dist / abs(pullForce);
        
        distNorm = 1.0 - distNorm;
        
        dir *= distNorm * .5;
        
        if (pullForce > 0.0) {
            pos.x += dir.x;
            pos.y += dir.y;
        } else if (pullForce < 0.0) {
            pos.x -= dir.x;
            pos.y -= dir.y;
        }
    }
    
    gl_Position = modelViewProjectionMatrix * pos;
}