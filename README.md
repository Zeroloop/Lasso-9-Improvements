Lasso-9-Improvements
====================

Public repository for general Lasso 9 improvements / extensions

file.lasso
----------
file->getattr(name) — get extended file attribute
file->setattr(name = value) — set extended file attribute

image.lasso
-----------
image->ishex(hex::string) — returns true if image is just specified colour
image->isblack — returns true if image is just black
image->iswhite — returns true if image is just white

string.lasso
------------
string->ascii — returns only the ascii characters in a string

thread.lasso
------------
every — active_tick limiter

web_request.lasso
-----------------
getparams
postparams
getparam('name')
postparam('name')