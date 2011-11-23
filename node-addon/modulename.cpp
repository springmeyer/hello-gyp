#include <node.h>

// C standard library
#include <string>

using namespace v8;

Handle<Value> Hello(const Arguments& args) {
    HandleScope scope;
    std::string hellostring("hello");
    return scope.Close(String::New(hellostring.c_str()));
}

void RegisterModule(Handle<Object> target) {
    target->Set(String::NewSymbol("hello"),
        FunctionTemplate::New(Hello)->GetFunction());
}

NODE_MODULE(modulename, RegisterModule);
