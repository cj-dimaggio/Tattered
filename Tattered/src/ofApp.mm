#include "ofApp.h"

// The image we will actually be manipulating
/**
 This whole application should really be a more traditional iOS app, with
 a delegate being triggered with a view controller etc.. so that a user
 can upload their own photo from their photo album, but this is more of 
 a proof-of-concept
**/
ofImage baseImage;
// Texture to be used to generate random values within shaders
ofImage noise;

// The shader responsible for randomly growing the burning area
ofShader fireSpreadShader;

// This shader has the simple task of turning green texels
// to RED and RED texels to blue
ofShader fireCoolShader;

// Make sure texture maps correctly
ofShader mapper;

ofFbo fireBuffer1;
ofFbo fireBuffer2;

// The final fire texture
ofFbo fireTexture;


// User interaction variables
bool touching = false;

float cX;
float cY;

void generateFireTexture() {
    fireBuffer1.begin();
    
    // Draw the previous texure we generate so the fire
    // will actually grow
    mapper.begin();
    fireTexture.draw(0, 0);
    mapper.end();
    
    if (touching) {
        ofSetColor(255, 0, 0);
        ofCircle(cX, cY, 4);
    }
    fireBuffer1.end();
    
    /**
     The general proccess I'll be trying to follow
     for generating the burn shader is:
     * User drawn areas are classified as burning (RED)
     * RED texels can spread, and are inserted as GREEN
     * RED texels turn BLUE (Totally burnt) and don't spread
     * GREEN texels turn RED, and can cary on the burn until
     all are extinguished
     **/
    // This shader spread the burning (texels ajacent to RED texels might become green)
    fireSpreadShader.begin();
    fireSpreadShader.setUniform2f("texSize", fireBuffer1.getHeight(), fireBuffer1.getHeight());
    fireSpreadShader.setUniformTexture("noiseTex", noise.getTextureReference(), 1);
    
    // Draw this into the second buffer so we can do a second shader pass
    fireBuffer2.begin();
    fireBuffer1.draw(0, 0);
    fireBuffer2.end();
    fireSpreadShader.end();
    
    // The second pass
    fireCoolShader.begin();
    fireTexture.begin();
    fireBuffer2.draw(0, 0);
    fireTexture.end();
    fireCoolShader.end();
}

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
    
    fireSpreadShader.load("Shaders/fireSpread");
    fireCoolShader.load("Shaders/fireCool");
    mapper.load("Shaders/map");
    
    fireBuffer1.allocate(ofGetWidth(), ofGetHeight());
    fireBuffer2.allocate(ofGetWidth(), ofGetHeight());
    fireTexture.allocate(ofGetWidth(), ofGetHeight());
    
    // Zero out the buffers
    fireBuffer1.begin();
    ofClear(0, 0, 0, 0);
    fireBuffer1.end();
    
    fireBuffer2.begin();
    ofClear(0, 0, 0, 0);
    fireBuffer2.end();
    
    fireTexture.begin();
    ofClear(0, 0, 0, 0);
    fireTexture.end();

    // Randomly generate the noise texture
    noise.allocate(ofGetWidth(), ofGetHeight(), OF_IMAGE_GRAYSCALE);
    
    unsigned char * pixels = noise.getPixels();
    int width = noise.getWidth();
    int height = noise.getHeight();
    for(int y=0; y<height; y++) {
        for(int x=0; x<width; x++) {
            int i = y * width + x;
            pixels[i] = 255 * ofNoise(x, y);
        }
    }
    noise.update();

}

//--------------------------------------------------------------
void ofApp::update(){
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    generateFireTexture();
    
    mapper.begin();
    fireTexture.draw(0,0);
    mapper.end();
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    touching = true;
    cX = touch.x;
    cY = touch.y;
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    touching = true;
    cX = touch.x;
    cY = touch.y;
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    touching = false;

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    touching = false;
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
