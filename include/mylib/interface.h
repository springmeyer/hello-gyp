#ifndef INCLUDE_MYAPP_H_
#define INCLUDE_MYAPP_H_

#include <string>

namespace MyLib {

class Message {
 public:
    explicit Message(std::string const& data);
    std::string const& get();
    void set(std::string const& data);

 private:
    std::string m_data;
};

};

#endif  // INCLUDE_MYAPP_H_
