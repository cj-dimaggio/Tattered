#include "ofApp.h"

ofImage baseImage;

void scaleImageToFit(ofImage* image) {
    // The picture is in portrait and we should determain the scale ratio based on this
    if(image->height > image->width) {
        double scaleRatio = (double) ofGetScreenHeight() / image->height;
        image->resize(image->width * scaleRatio, ofGetScreenHeight());
    } else {
    // Otherwise, we are in landscape (or technically, a perfect square, in which case it shouldn't
    // matter) so we scale based on the width
        double scaleRatio = ofGetScreenWidth() / image->width;
        image->resize(ofGetScreenWidth(), image->height * scaleRatio);
    }
}

//--------------------------------------------------------------
void ofApp::setup(){
    baseImage.loadImage("images/stock-photo.jpg");
    scaleImageToFit(&baseImage);
}

//--------------------------------------------------------------
void ofApp::update(){
}

//--------------------------------------------------------------
void ofApp::draw(){
    baseImage.draw(0, 0);
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    NSLog(@"Touch down!");
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    NSLog(@"Touch moved!");
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    NSLog(@"Touch up!");
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    NSLog(@"Double Tap!");
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
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
