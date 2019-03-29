#include <iostream>
#include <sstream>

#include <pugixml.hpp>


using namespace std;
namespace xml = pugi;


const string str_xml =
"<html>"
	"<body>"
		"<p>Hello world</p>"
	"</body>"
"</html>"
;


int
main(void)
{
	xml::xml_document doc;
	doc.load(str_xml.c_str());
	cout << doc.child("html").child("body").child("p").first_child()
		.value() << '\n';

	return 0;
}
