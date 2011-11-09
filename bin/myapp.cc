#include <mylib/interface.h>

#include <string>
#include <iostream>

int main(int argc, char **argv) {
    MyLib::Message msg("hello");
    std::cout << msg.get() << "\n";
    return 0;
}
