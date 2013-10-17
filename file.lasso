<?lassoscript


/*  ---------------------------------------------------------------
//
//  Extended file attributes
//
//  Reference: http://en.wikipedia.org/wiki/Extended_file_attributes
*/
 
 
define file->getattr(name::string,silent::boolean=true) => {
    //  Linux / OSX only, adjust getfattr path accordingly
    //  Example usage:  file->getattr('user.checksum')
     
    local(t = micros)
     
    local(
        p = sys_process('/usr/bin/getfattr',staticarray('--only-values','-n',#name,file_forceroot(.path)->replace('//','/')&))->wait &,
        e = #p->readerror,
        s = #p->readstring
    )
     
    handle => {#p->close}
 
    not #silent && #e && #e !>> `leading '/'` ? fail(-1,#e->asstring)
 
    return  #s || #e
}

define file->setattr(name::string,value::string,silent::boolean=true) => {
    //  Linux / OSX only, adjust setfattr path accordingly
    //  Namespaces:     user, trusted, security and system 
    //  Example usage:  file->setattr('user.checksum','xyz')
 
    local(
        p = sys_process('/usr/bin/setfattr',staticarray('-n',#name,'-v',#value,file_forceroot(.path)->replace('//','/')&))->wait &,
        e = #p->readerror,
        s = #p->readstring
    )
 
    handle => {#p->close}
     
    not #silent && #e ? fail(-1,#e->asstring)
        return  #s
}
 
define file->setattr(p::pair,...) => {
    //  Example usage:  file->setattr('user.checksum'='xyz','user.example'='abc')
    .setattr(#p->name,#p->value)
    with p in #rest do {
        #p->isa(::pair) ? .setattr(#p->name,#p->value)
    }
}


?>