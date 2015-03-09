#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

/**
 This whole application should really be a more traditional iOS app, with
 a delegate being triggered with a view controller etc.. so that a user
 can upload their own photo from their photo album, but this is more of
 a proof-of-concept
 **/

class ofApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
        void generateFireTexture();
    
    // The image we will actually be manipulating
    ofImage baseImage;
    
    // The UV plane for the image
    ofPlanePrimitive imagePlane;
    
    // Texture to be used to generate random values within shaders
    ofImage noise;
    
    // The shader responsible for randomly growing the burning area
    ofShader fireSpreadShader;
    
    // This shader has the simple task of turning green texels
    // to RED and RED texels to blue
    ofShader fireCoolShader;
    
    // This is the shader that actually applies the fire texture to the photo
    ofShader burnShader;
    
    // Do some simple pinch and pull effects just for fun
    ofShader pinchShader;
    
    // Make sure texture maps correctly
    ofShader mapper;
    
    ofFbo fireBuffer1;
    ofFbo fireBuffer2;
    
    // The final fire texture
    ofFbo fireTexture;
    
    // The texture of the manipulated image
    ofFbo imageBurnt;
    
    // User interaction variables
    bool singletouch = false;
    bool twoTouch = false;
    bool moved = false;
    
    // for one finger touches
    float cX;
    float cY;
    
    // for two finger touches
    float cX1Start;
    float cY1Start;
    float cX2Start;
    float cY2Start;
    
    float cX1Current;
    float cY1Current;
    float cX2Current;
    float cY2Current;
    
    ofVec2f midPoint;
    float pullForce;
};


