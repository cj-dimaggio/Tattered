#include "ofMain.h"
#include "ofApp.h"

// A bit of a dirty hack to make the latest ios release of openFrameworks
// compile for the ios simulator
extern "C"{
    size_t fwrite$UNIX2003( const void *a, size_t b, size_t c, FILE *d )
    {
        return fwrite(a, b, c, d);
    }
    char* strerror$UNIX2003( int errnum )
    {
        return strerror(errnum);
    }
    time_t mktime$UNIX2003(struct tm * a)
    {
        return mktime(a);
    }
    double strtod$UNIX2003(const char * a, char ** b) {
        return strtod(a, b);
    }
}

int main(){
    /**
     This is the default created by openFrameworks project creator and appears in iOS
     example projects but possibly should be changed for OpenGl ES
     The latest version of openFrameworks on github's master branch appears to have a much
     more robust iOS initialization procedure but pulling in the complete repo as a
     submodule would make this project multiple gigs
    **/
    ofSetupOpenGL(1024,768, OF_FULLSCREEN);			// <-------- setup the GL context
    
    ofRunApp(new ofApp);
}
